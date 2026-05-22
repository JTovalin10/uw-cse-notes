# Parallel: Data Partitioning Schemes

In a **shared-nothing architecture**, the central design question is where each row of data lives. The answer is determined by the chosen **partitioning scheme**, which horizontally (row-level) distributes tuples across the nodes in a cluster.

---

## Unpartitioned Table

The entire table lives on a single node in the cluster.

- **Consequence**: Any query that touches this table bottlenecks at that one node — no parallelism is achievable.
- **Use case**: Used only for simplicity or for very small reference tables that don't need parallelism.

## Block Partitioning

Tuples are partitioned by block size, with no ordering of the data considered.

- **Mechanism**: Rows are split evenly between nodes, typically in a round-robin style.
- **Pros**: No **data skew** — each node receives roughly the same number of rows.
- **Cons**: Because there is no ordering, range queries or selective predicates cannot be routed to a specific node; every node must be consulted.

![[CSE444/Screenshots/Block Partitioning.png]]

## Range Partitioning

Nodes contain tuples within specific attribute ranges.

- **Mechanism**: We check the tuple's value against defined "split points" to determine its destination node.
- **Pros**: Provides simpler guarantees than hashing; allows for efficient range queries because we only need to visit the nodes covering the requested range.
- **Cons**: Requires determining optimal split points based on the data distribution.
- **Risk**: Highly susceptible to **data skew** if the distribution changes and ranges are not re-balanced.

![[CSE444/Screenshots/Range Partition.png]]

## Hash Partitioning

Nodes contain tuples based on a hash of chosen attributes.

- **Mechanism**: Use a hash function $h(K) \pmod N$ where $K$ is the partitioning key and $N$ is the number of nodes.
- **Pros**: Guarantees that all tuples with the same value of the hash key will be clustered together on the same node. This is highly efficient for joins on the partitioning key.
- **Cons**: Like range partitioning, it can suffer from skew if many rows share the same key value (the "heavy hitter" problem).

![[CSE444/Screenshots/Hash Partitioning.png]]

---

## Skew: The Justin Bieber Effect

**Data Skew** occurs when data is not distributed uniformly across nodes, leading to certain nodes becoming bottlenecks.

- **The Justin Bieber Effect**: Named for a period on Twitter when Justin Bieber had significantly more followers than other users. If data (like tweets) is partitioned by user ID, the node responsible for his ID would be overwhelmed by the volume of follower interactions.
- **Impact**: The speed of the parallel system is limited by its slowest node (the bottleneck).
### Skew Handling

- **Range Partitioning**: Ensure each range gets roughly the same number of tuples using **equi-depth histograms** rather than equi-width. A range is split once the number of tuples it holds exceeds a threshold $n$, so each resulting partition stays balanced regardless of how values cluster.
- **Histograms**: Use snapshots of data distribution history to determine split points. These must be periodically updated as the data changes.

#### Skew-Join
A **skew-join** handles a join where one key value dominates (a "Justin Bieber" value).

- **More partitions than nodes**: Create more partitions than there are nodes. This works as long as the skew is confined to at most one node. **MapReduce** uses this approach.
- **Subset-replicate**: Handle the heavy-hitter values separately from the rest.
  - For the "Justin Bieber values", separate them out and do a **[[CSE444/Parallel/ParallelExecutionComponents/Partitioned Hash Join#Broadcast Join (Optimizing for Small Relations)|broadcast join]]**.
  - Split those heavy-hitter values evenly among all nodes so no single node is overwhelmed.
  - Once they are split up, all nodes can join them.
  - Do a regular **hash join** for the rest of the tuples that do not have skew. (If $S$ was small enough, even those can use a broadcast join.)

![[CSE444/Screenshots/Skew Join Algorithm.png]]

---

## Related

- [[CSE444/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] — the hardware architectures that necessitate these partitioning schemes
- [[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]] — how histograms are used to estimate cardinality and distribution
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — how specific operators like joins benefit from partitioned data

---

## Industry Standard Terms

| Course Term | Industry / Real-World Equivalent |
|---|---|
| Block Partitioning | Round-robin partitioning |
| Hash Partitioning | Sharding by key; Distributed Hash Table (DHT) |
| Range Partitioning | Sharding by range |
| Data Skew | Key skew; hot spots |
| Justin Bieber Effect | Heavy hitter problem; power-law distribution |