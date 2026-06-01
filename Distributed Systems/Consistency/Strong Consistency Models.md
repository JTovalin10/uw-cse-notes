# CSE452: Strong Consistency Models

Strong consistency models guarantee that all clients observe operations in some consistent total order. These models make a distributed system behave like a single sequential machine, providing the easiest programming model at the cost of high coordination and potential unavailability.

## 1. The Hierarchy
Linearizability is **strictly stronger** than sequential consistency. In terms of legal executions:
$$\text{Linearizable} \subset \text{Sequentially Consistent}$$
Every linearizable execution is sequentially consistent, but the reverse is not true.

---

## 2. Linearizability
**Linearizability** is the strongest practical consistency model for single-object operations. 

### Formal Definition
Requires that operations appear to take effect atomically at some point between their invocation and response, respecting a single global total order that matches real-time (wall-clock) precedence.
### Simplified Explanation
The system behaves as if there is only a single, atomic copy of the data. If operation A finishes before B starts, everyone must see A before B.

### Proving Linearizability
- **Linearization Points**: Identify a specific point in time (the "linearization point") for every operation between its invocation and its response. If all operations appear to occur atomically at their respective points, the system is linearizable.
- **Precedence Graphs**: Construct a directed graph where nodes are operations. Add edges for program order and real-time order. If the graph has a cycle, the execution is **not** linearizable.

---

## 3. Sequential Consistency
**Sequential Consistency** is a weaker model that respects the order of operations from individual clients but allows the global order to deviate from wall-clock time.

### Formal Definition
All operations appear to be executed in some total order that respects the program order of each individual process. It does **not** require that the global order respects real-time (wall-clock) precedence.
### Simplified Explanation
Everyone agrees on the order of events, and that order respects each person's own sequence of actions. However, "the order" might not be the same as the order in which things actually happened in real time.

### Key Difference
Sequential consistency does **not** have a real-time constraint. If Client A finishes a write and Client B starts a read later, sequential consistency *allows* Client B to see the old value, provided there is *some* valid total order (where B's read is placed before A's write) that respects everyone's local program order.

---

## 4. Comparison Table

| Feature | Linearizability | Sequential Consistency |
| :--- | :--- | :--- |
| **Total Order?** | Yes | Yes |
| **Respects Program Order?** | Yes | Yes |
| **Respects Real-time Order?** | **Yes** | No |
| **Performance** | Lower (High coordination) | Higher (Allows stale reads/asynchrony) |
| **Transactional Equivalent** | Strict Serializability | Serializability |

---

## 5. Examples

### Sequential Consistency (but NOT Linearizable)
- **Client A**: `Write(x, 1)` $\to$ ACK at 10:00 AM.
- **Client B**: `Read(x)` $\to$ returns `0` at 10:01 AM.
- **Analysis**: Legal under Sequential Consistency (order: `Read_B` then `Write_A`). Illegal under Linearizability because 10:01 AM > 10:00 AM.

### Violation of Both (Program Order Failure)
- **Client A**: `Write(x, 1)`, then `Write(x, 2)`.
- **Client B**: `Read(x)` returns `2`, then `Read(x)` returns `1`.
- **Analysis**: Illegal. This violates Client A's program order. There is no total order that can place `2` before `1` while respecting A's sequence.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Linearizability** | Atomic consistency / external consistency |
| **Sequential Consistency** | Serializability (transactional analogue) |
| **Linearization Point** | Commit / atomic visibility point |
| **Precedence Graph** | Serialization graph / dependency graph |

---

## Related
- [[Theoretical Foundations|Theoretical Foundations (CAP/PACELC)]]
- [[Weak Consistency Models|Weak Consistency Models]]
- [[Architectural Consistency|Architectural Consistency]] — how strong consistency is enforced in hardware and caches
- [[Paxos|Paxos Consensus]] — the protocol that implements a linearizable replicated state machine
- [[Linearizability|Linearizability (Definition)]]
