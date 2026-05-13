# CSE452: Weak Consistency Models

Weak consistency models (including [[#Eventual Consistency|Eventual Consistency]]) are designed for high availability and performance in distributed systems where strong coordination is too expensive or impossible due to network partitions. These models are the foundation of AP (Available and Partition-tolerant) systems.

## 1. Weak vs. Strong Consistency

In distributed systems, the choice between strong and weak consistency defines the fundamental trade-offs between system correctness and performance/availability.

**Strong Consistency** (e.g., [[CSE452/Consistency/Strong Consistency Models#Linearizability|Linearizability]]) provides a global ordering of operations. It guarantees that the system behaves like a single, atomic copy of data, ensuring all clients see the most recent update.

**Weak Consistency** is any model that does not provide strong guarantees. 
- **No Global Ordering**: Different nodes may see updates in different orders.
- **Divergence**: Replicas are allowed to temporarily diverge during a partition or under high load.
- **Convergence**: The system only promises that if updates stop, all replicas will "eventually" converge to the same state.

---

## 2. Weak Consistency Hierarchy

Just as strong models have a hierarchy, weak models are ordered by the types of guarantees they provide.

### Causal Consistency
#### Formal Definition
Ensures operations that are potentially causally related (ordered by the Happens-Before relationship) are seen by all processes in the same order. Operations that are not causally related (concurrent) may be seen in different orders.
#### Simplified Explanation
The system tracks dependencies. If Bob's post is a reply to Alice's post, everyone must see Alice's post before they see Bob's reply. If two posts are unrelated, people might see them in different orders.

### FIFO (PRAM) Consistency
#### Formal Definition
Writes from a single process are seen by all other processes in the order they were issued, but no guarantees are made about the relative ordering of writes from different processes.
#### Simplified Explanation
You see everything one person does in the order they did it, but the actions of different people might be interleaved randomly.

### Processor Consistency
#### Formal Definition
Writes issued by a single process are seen by all other processes in the order they were issued. However, writes from different processes may be seen in different orders by different observers.
#### Simplified Explanation
Similar to FIFO, but even less strict about global interleaving. It is the distributed version of the per-core ordering found in hardware (see: [[CSE452/Consistency/Architectural Consistency#Total Store Order (TSO)|TSO]]).

### Eventual Consistency
#### Formal Definition
Guarantees that, if no new updates are made to a data item, eventually all accesses to that item will return the last updated value.
#### Simplified Explanation
The system is allowed to be "wrong" or stale right now, as long as it promises to catch up and be correct at some point in the future.

---

## 3. Conflict Resolution Policies

Since replicas can diverge, the system must have a strategy to reconcile conflicting updates.

### Last-Writer-Wins (LWW)
**Last-Writer-Wins** is a simple policy where every update is timestamped. If two updates conflict, the one with the higher timestamp is kept.
- **Mechanism**: Replicas use wall-clock or logical clocks to tag writes.
- **Drawbacks**: 
    - **Clock Skew**: Relying on wall-clock time is dangerous because physical clocks are never perfectly synchronized.
    - **Data Loss**: LWW silently overwrites conflicting data.

---

## 4. Conflict-Free Replicated Data Type (CRDT)

**Conflict-Free Replicated Data Types** are data structures that can be updated independently and concurrently without coordination, guaranteeing eventual convergence.

### Core Concept: Convergence Without Coordination
CRDTs achieve convergence by ensuring that the merge operation is Commutative, Associative, and Idempotent.

### Grow-only Counter (G-Counter)
Implemented using an array of integers, one per server.
- **increment()**: Replica $i$ increments its own slot $V[i]$.
- **get()**: Returns $\sum V[j]$.
- **merge(other)**: Takes the **maximum** of each corresponding slot.

### Positive-Negative Counter (PN-Counter)
Combines two G-Counters: $P$ (Positive) and $N$ (Negative).
- **get()**: Returns $P.get() - N.get()$.

---

## Related
- [[CSE452/Consistency/Theoretical Foundations|Theoretical Foundations (CAP/PACELC)]]
- [[CSE452/Consistency/Strong Consistency Models|Strong Consistency Models]]
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]]
