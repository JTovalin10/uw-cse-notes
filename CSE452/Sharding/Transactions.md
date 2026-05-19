# CSE452: Transactions

To support operations that involve multiple keys across different [[CSE452/Sharding/Definitions/Shard|shards]] (and potentially different [[CSE452/Sharding/Definitions/Replica Group|replica groups]]), the system implements **Two-Phase Commit (2PC)** with distributed locking. For the motivation behind 2PC — the failure modes of the naive cross-group swap protocol — see [[CSE452/Sharding/Two-Phase Commit|Two-Phase Commit: Motivation]].

## The Problem: Cross-Group Atomicity

In a sharded system, single-key operations are handled within a single Paxos group. However, a multi-key operation like `Swap(K1, K2)` may involve two different groups.
- Without coordination, Group A might commit its half of the swap while Group B fails or lags, leaving the system in an inconsistent state.
- **Solution**: Use **Two-Phase Commit** to ensure the operation either happens at all participating groups or at none.

## Two-Phase Commit (2PC) Protocol

1.  **Transaction Coordinator**: One group (usually the one receiving the client request) acts as the coordinator. It is responsible for driving the 2PC state machine to completion.
2.  **Phase 1: Prepare**
    - The coordinator sends a `Prepare` request to all participating groups.
    - Each participant attempts to acquire **Distributed Locks** for the keys involved.
    - If a participant can lock the keys and is ready to commit, it responds `Prepared`. Otherwise, it responds `Abort`.
3.  **Phase 2: Commit/Abort**
    - If **all** participants responded `Prepared`, the coordinator sends a `Commit` message to everyone.
    - If **any** participant responded `Abort` (or timed out), the coordinator sends an `Abort` message.
    - Participants apply the changes (if committed), release locks, and acknowledge.

### Locking Mechanisms
To ensure serializability, servers must implement a locking discipline:
- **Read Locks**: Allow multiple concurrent readers but block writers.
- **Write Locks**: Exclusive access; block both other readers and writers.
- **Implementation**: Locks are held from the moment a `Prepare` is accepted until the `Commit` or `Abort` is processed. In a sharded environment, these locks are **held in the state machine**, meaning they are replicated via Paxos across the group.

### Differentiation & Retry
When a transaction is aborted and retried, the system must be able to differentiate prepare responses and aborts across different attempts to commit the same instance of a transaction. This is typically handled with unique transaction IDs or attempt counters.

## Interactions with Reconfiguration

Executing transactions during a [[CSE452/Sharding/Reconfiguration|Reconfiguration]] is extremely dangerous and can lead to deadlocks or consistency violations.

### The "One Configuration" Rule
To simplify implementation, Lab 4 follows a strict rule: **Any transaction must occur entirely within a single configuration.**
- Servers tag all transaction messages with their current `config_num`.
- If a server receives a `Prepare` request with a different `config_num`, it immediately rejects it.

### Delaying Reconfiguration
If a group is participating in a pending transaction (i.e., it holds locks for certain keys), it must **delay** processing any new configuration until the transaction is resolved. This prevents shards from being moved while they are "locked" by an ongoing 2PC process.

## Deadlock Avoidance

The easiest way to avoid deadlocks in this environment is to **Abort on Conflict**.
- If a server cannot immediately acquire the necessary locks for a `Prepare` request, it rejects the request rather than waiting.
- The client (or coordinator) then retries the transaction.
- **Livelock Prevention**: To prevent transactions from repeatedly aborting each other, groups can be given fixed priorities (e.g., based on `GID`). Clients should route transactions to the highest-priority participant to serve as the coordinator.

## Linearizability & Progress

- **Linearizability**: 2PC with locking ensures that transactions appear to execute atomically and in a total order.
- **Deadlock-Free**: By using "abort-on-conflict" and configuration tagging, the system avoids circular waits.
- **Progress**: The system must be able to make progress on reconfigurations and transactions as long as the underlying Paxos groups remain available.

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Two-Phase Commit (2PC)** | Atomic Commitment Protocol (ACP) |
| **Transaction Coordinator** | Transaction Manager (TM) |
| **Participant** | Resource Manager (RM) |
| **Prepare Phase** | Voting phase |
| **Commit/Abort Phase** | Decision / completion phase |
| **Distributed Lock** | Pessimistic write lock / two-phase locking |
| **Abort on Conflict** | No-wait deadlock prevention |

---

## Related
- [[CSE452/Sharding/Two-Phase Commit|Two-Phase Commit: Motivation]] — the naive swap protocol and its five failure modes that 2PC fixes
- [[CSE452/Sharding/Sharding|Sharding Overview]] — the architecture transactions span
- [[CSE452/Sharding/Reconfiguration|Reconfiguration]] — the one-configuration rule and reconfiguration interactions
- [[CSE452/Sharding/Sharded Key-Value Server|Sharded Key-Value Server]] — the groups participating as coordinator and participants
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] — the guarantee 2PC preserves for multi-key operations
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — the consensus layer behind every 2PC state transition
