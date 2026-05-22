# Parallel: Partitioned Aggregation

To compute an aggregate (e.g., `SUM`, `COUNT`, `GROUP BY`) in parallel, the system must ensure that all tuples belonging to the same group are processed together.

![[CSE444/Screenshots/Partitioned Aggregation.png]]

## Two Cases
Whether a [[CSE444/Parallel/ParallelExecutionComponents/The Shuffle Operator|shuffle]] is needed at all depends on how $R$ is already partitioned. Consider `SELECT A, sum(B) FROM R GROUP BY A`:

1. **$R$ is partitioned on $A$**: All tuples of a group already live on the same node, so each node does the **group-by locally** and the query is done — no network traffic.
2. **$R$ is partitioned on something else**: Tuples of the same group are scattered across nodes, so a reshuffle is required.
   - **Naive**: Reshuffle every tuple on $A$, then aggregate as in case 1. This moves a lot of data over the network.
   - **Better**: Do a local group-by-sum first to shrink the size of the tuples, then reshuffle on $A$ and do a second group-by. (This is the combiner optimization described below.)

## Two Approaches to Aggregation

1. **Naive Reshuffle**:
   - Reshuffle all tuples based on the `GROUP BY` attribute $A$.
   - Perform the local aggregation on each node.
   - **Drawback**: High network traffic if many tuples are shuffled.

2. **Partial Aggregation (Combiners)**:
   - **Local Aggregation**: Each node first computes a "partial" aggregate on its local data. This significantly reduces the number of tuples.
   - **Reshuffle**: Shuffle only the partial results.
   - **Global Aggregation**: Each node computes the final aggregate from the partial results it received.

![[CSE444/Screenshots/Partitioned Aggregation Union.png]]

### With and Without Combiners
Using combiners (partial aggregation) is a critical optimization for network-bound queries and for reducing network traffic.
- **Example**: If a table has millions of tuples but only 10 distinct groups, a local aggregate reduces millions of rows to just 10 before they are sent over the network.
- **Network vs. Disk**: In modern data centers, network bandwidth is often higher than disk I/O, but minimizing network congestion remains vital for scalability.

![[CSE444/Screenshots/With and Without Combiners.png]]

---

## Related

- [[CSE444/Parallel/Parallel Query Execution|Parallel Query Execution]] — parent hub for parallel operators
- [[CSE444/Parallel/ParallelExecutionComponents/The Shuffle Operator|The Shuffle Operator]] — the redistribution mechanism used by the naive and combiner approaches
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — the single-node version of aggregation

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Combiner | Partial Aggregate, Local Aggregate, Map-side Combine |
| Naive Reshuffle | Repartition / Full shuffle aggregate |
