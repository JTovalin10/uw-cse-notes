# CAP Theorem

**[[CAP Theorem]]**: (Brewer's Theorem) States that a distributed data store can provide at most two out of three guarantees: **Consistency** (all nodes see the same data), **Availability** (every request gets a response), and **Partition Tolerance** (the system continues to operate despite network failures).

## The Trade-off
Since partitions (P) are inevitable in real networks, systems must choose between:
- **CP**: Consistency and Partition Tolerance (Wait for consensus, sacrifice availability).
- **AP**: Availability and Partition Tolerance (Respond immediately, sacrifice consistency).

## Related
- [[CSE452/Consistency/CAP Theorem and Partitions|CAP Theorem and Partitions (Detailed)]]
- [[CSE452/Consistency/Definitions/PACELC Theorem|PACELC Theorem]]

