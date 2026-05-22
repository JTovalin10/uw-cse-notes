# Parallel: The Shuffle Operator

A **shuffle** (or re-shuffle) is the mechanism used to redistribute data between nodes during query execution. It is the shared building block underneath both [[CSE444/Parallel/ParallelExecutionComponents/Partitioned Aggregation|Partitioned Aggregation]] and the [[CSE444/Parallel/ParallelExecutionComponents/Partitioned Hash Join|Partitioned Hash Join]] — any operator whose tuples must be co-located before processing relies on it.

- **Producer**: Pulls data from a child operator and routes it to $N$ consumers based on a partitioning function (e.g., hash of the `GROUP BY` or join attribute).
- **Consumer**: Buffers input data from $N$ producers and provides it to the parent operator via the `getNext()` interface.

## Parallel Query Evaluation Pipeline
Modern parallel DBMSs use a producer-consumer model for shuffling data between processes.

- **Servers**: Dedicated processes handle data routing, buffering, and flow control between nodes.
- **Independent Execution**: Every node acts independently until a shuffle point is reached, at which point nodes must synchronize and exchange data.

![[CSE444/Screenshots/Parallel Query Execution.png]]

---

## Related

- [[CSE444/Parallel/Parallel Query Execution|Parallel Query Execution]] — parent hub for parallel operators
- [[CSE444/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — the partitioning functions a shuffle uses to route tuples

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Shuffle | Exchange (SQL Server/PostgreSQL), Redistribution |
| Producer/Consumer | Exchange operators |
