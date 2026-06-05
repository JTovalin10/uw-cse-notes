# Database Internals: Synchronous Replication

Also called **eager replication**. Every replica must apply the transaction before it can commit — requires **[[Database Internals/Distributed Systems/Two-Phase Commit|2PC]]** and global locks. The overarching goal is to behave as if there is only one copy of the database (**one-copy serializability**).

This file focuses on the **timing** mechanics of synchronous replication and how they apply to the [[Master and Group Replication|two topology types]].

![[Screenshots/Synchronous Replication.png]]

## Shared Synchronous Properties

Regardless of whether the topology is Master or Group, synchronous replication shares these traits:

### Benefits
- **Strong consistency** — all replicas are current at commit time, guaranteeing full one-copy serializability.
- **No stale reads** — unlike asynchronous replication, any read from any replica always returns the latest committed data.

### Challenges
- **Requires 2PC** — every commit is a distributed transaction across all replicas, adding significant round-trip latency.
- **Speed limited by slowest replica** — the transaction cannot commit until every node in the required quorum responds, so a single slow node slows down the entire system.
- **Favors consistency over availability** — in the event of a network partition, only the majority partition can keep running; the minority partition becomes completely unavailable to prevent divergence.

---

## Synchronous Master Replication

**Axes: Synchronous (eager) + [[Master and Group Replication#Master Replication (Single-Master)|Master]].** 

One **master** holds the primary copy and handles all writes. To write, a transaction acquires a lock at the master — since the master is the only writer, this single lock functions as a global lock. The master then runs **2PC** to propagate the update to all secondaries before responding to the user.

![[Screenshots/Synchronous Master Replication.png]]

### Handling Master Failures (Paxos)
If the master crashes, the system must elect a new primary via **Paxos** or **Raft**. Because the replication is synchronous, no committed data is lost during the crash.

To prevent a **split-brain** scenario during a network partition (where the old master and a newly elected master both accept writes), only the **majority partition** is allowed to continue operating.

### Trade-offs specific to Sync Master
- **Simplest locking**: One lock queue at the master means no complex quorum math and no version numbers required.
- **Reads are not blocked**: The master holds a write (exclusive) lock during a transaction, but reads can be routed to any replica. Since sync replication guarantees all replicas are fully up to date at commit time, those reads are never stale and never need to touch the locked master.
- **Write bottleneck**: All writes must funnel through the master's 2PC process, capping total write throughput.

---

## Synchronous Group Replication

**Axes: Synchronous (eager) + [[Master and Group Replication#Group Replication (Multi-Master)|Group]].** 

Any node can accept a write, but the system must still ensure that all replicas update before the commit finishes. Since there is no single master to serialize writers and prevent conflicts, the system uses **quorum locking** instead of a single master lock.

### Quorum Locking Mechanics
To commit, a transaction must acquire distributed locks across a quorum of nodes. With $n$ total copies:
- A write lock on $x$ copies acts as a global exclusive lock.
- A read lock on $s$ copies acts as a global shared lock.

**The Quorum Rules:**
1. $x > n/2$ — Any two write quorums must overlap on at least one node. This prevents two conflicting writes from both succeeding.
2. $s + x > n$ — Any read quorum must overlap with every write quorum. This ensures readers always see outstanding write locks.

Because reads only touch $s$ copies (not all of them), every copy requires a **version number** so the reader can identify which of the $s$ copies holds the most current data.

![[Screenshots/Synchronous Group Replication.png]]

### Tuning the Quorum
- **Majority locking**: $s = x = \lceil (n+1)/2 \rceil$. Reads and writes cost the same (usually inefficient since reads become slow).
- **Read-one, write-all**: $s=1$, $x=n$. Very fast reads (only touch one node) but extremely expensive writes (must lock every node).

### Trade-offs specific to Sync Group
- **Reads can be blocked**: The quorum rule $s + x > n$ guarantees every read quorum overlaps with every write quorum by at least one node. This means a read will always hit at least one write-locked node and must wait for that lock to release before proceeding — unlike Sync Master, where reads bypass the locked master entirely by going to replicas.
- **High Deadlock Rate**: 2PC requires acquiring a lock on multiple nodes independently. Transaction A might lock nodes 1+2 and wait for 3, while Transaction B locks 2+3 and waits for 1. This distributed deadlock cannot happen in Sync Master.
- **Coordination on every write**: In Sync Master, distributed consensus (Paxos) only runs when the master fails. In Sync Group, distributed coordination (quorum locking) runs on *every single transaction*.

---

## Formal Analysis

### Formal Definition
For **Synchronous Group Replication** with $n$ copies, a read quorum of size $s$ and a write quorum of size $x$ are correct if and only if:

$$x > \frac{n}{2} \qquad \text{and} \qquad s + x > n$$

### Simplified Explanation
If two write groups must always share at least one member, they can never both think they hold the lock — two conflicting writes can't both win. If every read group overlaps with every write group, a reader always bumps into the latest write. Make reads cheap and writes expensive, or split the cost evenly — but the groups must always overlap.

---

## Related

- [[Master and Group Replication]] — the topology axis
- [[Database Internals/Distributed Systems/Replication|Replication]] — parent hub
- [[Asynchronous Replication]] — the lazy counterpart
- [[Database Internals/Distributed Systems/Two-Phase Commit|Two-Phase Commit (2PC)]]

## Industry Standard Terms

- **Synchronous / eager replication** → Strong consistency / synchronous commit
- **Group Quorums** → Dynamo-style quorums / Leaderless consensus
