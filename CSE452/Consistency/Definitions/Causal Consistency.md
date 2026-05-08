# Causal Consistency

**[[Causal Consistency]]**: A consistency model that ensures operations that are potentially causally related (ordered by the Happens-Before relationship) are seen by all processes in the same order. Operations that are not causally related (concurrent) may be seen in different orders by different processes.

## Key Properties
- **Happens-Before Relationship**: Captures dependencies between operations (e.g., a read that sees a write).
- **Strongest Available Model**: It is the strongest consistency model that can be provided while maintaining high availability (surviving partitions).

## Related
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clocks]]
- [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]]
