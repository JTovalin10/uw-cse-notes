# Parallel: Query Execution

Parallel query execution leverages multiple nodes in a **shared-nothing architecture** to execute relational operators concurrently. The system achieves speedup by partitioning data and distributing operator execution across the cluster.

This topic is split into focused components, ordered from the simplest operator to the performance analysis that ties them together:

- [[CSE444/Parallel/ParallelExecutionComponents/Parallel Selection|Parallel Selection]] — the simplest parallel operator (no data movement) plus the implicit union of worker results.
- [[CSE444/Parallel/ParallelExecutionComponents/The Shuffle Operator|The Shuffle Operator]] — the producer-consumer mechanism that redistributes tuples between nodes, shared by aggregation and joins.
- [[CSE444/Parallel/ParallelExecutionComponents/Partitioned Aggregation|Partitioned Aggregation]] — the two partitioning cases, naive reshuffle vs. combiners (partial aggregation).
- [[CSE444/Parallel/ParallelExecutionComponents/Partitioned Hash Join|Partitioned Hash Join]] — the partitioned hash equijoin, its algorithm walkthrough, and the broadcast-join optimization.
- [[CSE444/Parallel/ParallelExecutionComponents/Speedup and Scaleup|Speedup and Scaleup]] — how runtime responds to adding nodes (speedup) and growing data with nodes (scaleup).

---

## Related

- [[CSE444/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — how the initial distribution of data affects operator performance
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — the single-node versions of these join and aggregate algorithms
- [[CSE444/Replication and Distribution/Distributed Databases|Distributed Databases]] — concepts of MPP and sharding

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Shuffle | Exchange (SQL Server/PostgreSQL), Redistribution |
| Combiner | Partial Aggregate, Local Aggregate, Map-side Combine |
| Producer/Consumer | Exchange operators |
| Implicit Union | Result gathering |
| Partitioned Hash Join | Parallel Hash Join; Shuffled Join |
| Broadcast Join | Map-side join; Replicated join |
