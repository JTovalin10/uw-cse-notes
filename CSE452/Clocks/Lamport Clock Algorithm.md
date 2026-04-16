# CSE452: Lamport Clock Algorithm

The **Lamport Clock Algorithm** is the standard implementation of [[CSE452/Clocks/Logical Clocks|logical clocks]]:

1. Every node timestamps its events using a local counter
2. Every outgoing message includes the sender's logical timestamp of the send event
3. On receiving a message, the receiver considers two timestamps:
   - The timestamp of the previous instruction in its own process ($p_{n-1}$)
   - The timestamp on the incoming message — the sender's timestamp ($s_n$)
4. The receiver sets its clock to $\max(p_{n-1},\ s_n) + 1$

This ensures the **clock condition** is always satisfied: if $e_1 \rightarrow e_2$, then $C(e_1) < C(e_2)$.

## Limitation

The clock condition only holds in one direction:
- If $e_1 \rightarrow e_2$, then $C(e_1) \leq C(e_2)$
- The **converse is false**: $C(e_1) < C(e_2)$ does not imply $e_1 \rightarrow e_2$

This means Lamport clocks cannot distinguish two causally unrelated events — a lower timestamp does not prove an event happened first. [[CSE452/Clocks/Vector Clock Algorithm|Vector clocks]] solve this limitation by extending the timestamp to a vector.

## Related

- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — the clock condition and what logical timestamps mean
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — extends Lamport clocks to capture causality bidirectionally
- [[CSE452/Clocks/Virtual + Vector Clocks|Virtual and Vector Clocks]] — overview and space-time diagrams
