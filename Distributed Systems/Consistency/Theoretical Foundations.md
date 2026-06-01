# CSE452: Consistency Theoretical Foundations

Consistency in distributed systems is defined by the mathematical trade-offs between data integrity, availability, and performance.

## 1. The Core Concept

A **consistency model** is a contract between the system and the programmer. It answers: *What executions are legal?*
- **Predicate**: Consistency is a function $f(\text{execution}) \rightarrow \{\text{True, False}\}$.
- **Coordination**: Maintaining consistency requires nodes to communicate. The stronger the guarantee, the higher the coordination cost.

### The Strength Hierarchy
The "strength" of a model is defined by the set of legal executions it allows. A stronger model permits a **strict subset** of the executions a weaker model permits.

$$\text{Strict} \subset \text{Linearizable} \subset \text{Sequential} \subset \text{Causal} \subset \text{FIFO} \subset \text{Eventual}$$

### Strict Consistency
The strongest theoretical consistency model.

#### Formal Definition
Any read on a data item $x$ returns a value corresponding to the result of the most recent write on $x$.

#### Simplified Explanation
Requires a perfectly synchronized global clock (impossible in distributed systems). It is the theoretical "ideal" used as a baseline for all other models.

---

## 2. The CAP Theorem

In any distributed system, you cannot simultaneously provide more than two of the following:
- **Consistency (C)**: Every read receives the most recent write or an error.
- **Availability (A)**: Every request receives a (non-error) response.
- **Partition Tolerance (P)**: The system continues to operate despite an arbitrary number of messages being dropped or delayed by the network between nodes.

James prefers to frame this as the **CAP Tension** rather than a strict theorem: **C** and **A** are in tension with each other, and exactly where that tension lands depends on how you define **C** and **A** in the first place. A stricter definition of Consistency forces you to give up more Availability, and vice versa, so the "pick two" framing is really a spectrum governed by those definitions.

#### Formal Definition
A distributed data store can provide at most two out of three guarantees: Consistency (all nodes see the same data), Availability (every request gets a response), and Partition Tolerance (the system continues to operate despite network failures).

#### Simplified Explanation
During a network partition, you must choose between being **correct** (CP) or being **online** (AP). You cannot be both.

---

## 3. The PACELC Theorem

CAP only describes behavior during a partition. **PACELC** extends this to normal operation (Latency vs. Consistency).

#### Formal Definition
- **P** (During Partition): Choose between **A** (Availability) and **C** (Consistency).
- **E** (Else/Normal Operation): Choose between **L** (Latency) and **C** (Consistency).

#### Simplified Explanation
Even when the network is working perfectly, consistency has a cost: it takes time (latency) to coordinate between nodes. If you want to be fast, you must accept weaker consistency.

---

## 4. Critical Invariants

### Majority Quorums
To maintain consistency (CP), systems use Quorums. An operation only succeeds if acknowledged by a majority of nodes.
- **Formula**: For $N$ nodes, a majority is $\lfloor N/2 \rfloor + 1$.
- **Fault Tolerance**: A cluster of $2f + 1$ nodes can tolerate $f$ failures.
- **Invariant**: Only one side of a partition can have a majority, preventing **Split Brain**.

### Split Brain
The most dangerous failure mode during a partition. If both sides of a split continue to accept writes (AP), the state diverges. Reconciling "two brains" later often results in data loss or complex merge logic.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **CAP Theorem** | Brewer's theorem |
| **PACELC Theorem** | PACELC consistency/latency trade-off |
| **Majority Quorum** | Quorum / majority voting |
| **Split Brain** | Split-brain syndrome / partition divergence |
| **CP / AP System** | Consistency-favoring / availability-favoring system |

---

## Related
- [[Strong Consistency Models|Strong Consistency Models]]
- [[Weak Consistency Models|Weak Consistency Models]]
- [[Architectural Consistency|Architectural Consistency]] — physical implementations of these models
- [[Paxos|Paxos Consensus]] — a CP protocol built on majority quorums
