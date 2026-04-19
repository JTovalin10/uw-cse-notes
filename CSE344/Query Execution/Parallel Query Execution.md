# CSE344: Parallel Query Execution

## Parallelizing Data Management

### Sublinear Expected Performance

Parallel computing is not a magic bullet. Common reasons for sublinear (less-than-ideal) speedup:

- **Overhead cost**: starting and coordinating operations across many nodes
- **Interference/contention**: shared resources are not perfectly split
- **Skew**: a process is only as fast as its slowest node

### Architecture Parallelism (Hardware)

- **Shared memory**: all processors share a single memory pool
	- Expensive to scale
	- Easiest to implement on
	- ![[Shared-Memory.png]]

- **Shared disk**: processors have separate memory but share disk storage
	- No contention for memory; high availability
	- Typically 1–10 machines
	- ![[Shared-Disk.png]]

- **Shared nothing**: each node has its own memory and disk; nodes communicate over a network
	- Uses cheap commodity hardware
	- No contention for memory; high availability
	- Theoretically can scale infinitely
	- Hardest to implement on
	- ![[Share-nothing arch.png]]

### Query Parallelism (Software)

- **Inter-query parallelism**: each entire query is processed on a single node
	- Scales well for many simple transactions (OLTP)

- **Intra-query parallelism**: each operator instance is processed by multiple nodes
	- Scales well for complex analytical queries (OLAP)

## Partitioning

### Data Replication vs. Partitioning

- **Data replication**: copy the entire dataset to each node
	- Expensive
	- OLAP workloads unlikely to cause consistency issues
	- Mostly used for intra-query parallelism

- **Data partitioning** (sharding): split the dataset; each node holds a subset
	- Avoiding consistency issues is complicated
	- Can accommodate OLTP workloads
	- Rarely compatible with OLAP workloads, which usually require the full dataset
	- Commonly used in inter-operator parallelism

### Horizontal vs. Vertical Partitioning

- **Horizontal partitioning**: every attribute is available on each replica, but not every tuple (subset of rows)
- **Vertical partitioning**: all values of an attribute are available on each replica, but not every attribute (subset of columns)

### Horizontal Partitioning Strategies

Given input data size $N$ and $p$ servers/nodes:

| Strategy | Description |
|---|---|
| **Block** | Tuples are partitioned by chunk size (number of bytes) |
| **Range** | Each chunk contains tuples whose attribute value falls in a given range |
| **Hash** | Each node contains tuples whose attribute hash falls in a given range |

## Skew

### Partition Quality

In a **uniform partition**, chunks have roughly equal sizes:
$$|R_1| \approx |R_2| \approx \cdots \approx |R_p| \approx \frac{|R|}{p}$$

In a **skewed partition**, some $|R_i| \gg \frac{|R|}{p}$:
- Block: always uniform
- Range: may be skewed
- Hash: may be skewed

**Skew** occurs when one task runs much longer than the others:
- **Data skew**: one partition has far more tuples
- **Computation skew**: one partition's tuples are more expensive to process

## The Shared-Nothing Model

### Partitioned Selection $\sigma$

Each node computes the selection independently; results are implicitly unioned.
- If data is hash-partitioned on the selection attribute, only one node needs to run the selection

![[Partitoned Selection.png]]

### Partitioned Aggregation $\gamma$

1. **Shuffle** tuples over the network so that all related ones are on the same machine
2. Aggregate locally
3. Union results at the end

![[Partitoned Aggregation.png]]

### Partitioned Joins $\bowtie$

See [[Parallel Join Algorithms]] for the full descriptions of:
- **Partitioned Hash Join** — shuffle on join key, local join
- **Broadcast Join** — broadcast the smaller table, local join
- **Skew Join** — handles heavy hitters with a hybrid approach

## Related
- [[Parallel Join Algorithms]] — detailed algorithms for parallel joins
- [[Physical Algorithms and Pipelining]] — the single-node algorithms that each node runs locally
- [[Pipelined Execution]] — how operators within a node stream tuples
- [[Cardinality Estimation]] — skew directly affects cardinality estimates
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — data layout choices interact with partitioning strategies
- [[CSE451/Memory Management/Memory management|Memory Management]] — OS-level resource sharing that parallels shared-memory/shared-nothing architectures
