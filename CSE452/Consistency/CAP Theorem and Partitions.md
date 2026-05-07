# CAP Theorem and Partitions

In the context of Distributed Systems, the **CAP Theorem** (Brewer's Theorem) states that it is impossible for a distributed data store to simultaneously provide more than two out of the following three guarantees: **Consistency**, **Availability**, and **Partition Tolerance**.

## The Centrality of Partitions

In any real-world distributed system, **Partition Tolerance (P)** is not optional; networks fail. Therefore, the theorem is effectively a choice between **Consistency (C)** and **Availability (A)** *when a partition occurs*.

### 1. CP (Consistency + Partition Tolerance)
The system prioritizes data integrity. If a partition occurs, the system will refuse to process requests that cannot be guaranteed to be consistent across the whole cluster.
- **Invariant:** All nodes see the same data at the same time.
- **Trade-off:** The system becomes "Unavailable" for writes (and potentially reads) until the partition is resolved.
- **Example:** Paxos or [[CSE452/Paxos/Paxos|Raft]]-based systems (like Etcd or Zookeeper) which require a **Majority Quorum** to proceed.

### 2. AP (Availability + Partition Tolerance)
The system prioritizes responsiveness. Even if a partition exists, each node will continue to respond to requests using its local data.
- **Invariant:** Every request receives a (non-error) response about whether it succeeded or failed.
- **Trade-off:** Data may diverge between partitions (Eventual Consistency).
- **Example:** [[CSE344/Database Design/Database Applications|Cassandra]] or DynamoDB (in certain modes).

---

## Beyond CAP: The PACELC Theorem
The CAP theorem only describes behavior during a partition. The **PACELC** theorem extends this by describing the trade-offs during normal operation (Latency vs. Consistency):
- **P** (During Partition): Choose **A** (Availability) or **C** (Consistency).
- **Else** (Normal Operation): Choose **L** (Latency) or **C** (Consistency).

This explains why even non-partitioned systems might choose "Weak Consistency": to reduce **Latency**.

---

## Critical Invariants and Risks

### Split Brain
The most dangerous failure mode during a partition. If both sides of a split continue to accept writes (AP), the system's state diverges. Reconciling these "two brains" later (via Last-Write-Wins or Vector Clocks) is complex and often results in data loss.

### Majority Quorums
To maintain consistency (CP), systems use Quorums. An operation only succeeds if it is acknowledged by a majority of nodes.
- **Formula**: For a cluster of $N$ nodes, a majority is $\lfloor N/2 \rfloor + 1$.
- **Fault Tolerance**: A system with $2f + 1$ nodes can tolerate up to $f$ failures.
- **Invariant:** Only one side of a partition can ever have a majority.
- **Result:** The "minority" side halts, and the "majority" side continues, preventing Split Brain.

## Architect's Summary
When designing for partitions, you must decide: Is it better to be **wrong** (AP) or **silent** (CP)? In financial systems, we choose CP. In social media feeds, we choose AP.

---

## Related
- [[CSE452/Consistency/Linearizability and Sequential Consistency|Linearizability and Sequential Consistency]] — the specific consistency models promised by CP systems
- [[CSE452/Paxos/Paxos|Paxos]] — the algorithm used to achieve CP
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — how AP systems resolve conflicts after a partition (reconciling split brain)

