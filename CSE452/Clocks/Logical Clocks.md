# CSE452: Logical Clocks

**Logical clocks** (also known as **virtual clocks** or **Lamport clocks**) are a way to reason about event ordering in a distributed system without relying on physical clocks. In distributed systems, physical clocks across different machines drift and are not synchronized, making it impossible to determine a global order of events based on wall-clock time alone.

---

## Events in Distributed Systems

An **event** is any discrete operation occurring at a node:
- Executing a local instruction
- Sending a message
- Receiving a message

Some events may appear to occur in different orders to different observers. When events are causally unrelated (**concurrent**), their relative order does not impact system correctness.

---

## Space-Time Diagrams

A **space-time diagram** is a visual representation of events across nodes:
- **Vertical Axis**: Represents time flowing downward.
- **Vertical Lines**: Each line represents a single node or process.
- **Arrows**: Represent messages sent between nodes. They must always slope downward because a message cannot be received before it is sent.
- **Dots**: Represent individual events.

If no causal chain of arrows connects two events, the system cannot distinguish which occurred "first."

![[Screenshots/Space Time Diagram.png]]

---

## The Happens-Before Relation

We use the **happens-before** relation, written $e_1 \rightarrow e_2$, to capture causal dependencies. $e_1$ happens-before $e_2$ if:
1. $e_1$ and $e_2$ occur on the **same machine**, and $e_1$ occurs first locally.
2. $e_1$ is the **sending** of a message and $e_2$ is the **receipt** of that message.
3. **Transitivity**: There exists $e_3$ such that $e_1 \rightarrow e_3$ and $e_3 \rightarrow e_2$.

The happens-before relation is a **partial order** (irreflexive, asymmetric, and transitive).

### Concurrent Events

Two events $e_1$ and $e_2$ are **concurrent** (written $e_1 \parallel e_2$) if neither happens before the other:

$$e_1 \parallel e_2 \iff \neg(e_1 \rightarrow e_2) \land \neg(e_2 \rightarrow e_1)$$

Concurrent events have no causal relationship.

---

## Clock Condition

A logical clock is a function $C(e)$ that assigns a timestamp to every event. The **clock condition** states:

$$\text{if } e_1 \rightarrow e_2 \text{, then } C(e_1) < C(e_2)$$

This ensures that logical time respects causality. However, for basic logical clocks, the converse is not necessarily true: a lower timestamp does not prove an event happened before another.

---

## Algorithms

The following algorithms implement logical clocks with different properties:

- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]]: Uses a single integer per node to maintain the clock condition.
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]]: Uses a vector of integers to capture causality in both directions (detects concurrency).

---

## Related

- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — standard logical clock implementation
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — bidirectional causality and concurrency detection
- [[CSE452/Clocks/System State|System State]] — stable and unstable properties and invariants
- [[CSE452/RPC/Fault Model|Fault Model]] — how message drops and delays impact event ordering
- [[CSE451/Threads/concurrency.md]] — OS-level concurrency concepts
