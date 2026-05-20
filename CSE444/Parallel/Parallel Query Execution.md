# Parallel: Query Execution

Parallel query execution leverages multiple nodes in a **shared-nothing architecture** to execute relational operators concurrently. The system achieves speedup by partitioning data and distributing operator execution across the cluster.

---

## Parallel Selection

In a parallel selection, each node executes a local selection operator on its portion of the data.

- **Execution**: The **Coordinator** tells every **Worker** node to run the selection operator. Every node treats its local data partition as its own independent database.
- **Cost Analysis**:
  - Assume a table $R$ is **block partitioned** across $N$ nodes.
  - On a conventional (single-node) database, the cost is $B(R)$ block reads.
  - On a parallel DBMS with $N$ nodes, the cost for each node is $B(R)/N$.
- **Data Parallelism**: Selection is highly data-parallel because tuples can be filtered independently without communication between nodes.

![[CSE444/Screenshots/Parallel Selection.png]]

### Implicit Union
Parallel query plans typically perform an **implicit union** at the end of the pipeline. The results from all worker nodes are piped back to the coordinator (master) node to be presented to the user.

![[CSE444/Screenshots/Implicit Union.png]]

---

## Partitioned Aggregation

To compute an aggregate (e.g., `SUM`, `COUNT`, `GROUP BY`) in parallel, the system must ensure that all tuples belonging to the same group are processed together.

![[CSE444/Screenshots/Partitioned Aggregation.png]]

### The Shuffle Operator
A **shuffle** (or re-shuffle) is the mechanism used to redistribute data between nodes during query execution.
- **Producer**: Pulls data from a child operator and routes it to $N$ consumers based on a partitioning function (e.g., hash of the `GROUP BY` attribute).
- **Consumer**: Buffers input data from $N$ producers and provides it to the parent operator via the `getNext()` interface.

### Two Approaches to Aggregation

1. **Naive Reshuffle**:
   - Reshuffle all tuples based on the `GROUP BY` attribute $A$.
   - Perform the local aggregation on each node.
   - **Drawback**: High network traffic if many tuples are shuffled.

2. **Partial Aggregation (Combiners)**:
   - **Local Aggregation**: Each node first computes a "partial" aggregate on its local data. This significantly reduces the number of tuples.
   - **Reshuffle**: Shuffle only the partial results.
   - **Global Aggregation**: Each node computes the final aggregate from the partial results it received.

![[CSE444/Screenshots/Partitioned Aggregation Union.png]]

#### With and Without Combiners
Using combiners (partial aggregation) is a critical optimization for network-bound queries.
- **Example**: If a table has millions of tuples but only 10 distinct groups, a local aggregate reduces millions of rows to just 10 before they are sent over the network.
- **Network vs. Disk**: In modern data centers, network bandwidth is often higher than disk I/O, but minimizing network congestion remains vital for scalability.

![[CSE444/Screenshots/With and Without Combiners.png]]

---

## Partitioned Hash Equijoin

The most common parallel join algorithm is the **Partitioned Hash Join**.

1. **Hash Shuffle**: Both input relations are shuffled across nodes using a hash function on the join attribute. This ensures that any two tuples that could possibly match are sent to the same node.
2. **Local Join**: Each node performs a standard **hash join** (e.g., Grace Join) on its local partitions.

![[CSE444/Screenshots/Partitioned Hash Equijoin Algorithm.png]]
![[CSE444/Screenshots/Multiple Shuffles.png]]

---

## Parallel Query Evaluation Pipeline

Modern parallel DBMSs use a producer-consumer model for shuffling data between processes.

- **Servers**: Dedicated processes handle data routing, buffering, and flow control between nodes.
- **Independent Execution**: Every node acts independently until a shuffle point is reached, at which point nodes must synchronize and exchange data.

![[CSE444/Screenshots/Parallel Query Execution.png]]

---

## Related

- [[CSE444/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — how the initial distribution of data affects operator performance
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — the single-node versions of these join and aggregate algorithms
- [[CSE444/Replication and distribution/Distributed Databases|Distributed Databases]] — concepts of MPP and sharding

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Shuffle | Exchange (SQL Server/PostgreSQL), Redistribution |
| Combiner | Partial Aggregate, Local Aggregate, Map-side Combine |
| Producer/Consumer | Exchange operators |
| Implicit Union | Result gathering |
| Partitioned Hash Join | Parallel Hash Join; Shuffled Join |