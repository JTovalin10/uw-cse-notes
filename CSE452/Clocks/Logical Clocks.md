# CSE452: Logical Clocks

**Logical clocks** (also called **virtual clocks** or **Lamport clocks** in their original formulation) are a mechanism for reasoning about the ordering of events in a distributed system without relying on physical wall-clock time. In a distributed system, physical clocks on separate machines run independently and drift at different rates. Even with NTP synchronization, drift can be on the order of milliseconds or more, which is unacceptable when determining the precise ordering of events that may be microseconds apart. Logical clocks sidestep this problem entirely: instead of measuring real elapsed time, they measure **causal precedence** — whether one event could have influenced another.

---

## Events in Distributed Systems

An **event** is any discrete, atomic operation at a node. There are three categories:

- **Local instruction**: A computation step internal to a process (e.g., incrementing a variable).
- **Send**: A process transmits a message to another process.
- **Receive**: A process receives a message from another process.

The key challenge is that different observers (nodes) may perceive events in different orders. A node cannot distinguish whether a remote event happened "before" or "after" a local event unless there is a message connecting them. This is a fundamental consequence of the finite speed of information propagation.

---

## Space-Time Diagrams

A **space-time diagram** is the standard visual tool for reasoning about distributed events:

- **Vertical axis**: Time flows downward.
- **Vertical lines**: Each line is a single process or node.
- **Dots**: Individual events on a process.
- **Arrows**: Messages between nodes — they always slope downward because a message cannot be received before it is sent. This physical constraint is the foundation of causality in distributed systems.

If no chain of arrows connects two events, no information could have flowed between them, so the system has no basis for establishing which occurred "first."

![[Screenshots/Space Time Diagram.png]]

---

## The Happens-Before Relation

The **happens-before relation**, written $e_1 \rightarrow e_2$, is the formal foundation for causal ordering. It captures every situation in which event $e_1$ could have causally influenced event $e_2$. The definition is recursive:

1. **Same process**: $e_1$ and $e_2$ occur on the same machine, and $e_1$ occurs first in that process's local execution order.
2. **Message passing**: $e_1$ is the **sending** of a message and $e_2$ is the **receipt** of that exact message.
3. **Transitivity**: There exists an intermediate event $e_3$ such that $e_1 \rightarrow e_3$ and $e_3 \rightarrow e_2$.

The third rule is critical: it says that causality flows through chains of messages across any number of hops. If node A sends to node B, and node B sends to node C, then an event on A before the send happens-before an event on C after the receive — even though A and C never communicated directly.

### Why happens-before is a partial order

The happens-before relation is a **strict partial order**: it is irreflexive ($e \not\rightarrow e$), asymmetric (if $e_1 \rightarrow e_2$ then $\neg(e_2 \rightarrow e_1)$), and transitive. It is only a *partial* order — not a total order — because not every pair of events is comparable. Events with no causal connection have no defined ordering.

### Concurrent Events

Two events $e_1$ and $e_2$ are **concurrent**, written $e_1 \parallel e_2$, if neither happens before the other:

$$e_1 \parallel e_2 \iff \neg(e_1 \rightarrow e_2) \land \neg(e_2 \rightarrow e_1)$$

Concurrent events are not just events that happen "at the same time" — they are events that have no causal relationship whatsoever. Because no information flowed between them, their relative order has no meaning for system correctness. This is important: a distributed system need not assign a consistent global order to concurrent events, and requiring one would be an over-constraint that limits performance (this tension is at the heart of the [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem]]).

---

## Clock Condition

A logical clock is a function $C(e)$ that assigns a non-negative integer timestamp to every event. The **clock condition** states:

$$\text{if } e_1 \rightarrow e_2 \text{, then } C(e_1) < C(e_2)$$

This ensures that logical timestamps **respect causality**: if you know $e_1$ happened-before $e_2$, you are guaranteed that $e_1$'s timestamp is strictly smaller. The clock condition is a minimum requirement — any correct logical clock must satisfy it.

However, the **converse** does not hold for basic logical (Lamport) clocks:

$$C(e_1) < C(e_2) \not\Rightarrow e_1 \rightarrow e_2$$

A smaller timestamp only proves that the clock was lower at that moment; it does not prove causal precedence. Two concurrent events might receive timestamps 3 and 7 — the lower timestamp tells you nothing about actual ordering. [[CSE452/Clocks/Vector Clock Algorithm|Vector clocks]] strengthen this to a biconditional, giving full causality detection in both directions.

---

## Algorithms

Two main algorithms implement logical clocks, each with different expressive power:

- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]]: Uses a single integer per node. Satisfies the clock condition (one direction only). Simple and low overhead, but cannot detect concurrency.
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]]: Uses a vector of integers, one entry per node. Satisfies the biconditional — can detect whether two events are causally related or concurrent. Higher metadata overhead but strictly more powerful.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Logical Clock** | Lamport timestamp / scalar logical clock |
| **Happens-Before Relation** | Causal order / potential causality |
| **Space-Time Diagram** | Process-time diagram / Lamport diagram |
| **Clock Condition** | Causal consistency of timestamps |
| **Concurrent Events** | Causally independent events |

---

## Related

- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — standard logical clock implementation satisfying the clock condition
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — bidirectional causality and concurrency detection
- [[CSE452/Clocks/Vector Clock Pruning|Vector Clock Pruning]] — scalability trade-offs when managing large vector clock state
- [[CSE452/Clocks/System State|System State]] — stable and unstable properties; invariants used in correctness proofs
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem]] — why total ordering of all events is incompatible with availability under partitions
- [[CSE452/RPC/Fault Model|Fault Model]] — how message drops and delays impact the happens-before relation
- [[CSE452/Knowledge/Knowledge|Knowledge in Distributed Systems]] — epistemic foundations of what nodes can know about each other's state
- [[CSE451/Concurrency/Threads/Threads Overview|Threads Overview (CSE451)]] — OS-level concurrency; compare with distributed event ordering
