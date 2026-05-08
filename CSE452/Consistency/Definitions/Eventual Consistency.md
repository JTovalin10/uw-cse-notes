# Eventual Consistency

**[[Eventual Consistency]]**: A weak consistency model which guarantees that, if no new updates are made to a data item, eventually all accesses to that item will return the last updated value.

## Key Properties
- **Liveness Guarantee**: It promises that state will converge "eventually."
- **Low Coordination**: Allows for high availability and low latency as nodes do not need to synchronize immediately.
- **Common Usage**: Used in DNS, Amazon Dynamo, and various AP systems.

## Related
- [[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]]
- [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]]
