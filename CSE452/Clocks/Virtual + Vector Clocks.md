# CSE452: Virtual and Vector Clocks

**Virtual clocks** (also known as **Lamport clocks** or **logical clocks**) are a way to reason about event ordering in a distributed system without relying on physical clocks. Physical clocks track real-world time, but in special relativity — and in practice — two observers can disagree on the order of events A and B: one may observe A then B, while another observes B then A. This motivates a clock system based on causality rather than wall time.

---

## Events

An **event** is one of the following:
- A node executing a local instruction
- A node sending a message
- A node receiving a message

**Paradox**: some events may appear to occur in different orders to different observers. When two events are unrelated (have no causal dependency), it does not matter if different observers see them in different orders — the system is still correct.

---

## Space-Time Diagrams

A **space-time diagram** is a visual representation of events across nodes over time:
- Time flows downward on the vertical axis
- Each vertical line represents a node or process (the "space" axis)
- Arrows between nodes represent messages, and they always slope downward — you cannot receive a message before it was sent
- Individual events are represented as dots on the vertical process lines

Lamport's model assumes CPUs are not running at the same clock frequency (GHz), which is why logical rather than physical time is used.

Key observations about space-time diagrams:
- If time were physical, message arrows could not be horizontal; they must always slope downward because of propagation delay
- If there is no chain of arrows connecting two events, and assuming no synchronized physical clock, the distributed system cannot distinguish which event came first — the two orderings are observationally equivalent
- **Concurrent events**: two events are concurrent if there is no happens-before ($\rightarrow$) relation between them and they are not on the same machine. On the diagram the ordering may look distinguishable, but to the distributed system the two orderings are equivalent (e.g., $e_2$ and $e_4$ if they are not causally dependent)

Ordering still matters when there is a causal chain. For example, comparing event $P_1$ vs. $R_4$:
- $P_1$ sends to $Q_2$, so $Q_2$ must come after $Q_1$
- $R_4$ must come after $R_3$, and $R_3$ comes after $Q_4$
- $Q_4$ must come after $Q_2$, so transitively $P_1$ must have occurred before $R_4$

For two events to be concurrent, there must be no single directed path connecting them — you cannot create a fork that joins them; it must be a single causal chain.
![[Space Time Diagram.png]]
---

## Computing the Happens-Before Relation from Inside the Distributed System

### Logical Clocks

A **logical clock** is a mathematical function $C$ that assigns a timestamp to every event:

$$C: \text{events} \rightarrow \text{timestamp}$$

$C(e)$ is the **logical timestamp** of event $e$.

### Clock Condition

The **clock condition** states:

$$\text{if } e_1 \rightarrow e_2 \text{, then } C(e_1) < C(e_2)$$

Note that this only gives us information in one direction: a lower timestamp implies the event *may* have happened before, but does not prove it. The converse does not hold — $C(e_1) < C(e_2)$ does not necessarily mean $e_1 \rightarrow e_2$.

### Handling Message Events

To propagate timing information across nodes when messages are sent:
- Attach to every message the sender's logical timestamp of the send event
- When the receiver labels the receive event, it takes $\max(\text{sender timestamp},\ \text{previous local timestamp}) + 1$, where the previous timestamp is the timestamp of the receiver's most recent prior event in that process

---

## Lamport Clock Algorithm

The **Lamport Clock Algorithm** is the standard implementation of logical clocks:

1. Every node timestamps its events using a local counter
2. Every outgoing message includes the sender's logical timestamp of the send event
3. On receiving a message, the receiver considers two timestamps:
   - The timestamp of the previous instruction in its own process ($p_{n-1}$)
   - The timestamp on the incoming message (the sender's timestamp) ($s_n$)
4. The receiver sets its clock to $\max(p_{n-1},\ s_n) + 1$

This ensures the clock condition is always satisfied: if $e_1 \rightarrow e_2$, then $C(e_1) < C(e_2)$.

---

## Related

- [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] — happens-before relation, concurrent events, partial ordering of events
- [[CSE452/Clocks/System State|System State]] — stable and unstable properties, invariants, and correctness proofs in primary-backup
- [[CSE452/RPC/Fault Model|Fault Model]] — dropped and delayed messages affect happens-before ordering across machines
