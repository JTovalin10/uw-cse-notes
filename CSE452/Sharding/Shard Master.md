# CSE452: The Shard Master

The **[[CSE452/Sharding/Definitions/ShardMaster|ShardMaster]]** manages a sequence of numbered **[[CSE452/Sharding/Definitions/Configuration|Configurations]]** (starting with `INITIAL_CONFIG_NUM`). It acts as the "source of truth" for the distributed system, deciding which **[[CSE452/Sharding/Definitions/Replica Group|Replica Group]]** should serve each **[[CSE452/Sharding/Definitions/Shard|Shard]]**.

## Core Operations

The Shard Master runs as a [[CSE452/RPC/Deterministic State Machine|Replicated State Machine]] using [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]], ensuring linearizability and fault tolerance for configuration changes.

### 1. Join
- **Input**: Unique `groupId` and a set of server addresses.
- **Mechanism**: Creates a new configuration including the new group.
- **Rebalancing**: Shards are redistributed as evenly as possible. The master must move the minimum number of shards to achieve balance.

### 2. Leave
- **Input**: `groupId` of an existing group.
- **Mechanism**: Creates a new configuration excluding the group.
- **Rebalancing**: The shards previously owned by the leaving group are reassigned to the remaining groups, again maintaining balance with minimal movement.

### 3. Move
- **Input**: `shardNum` and `groupId`.
- **Mechanism**: Manually assigns a specific shard to a specific group. 
- **Purpose**: Primarily used for testing and manual load balancing. Subsequent `Join` or `Leave` operations may undo a manual `Move` during rebalancing.

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

The ShardMaster is not a single point of failure; it is a **[[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] cluster**.

- **Safety**: Every change (`Join`, `Leave`, `Move`) is proposed as a command to the Paxos log. No configuration is considered "official" until it has been chosen by a majority of the ShardMaster nodes.
- **Linearizability**: Because the ShardMaster uses Paxos, it guarantees that all clients see configuration changes in the same total order. A `Query(-1)` sent after a `Join` completes is guaranteed to see the results of that `Join`.
- **Read-Only Optimization**: `Query` operations do not strictly need to be proposed to the Paxos log if the system uses **Leases** or a similar mechanism to ensure the master node is still the authoritative leader. However, for Lab 4, proposing `Query` as a non-AMO command is a safe way to ensure linearizability.

## Rebalancing vs. Manual Moves
- **Move Persistence**: A manual `Move` is a "hint" that remains until a structural change (Join/Leave) triggers a rebalance. The ShardMaster should prioritize the explicit manual assignment unless a rebalance is necessary to maintain the "even distribution" invariant.

## Configuration Lifecycle

1.  **Initialization**: Before the first `Join` is successfully executed, the result of any `Query` should be `Error` instead of a `ShardConfig` object.
2.  **Activation**: The very first configuration, created when the first `Join` completes, is numbered `INITIAL_CONFIG_NUM`.
3.  **Evolution**: Each subsequent modification (Join, Leave, Move) creates a new configuration with an incremented number.

## Implementation Notes
- **Complexity**: A typical solution for Part 1 takes approximately 200 lines of code.
- **Determinism**: The rebalancing algorithm must be strictly deterministic so all Paxos replicas arrive at the same configuration mapping.

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
- [[CSE452/Sharding/Sharding|Sharding Overview]] — the architecture the Shard Master coordinates
- [[CSE452/Sharding/Definitions/ShardMaster|ShardMaster (Definition)]] — glossary entry
- [[CSE452/Sharding/Reconfiguration|Reconfiguration]] — how groups react to new configurations
- [[CSE452/Sharding/Sharded Key-Value Server|Sharded Key-Value Server]] — the groups the Shard Master assigns shards to
- [[CSE452/Primary-Backup/View Server|View Server]] — the single-partition ancestor of the Shard Master
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — the consensus engine making the Shard Master fault-tolerant
