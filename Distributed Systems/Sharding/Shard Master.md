# CSE452: The Shard Master

The **[[ShardMaster|ShardMaster]]** manages a sequence of numbered **[[Configuration|Configurations]]** (starting with `INITIAL_CONFIG_NUM`). It acts as the "source of truth" for the distributed system, deciding which **[[Replica Group|Replica Group]]** should serve each **[[Shard|Shard]]**.

## Core Operations

The Shard Master runs as a [[Deterministic State Machine|Replicated State Machine]] using [[Multi-Paxos|Multi-Paxos]], ensuring linearizability and fault tolerance for configuration changes.

### 1. Join
- **Input**: An integer `groupId` (must be unique) and a set of server addresses for the new group.
- **Mechanism**: Creates a new configuration including the new group. The first successful `Join` produces configuration `INITIAL_CONFIG_NUM` (0), which assigns **all shards** to that first group. Before any `Join` completes, the system is at version -1 and any `Query` returns `Error`.
- **Rebalancing**: Shards are redistributed as evenly as possible. The master must move the **minimum number of shards** to achieve balance — avoid unnecessarily migrating shards that are already balanced.
- **Returns**: `Ok` on success. `Error` if the `groupId` already exists in the current configuration (non-unique).

### 2. Leave
- **Input**: `groupId` of an existing group.
- **Mechanism**: The opposite of `Join` — removes the group from the system and creates a new configuration excluding it. The leaving group's shards are redistributed to the remaining groups.
- **Rebalancing**: Redistributes the departing group's shards across the remaining groups with minimal movement — the same "move as few shards as possible" constraint as `Join`.
- **Returns**: `Ok` on success. `Error` if the current configuration does not contain the specified group, or if the final remaining group is attempting to leave (the system would have no groups — though this case is not actually tested).

### 3. Move
- **Input**: `shardNum` (the shard to relocate) and `groupId` (the destination group ID).
- **Mechanism**: Manually reassigns a specific shard from its current group to the specified destination group, creating a new configuration.
- **Purpose**: Used for testing and for manually isolating hot keys — in practice, if one shard receives disproportionate traffic, it can be moved to a less-loaded, dedicated group. A subsequent `Join` or `Leave` may undo the manual assignment during automatic rebalancing.
- **Returns**: `Ok` on success. `Error` if the current configuration does not contain the target group, or if the target group already owns the specified shard.

### 4. Query
- **Input**: Configuration number `n`.
- **Output**: The `ShardConfig` object for version `n`.
- **Special Case**: If `n` is -1 or greater than the largest known configuration number, the ShardMaster must reply with the **latest configuration**.
- **Timing**: The result of `Query(-1)` should reflect every `Join`, `Leave`, or `Move` that completed before the `Query(-1)` was sent.

## Deep Dive: The Rebalancing Algorithm

The ShardMaster must redistribute shards deterministically and with minimal movement. A common algorithmic approach follows these steps:

1.  **Group Mapping**: Identify all active groups in the new configuration.
2.  **Identify Imbalance**:
    - Calculate the target number of shards per group (e.g., $TotalShards / NumGroups$).
    - Groups with more than the target are "Overloaded"; groups with fewer are "Underloaded."
3.  **Iterative Migration**:
    - Repeatedly find the group with the **maximum** number of shards and the group with the **minimum** number.
    - Move one shard from the maximum group to the minimum group.
    - Continue until the difference between the maximum and minimum shard counts is $\leq 1$.
4.  **Deterministic Tie-Breaking**: To ensure all Paxos replicas reach the same configuration, tie-breaks (e.g., when multiple groups have the same shard count) must be handled consistently, such as by sorting groups by their `groupId`.

## Fault Tolerance & Linearizability

The ShardMaster is not a single point of failure; it is a **[[Multi-Paxos|Multi-Paxos]] cluster**.

- **Safety**: Every change (`Join`, `Leave`, `Move`) is proposed as a command to the Paxos log. No configuration is considered "official" until it has been chosen by a majority of the ShardMaster nodes.
- **Linearizability**: Because the ShardMaster uses Paxos, it guarantees that all clients see configuration changes in the same total order. A `Query(-1)` sent after a `Join` completes is guaranteed to see the results of that `Join`.
- **Read-Only Optimization**: `Query` operations do not strictly need to be proposed to the Paxos log if the system uses **Leases** or a similar mechanism to ensure the master node is still the authoritative leader. However, for Lab 4, proposing `Query` as a non-AMO command is a safe way to ensure linearizability.

## Rebalancing vs. Manual Moves
- **Move Persistence**: A manual `Move` is a "hint" that remains until a structural change (Join/Leave) triggers a rebalance. The ShardMaster should prioritize the explicit manual assignment unless a rebalance is necessary to maintain the "even distribution" invariant.

## Configuration Lifecycle

1.  **Initialization**: Before the first `Join` is successfully executed, the system is at version -1. Any `Query` at this point returns `Error` instead of a `ShardConfig`.
2.  **Activation**: The very first configuration, created when the first `Join` completes, is numbered `INITIAL_CONFIG_NUM` (0). All shards are assigned to that single group.
3.  **Evolution**: Each subsequent modification (`Join`, `Leave`, `Move`) creates a new configuration with a monotonically increasing number.

### Concrete Join/Leave Example

The following traces a 10-shard system through a sequence of membership changes. Yellow highlights indicate newly redistributed shards:

| Operation | Config # | Shard → Group mapping |
| :--- | :---: | :--- |
| *(initial state)* | -1 | All shards: `null` — `Query` returns `Error` |
| `Join(1)` | 0 | All 10 shards → Group 1 |
| `Join(2)` | 1 | Shards 1–5 → Group 1; Shards 6–10 → Group 2 |
| `Join(5)` | 2 | Shards 1–3 → Group 1; Shards 6–9 → Group 2; Shards 4, 5, 10 → Group 5 |
| *(several more Join/Leave ops...)* | 9 | Diverse distribution across Groups 1, 2, 4, 5, 6, 7 |
| `Leave(1)` | 10 | Group 1's shards (1, 2) redistributed: Shard 1 → Group 5; Shard 2 → Group 4 |

Key observations:
- When the first group joins, it receives all shards immediately (zero migration cost).
- When a second group joins, exactly half the shards move — the minimum required for balance.
- When a group leaves, **only its shards** are redistributed; all other shard assignments remain unchanged.

## Implementation Notes
- **Complexity**: A typical solution for Part 1 takes approximately 200 lines of code.
- **Determinism**: The rebalancing algorithm must be strictly deterministic so all Paxos replicas arrive at the same configuration mapping.
- **Deep Copy**: When computing the next configuration, always make a **deep copy** of the previous configuration before modifying it. Mutating the stored history in-place corrupts past configurations, which the ShardMaster must retain for `Query`.
- **Instantiation**: The ShardMaster is an `Application` running within a `PaxosServer`, not a standalone server:
  ```java
  new PaxosServer(address, shardMasters.clone(), new ShardMaster(numShards));
  ```
  Lab 4.1 (the ShardMaster itself) does not depend on Paxos — some tests use Paxos groups of size 1, which lets you test ShardMaster logic in isolation.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Shard Master / ShardMaster** | Configuration service / control plane (e.g. ZooKeeper, etcd) |
| **Configuration** | Cluster topology / shard map |
| **Join / Leave** | Scale-out / scale-in membership change |
| **Rebalancing** | Shard rebalancing / load balancing |
| **Query(-1)** | Latest-configuration read |

---

## Related
- [[Sharding|Sharding Overview]] — the architecture the Shard Master coordinates
- [[ShardMaster|ShardMaster (Definition)]] — glossary entry
- [[Reconfiguration|Reconfiguration]] — how groups react to new configurations
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — the groups the Shard Master assigns shards to
- [[View Server|View Server]] — the single-partition ancestor of the Shard Master
- [[Multi-Paxos|Multi-Paxos]] — the consensus engine making the Shard Master fault-tolerant
