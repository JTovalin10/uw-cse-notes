# CSE452: Logical Clocks

A **logical clock** is a mathematical function $C$ that assigns a timestamp to every event in a distributed system:

$$C: \text{events} \rightarrow \text{timestamp}$$

$C(e)$ is the **logical timestamp** of event $e$.

## Clock Condition

The **clock condition** states:

$$\text{if } e_1 \rightarrow e_2 \text{, then } C(e_1) < C(e_2)$$

This only gives information in one direction: a lower timestamp implies the event *may* have happened before, but does not prove it. The converse does not hold — $C(e_1) < C(e_2)$ does not necessarily mean $e_1 \rightarrow e_2$.

## Handling Message Events

To propagate timing information across nodes when messages are sent:
- Attach to every message the sender's logical timestamp of the send event
- When the receiver labels the receive event, it takes $\max(\text{sender timestamp},\ \text{previous local timestamp}) + 1$

The "previous timestamp" is the timestamp of the receiver's most recent prior event in that process.

This rule is implemented concretely by the [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]].

## Related

- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — the standard algorithm that implements the clock condition
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — extends logical clocks to capture causality in both directions
- [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] — happens-before relation and concurrent events
- [[CSE452/Clocks/Virtual + Vector Clocks|Virtual and Vector Clocks]] — overview of the clocks topic
