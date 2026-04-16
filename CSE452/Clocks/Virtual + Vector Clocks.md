# CSE452: Virtual and Vector Clocks

**Virtual clocks** (also known as **Lamport clocks** or **logical clocks**) are a way to reason about event ordering in a distributed system without relying on physical clocks. Physical clocks track real-world time, but in practice two observers can disagree on the order of events A and B: one may observe A then B, while another observes B then A. This motivates a clock system based on causality rather than wall time.

---

## Events

An **event** is one of the following:
- A node executing a local instruction
- A node sending a message
- A node receiving a message

**Key insight**: some events may appear to occur in different orders to different observers. When two events are causally unrelated (concurrent), it does not matter if different observers see them in different orders — the system is still correct.

---

## Space-Time Diagrams

A **space-time diagram** is a visual representation of events across nodes over time:
- Time flows downward on the vertical axis
- Each vertical line represents a node or process
- Arrows between nodes represent messages, and they always slope downward — you cannot receive a message before it was sent
- Individual events are represented as dots on the vertical process lines

Lamport's model assumes CPUs are not running at the same clock frequency, which is why logical rather than physical time is used.

Key observations:
- Message arrows cannot be horizontal — they must always slope downward due to propagation delay
- If there is no chain of arrows connecting two events, the distributed system cannot distinguish which came first — the two orderings are observationally equivalent
- **Concurrent events**: two events are concurrent if there is no happens-before ($\rightarrow$) relation between them and they are not on the same machine. The ordering may look distinguishable on the diagram, but to the distributed system both orderings are equivalent

Ordering still matters when there is a causal chain. For example, comparing event $P_1$ vs. $R_4$:
- $P_1$ sends to $Q_2$, so $Q_2$ must come after $Q_1$
- $R_4$ must come after $R_3$, and $R_3$ comes after $Q_4$
- $Q_4$ must come after $Q_2$, so transitively $P_1$ must have occurred before $R_4$

For two events to be concurrent, there must be no single directed causal path connecting them.

![[Space Time Diagram.png]]

---

## Computing the Happens-Before Relation

See [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] for the formal definition of the happens-before relation and concurrent events.

---

## Logical Clocks

[[CSE452/Clocks/Logical Clocks|Logical Clocks]] — the clock condition and how timestamps propagate across messages

---

## Lamport Clock Algorithm

[[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — the standard implementation using a single counter per node

---

## Vector Clock Algorithm

[[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — extends Lamport clocks to capture causality bidirectionally

---

## Consistency Models

- [[CSE452/Clocks/Sequential Consistency|Sequential Consistency]] — which executions are allowed under a replicated state machine
- [[CSE452/Clocks/Linearizability|Linearizability]] — sequential consistency plus real-time ordering

---

## Related

- [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] — happens-before relation, concurrent events, partial ordering
- [[CSE452/Clocks/System State|System State]] — stable and unstable properties, invariants, and correctness proofs in primary-backup
- [[CSE452/RPC/Fault Model|Fault Model]] — dropped and delayed messages affect happens-before ordering across machines
