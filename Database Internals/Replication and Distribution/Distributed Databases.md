# Course: Distributed Databases

Distributed databases spread data across multiple physical machines to provide horizontal scalability (scaling out) and high availability.

## System Architectures

### Shared-Disk
All compute nodes connect to a single, centralized storage system (e.g., a Storage Area Network). 
- **Pro**: Easy to manage and load balance.
- **Con**: Storage becomes the bottleneck as the cluster grows.

### Shared-Nothing
Each node has its own private CPU, RAM, and Disk. Nodes communicate over a high-speed network.
- **Pro**: High scalability and fault tolerance.
- **Con**: Requires complex data partitioning and distributed query logic.

## Data Partitioning (Sharding)

**Sharding** is the process of splitting a table into smaller chunks (shards) and distributing them across nodes.

### Sharding Strategies
- **Hash Sharding**: Uses a hash function on a **Shard Key** to determine the node. Provides uniform data distribution but makes range queries expensive (requires scanning all nodes).
- **Range Sharding**: Assigns contiguous ranges of a Shard Key to specific nodes. Excellent for range queries but prone to **Data Skew** (hotspots) if data is not evenly distributed.

## Distributed Query Execution

In a **Massively Parallel Processing (MPP)** system, a query is coordinated by a single node but executed in parallel across the cluster.

### Distributed Joins
1. **Broadcast Join**: One small table is copied to every node in the cluster to join with the local shard of a large table.
2. **Shuffle (Partitioned) Join**: Both tables are re-hashed by the join key and moved across the network so that matching keys end up on the same node.

### Data Skew
**Data Skew** occurs when a disproportionate amount of data or query load falls on a single node, causing it to become a bottleneck for the entire cluster.

## Distributed Transactions

Ensuring ACID across multiple nodes requires specialized protocols.

### Two-Phase Commit (2PC)
1. **Prepare Phase**: The coordinator asks all participating nodes if they can commit. Nodes log a 'prepare' record and respond.
2. **Commit Phase**: If everyone says 'Yes', the coordinator tells everyone to commit. Otherwise, it tells everyone to abort.

### Distributed Deadlock
A deadlock can occur across multiple nodes (e.g., Node A waits for Node B, Node B waits for Node A). Detecting this requires a **Global Wait-For Graph** or a timeout mechanism.

## Related
- [[Distributed Systems/Index|CSE452 Distributed Systems]]
- [[Transaction Fundamentals|Transaction Fundamentals]]
