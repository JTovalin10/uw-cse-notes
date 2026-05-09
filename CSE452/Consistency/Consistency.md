# CSE452: Consistency

A **consistency model** is a contract between a distributed system and the programmer. It answers the question: *What executions of a replicated state machine are correct?*

## The Core Concept

Consistency is a predicate $f(\text{execution}) \rightarrow \{\text{True, False}\}$. It defines which observed results are legal under the promised semantics. Without a consistency model, a programmer cannot reason about the correctness of their concurrent or distributed code. Two programmers using the same database but under different consistency assumptions will write subtly incompatible code — one may assume reads always reflect the latest write; the other may tolerate stale data. The model makes this contract explicit and verifiable.

---

## 1. Categories of Consistency

This breakdown is based on **where** the consistency is enforced and the architecture involved.

### [[CSE452/Consistency/Memory Consistency|Memory Consistency]] (The Foundation)

The contract between the hardware (CPU/RAM) and the software. Even before any network is involved, a multi-core processor reorders instructions for performance. The memory consistency model defines which reorderings are legal.
- **Problem**: Out-of-order execution by hardware causes different threads to observe memory updates in different orders.
- **Solution**: Memory barriers (fences) enforce ordering at explicit synchronization points; **Total Store Order (TSO)** is the model used by x86-64 hardware.

### [[CSE452/Consistency/Linearizability and Sequential Consistency|Distributed Consistency]] (The Global View)

The contract between multiple replicated nodes connected by a network. Because messages are delayed and nodes fail independently, agreeing on a single view of shared state is fundamentally harder than on a single machine.
- **Strong Models**: [[CSE452/Consistency/Definitions/Linearizability|Linearizability]], [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential Consistency]] — every read reflects the latest write, globally.
- **Weak Models**: [[CSE452/Consistency/Definitions/Causal Consistency|Causal]], [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO]], [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual]] — allow stale reads in exchange for availability and lower latency.

### [[CSE452/Consistency/CAP Theorem and Partitions|Theoretical Limits]] (The Laws)

The mathematical trade-offs required by any distributed system. These are not implementation details — they are provable impossibility results.
- **[[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]]**: During a network partition, a system must choose between Consistency and Availability.
- **[[CSE452/Consistency/Definitions/PACELC Theorem|PACELC Theorem]]**: Even without a partition, every system trades Latency against Consistency during normal operation.

### [[CSE452/Consistency/Distributed Cache Coherence|Distributed Cache Coherence]] (The Practice)

How the abstract consistency guarantees above are implemented in systems that use caches to reduce latency. Cache coherence protocols — write-through invalidation, server-side directories, and timed leases — translate the theory of linearizability into real engineering decisions.

---

## 2. The Strength Hierarchy

The "strength" of a model is defined by the set of legal executions it allows. A **stronger** model permits a **strict subset** of the executions a weaker model permits — it is more restrictive, therefore easier to reason about but harder to implement efficiently.

$$\text{Strict} \subset \text{Linearizable} \subset \text{Sequential} \subset \text{Causal} \subset \text{FIFO} \subset \text{Eventual}$$

- **Strong Models (left side)**: [[CSE452/Consistency/Definitions/Strict Consistency|Strict]], [[CSE452/Consistency/Definitions/Linearizability|Linearizable]], [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential]] — provide the most guarantees but impose the highest coordination cost, leading to higher latency and lower availability.
- **Weak Models (right side)**: [[CSE452/Consistency/Definitions/Causal Consistency|Causal]], [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO]], [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual]] — provide fewer guarantees but enable high throughput, low latency, and "always-on" availability under partition.

The key insight is that you cannot simultaneously have a strong consistency guarantee and high availability during a partition — the [[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]] makes this precise.

---

## 3. Why This Matters

As a distributed systems engineer, you are constantly choosing: **Is it better to be wrong (AP/Weak) or silent (CP/Strong)?**

- **[[CSE452/Consistency/Linearizability and Sequential Consistency|Strong Consistency]]**: Easy to program against because the system behaves like a single sequential machine. High latency and reduced availability are the cost.
- **[[CSE452/Consistency/Definitions/Eventual Consistency|Weak / Eventual Consistency]]**: High performance and availability. The programmer must explicitly handle data conflicts, stale reads, and convergence logic (e.g., using **Conflict-free Replicated Data Types (CRDTs)** or **Last-Write-Wins (LWW)** policies).

The choice also depends on the workload. A write-heavy workload with many concurrent updates to the same key makes strong consistency extremely expensive — every write must be coordinated across replicas. A read-heavy workload with infrequent writes can approach the performance of a weakly consistent system even while maintaining linearizability, since coordination only fires on writes.

---

## Glossary of Consistency Models

These **models** are the specific technical contracts or rulesets that define legal system behavior:
- [[CSE452/Consistency/Definitions/Strict Consistency|Strict Consistency]] — The theoretical ideal; requires a perfectly synchronized global clock.
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] — Strongest practical model; operations appear atomic in real-time order.
- [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential Consistency]] — Total order respecting program order but not wall-clock time.
- [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]] — Happens-before tracking; strongest model compatible with high availability.
- [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO / PRAM Consistency]] — Per-process write ordering only; no cross-process guarantees.
- [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]] — Per-process order without global interleaving guarantees.
- [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]] — Convergence over time if updates stop; weakest common model.
- [[CSE452/Consistency/Definitions/Memory Consistency Model|Memory Consistency Model]] — Hardware-level contract governing CPU instruction reordering.
- [[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]] — Consistency vs. availability trade-off during network partitions.
- [[CSE452/Consistency/Definitions/PACELC Theorem|PACELC Theorem]] — Latency vs. consistency trade-off during normal operation.

---

## Related
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — establishing the "happens-before" relation that underpins causal consistency
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — tracking causal dependencies across nodes
- [[CSE452/Paxos/Paxos|Paxos]] — the consensus algorithm used to implement strong (CP) consistency
- [[CSE452/Consistency/Distributed Cache Coherence|Distributed Cache Coherence]] — how consistency is maintained across caching layers
