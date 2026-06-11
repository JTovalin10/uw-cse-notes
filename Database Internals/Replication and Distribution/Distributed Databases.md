# Database Internals: Distributed Databases

Distributed databases spread data across multiple physical machines to provide horizontal scalability (scaling out) and high availability. The core tension is that distributing data improves throughput and fault tolerance, but introduces coordination overhead for transactions that span multiple nodes.

## System Architectures

See [[Database Internals/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] for a detailed breakdown of the three hardware architectures. In brief:

### Shared-Disk

All compute nodes connect to a single, centralized storage system (e.g., a Storage Area Network).
- **Pro**: Easy to manage and load balance. Any node can read any data.
- **Con**: Storage becomes the bottleneck as the cluster grows. The shared SAN/NAS can saturate under heavy I/O.

### Shared-Nothing

Each node has its own private CPU, RAM, and disk. Nodes communicate exclusively over a network.
- **Pro**: High scalability and fault tolerance. Uses cheap commodity hardware.
- **Con**: Requires complex data partitioning, distributed query logic, and coordination protocols for cross-node transactions.

The **shared-nothing** architecture is the dominant design for modern distributed databases and data warehouses (e.g., Amazon Redshift, Snowflake, Google BigQuery).

## Data Partitioning (Sharding)

**Sharding** is the process of splitting a table into smaller chunks (**shards**) and distributing them across nodes. The choice of partitioning scheme fundamentally determines which queries are fast.

### Sharding Strategies

See [[Database Internals/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] for full details, including skew handling. In brief:

- **Hash Sharding**: Uses a hash function on a **Shard Key** to determine the destination node. Provides uniform data distribution and guarantees that all rows with the same shard key value land on the same node. Range queries are expensive — all nodes must be consulted.
- **Range Sharding**: Assigns contiguous ranges of a shard key to specific nodes. Enables efficient range queries because only the relevant range nodes need to be consulted. Prone to **Data Skew** (hotspots) if data is not evenly distributed across ranges.

## Distributed Query Execution

In a **Massively Parallel Processing (MPP)** system, a query is coordinated by a single **coordinator** node but executed in parallel across the cluster's **worker** nodes.

### Distributed Joins

1. **Broadcast Join**: One small table is replicated to every node in the cluster, which then joins it against its local shard of the large table. Only one (small) relation crosses the network. Efficient when $|R| \gg |S|$ and $S$ fits in memory per node.
2. **Shuffle (Partitioned) Join**: Both tables are re-hashed by the join key and redistributed so that matching keys end up on the same node. Each node then performs a local join on its portion. Handles large relations on both sides.

See [[Database Internals/Parallel/ParallelExecutionComponents/Partitioned Hash Join|Partitioned Hash Join]] for the full algorithm walkthrough.

### Data Skew

**Data Skew** occurs when a disproportionate amount of data or query load falls on a single node, causing it to become a bottleneck for the entire cluster. The speed of the parallel system is limited by its slowest node. See [[Database Internals/Parallel/Data Partitioning Schemes#Skew: The Justin Bieber Effect|Data Partitioning Schemes — Skew]] for the skew-join algorithm.

## Distributed Transactions

Ensuring ACID across multiple nodes requires specialized protocols. When a transaction spans multiple shards, a single-node commit protocol is insufficient — all involved nodes must agree on the outcome.

### Two-Phase Commit (2PC)

**Two-Phase Commit (2PC)** is the standard protocol for ensuring atomicity in distributed transactions. It consists of a **Prepare Phase** (voting) and a **Commit Phase** (decision broadcast). See detailed notes: [[Database Internals/Distributed Systems/Two-Phase Commit|Two-Phase Commit (2PC)]].

### Distributed Deadlock

A deadlock can occur across multiple nodes (e.g., Node A holds a lock Node B needs, and Node B holds a lock Node A needs). Detecting this requires constructing a **Global Wait-For Graph** — a union of the local wait-for graphs from all nodes — or using a **timeout mechanism** that aborts the transaction if it waits too long.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Sharding | Horizontal partitioning / data distribution |
| Shard Key | Partition key / distribution key |
| Shared-Nothing | MPP (Massively Parallel Processing) |
| Shared-Disk | Shared storage cluster / Oracle RAC |
| Data Skew | Hot spot / key skew |
| Coordinator | Query coordinator / driver node |
| Worker | Compute node / executor |
| Two-Phase Commit (2PC) | Distributed commit protocol / XA protocol |
| Global Wait-For Graph | Distributed deadlock detection graph |

## Related

- [[Database Internals/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] — the hardware architectures underlying distributed databases
- [[Database Internals/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — block, range, and hash partitioning with skew handling
- [[Database Internals/Parallel/Parallel Query Execution|Parallel Query Execution]] — parallel operators: selection, shuffle, aggregation, hash join
- [[Database Internals/Distributed Systems/Two-Phase Commit|Two-Phase Commit (2PC)]] — the atomicity protocol for distributed transactions
- [[Database Internals/Distributed Systems/Replication|Replication]] — the complementary scaling axis (duplicating data vs. sharding it)
- [[Distributed Systems/Index|CSE452 Distributed Systems]] — distributed systems course coverage of replication and consensus
- [[Transaction Fundamentals|Transaction Fundamentals]] — ACID properties that distributed transactions must preserve
