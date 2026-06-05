# Database Internals: Asynchronous Replication

Also called **lazy replication** or **optimistic replication**. The priority is **availability and performance** over consistency — the opposite tradeoff from [[Synchronous Replication|Synchronous Replication]].

The transaction commits immediately at the node that received it, and then propagates the updates to other replicas in the background. There is no 2PC and no waiting for replicas.

This file focuses on the **timing** mechanics of asynchronous replication and how they apply to the [[Master and Group Replication|two topology types]].

![[Screenshots/Async Replication.png]]

## Shared Asynchronous Properties

Regardless of whether the topology is Master or Group, asynchronous replication shares these traits:

### Benefits
- **No 2PC** — commits return to the user immediately, so latency is essentially local.
- **Partition tolerant** — replicas are not in the commit path. A network partition simply delays propagation instead of blocking writes entirely.
- **No global locks** — significantly lower deadlock rate than synchronous replication.

### Challenges
- **Stale reads** — replicas always lag behind the writer. Reads from a non-primary node may not reflect the latest write.
- **Data loss on crash** — if a node dies before propagating its background updates, those already-committed transactions are permanently lost.

---

## Asynchronous Master Replication (Single Master)

**Axes: Asynchronous (lazy) + [[Master and Group Replication#Master Replication (Single-Master)|Master]].** 

All writes go through one master node, which commits them immediately. The master then brings the replicas up to date in the background using **log shipping**.

### Log Shipping Mechanics
Because the master serializes all writes, the replicas never have to guess the order of operations.
- The master flushes its log tail to disk, then ships it across the network to the replicas.
- The replicas receive the log and run standard [[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Redo Logging|REDO]] logic to apply the changes serially.
- This is cheap to implement because it reuses the existing crash-recovery infrastructure.

### Trade-offs specific to Async Master
- **No conflict detection**: The single master prevents conflicts entirely. Replicas just replay the log in a fixed order, ensuring single-copy serializability on the replicas (just delayed).
- **Election Window Loss**: If the master crashes, an election (via Paxos/Raft) must occur. Any transactions committed by the old master that were not yet shipped to the replicas are lost.
- **Transactional Reads**: Because replicas lag, executing a read-write transaction against a replica means reading stale data and then writing based on that stale state — a correctness violation. For example, a transaction that reads a balance and then debits it may read an outdated balance, producing an incorrect result. Standalone, read-only queries (e.g., analytics, reporting) are safe to route to async replicas because they do not make writes contingent on what they read.

---

## Asynchronous Group Replication (Multi-Master)

**Axes: Asynchronous (lazy) + [[Master and Group Replication#Group Replication (Multi-Master)|Group]].** 

Any node can accept a write and commit it locally immediately. The node then propagates the update to other peers in the background. 

Because there is no master to impose a global write order, and no synchronous quorum locks to prevent two nodes from accepting writes to the same object simultaneously, **conflicts are guaranteed**. Node A and Node B can both accept a write to the same row at the same millisecond, each committing locally, with no mechanism to stop them. The system must detect these conflicts and reconcile them *after* the fact.

### Conflict Reconciliation Techniques
Replicas cannot just REDO a clean log because histories have diverged. Reconciliation must happen at the data level:
- **Last-Write-Wins (LWW)**: The most recent timestamp wins. Simplest to implement, but silently overwrites and drops data.
- **Site Priority**: Site A's updates always overwrite Site B's updates. Arbitrary, but predictable.
- **User-Defined / Manual**: The application code is handed the conflicting versions and must merge them (e.g., merging shopping carts).

![[Screenshots/Async Group Replication Detecting Conflicts Using Timestamps.png]]

### Trade-offs specific to Async Group
- **Highest Availability**: Provides the best availability and fault tolerance of any replication scheme. Losing any node doesn't block writes, and no election window is needed.
- **Weakest Consistency**: Cannot promise serializability; can only promise **eventual consistency**. 
- **Reconciliation is hard**: There is no universally perfect way to merge conflicting data automatically.

---

## Related

- [[Master and Group Replication]] — the topology axis
- [[Database Internals/Distributed Systems/Replication|Replication]] — parent hub
- [[Synchronous Replication]] — the eager counterpart
- [[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]] — REDO mechanism reused by log shipping

## Industry Standard Terms

- **Asynchronous / lazy replication** → Eventual consistency / async commit
- **Log shipping** → WAL streaming / Binlog replication
- **Last-Write-Wins** → Most recent timestamp wins
