# Parallel: Parallel Selection

In a parallel selection, each node executes a local selection operator on its portion of the data. This is the simplest parallel operator because no data needs to move between nodes.

- **Execution**: The **Coordinator** tells every **Worker** node to run the selection operator. Every node treats its local data partition as its own independent database.
- **Cost Analysis**:
  - Assume a table $R$ is **[[CSE444/Parallel/Data Partitioning Schemes|block partitioned]]** across $N$ nodes.
  - On a conventional (single-node) database, the cost is $B(R)$ block reads.
  - On a parallel DBMS with $N$ nodes, the cost for each node is $B(R)/N$.
- **Data Parallelism**: Selection is highly data-parallel because tuples can be filtered independently without communication between nodes.

![[CSE444/Screenshots/Parallel Selection.png]]

## Implicit Union
Parallel query plans typically perform an **implicit union** at the end of the pipeline. The results from all worker nodes are piped back to the coordinator (master) node to be presented to the user.

![[CSE444/Screenshots/Implicit Union.png]]

---

## Related

- [[CSE444/Parallel/Parallel Query Execution|Parallel Query Execution]] — parent hub for parallel operators
- [[CSE444/Parallel/ParallelExecutionComponents/The Shuffle Operator|The Shuffle Operator]] — the mechanism used when an operator (unlike selection) does require data movement

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Implicit Union | Result gathering |
| Coordinator / Worker | Driver / Executor (Spark); Leader / Compute node |
