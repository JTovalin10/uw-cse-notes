# CSE452: Big Ideas in Performance and Durability

Case studies like [[CSE452/Case Studies/Google File System (GFS)|Google File System (GFS)]] and [[CSE452/Case Studies/Big Table|Big Table]] highlight several recurring strategies for building high-performance, durable distributed systems at scale.

## Performance Strategies

The primary goal for performance is to maximize hardware utilization (especially sequential throughput on HDDs) and minimize the overhead of consensus.

### Avoiding Paxos in the Critical Path
While [[CSE452/Paxos/Paxos|Paxos]] is necessary for correctness in the face of failures, it is too slow for every individual operation.
- **Leases**: Instead of reaching consensus on every write, a master can **lease** a shard or file chunk to a specific server for a set duration (e.g., 60 seconds).
- The lease holder has full control over that data for the duration of the lease.
- Leases are extended as long as the shard is in use, avoiding the need for constant re-negotiation with a [[CSE452/Sharding/Shard Master|Shard Master]].

### Workload-Specific Optimization
Systems must be designed for their specific expected workload rather than being "general purpose" at the cost of performance.
- **Large vs. Small Pages**: GFS optimizes for very large files (hundreds of megabytes) because that was the primary Google workload. It "eats the cost" of inefficiency for small files to gain massive throughput on large ones.
- **Hardware Alignment**: Aligning software patterns with physical hardware strengths. For example, using **sequential reads and writes** to maximize Hard Disk Drive (HDD) throughput, even if it complicates the application logic.

### Pushing Complexity to the Application
To keep the core system fast, some consistency guarantees can be offloaded to the application layer.
- **Selective Linearizability**: Instead of making the entire system **[[CSE452/Consistency/Definitions/Linearizability|linearizable]]**, a system might only guarantee it for metadata, leaving the application to handle potential inconsistencies in the data itself (e.g., via checksums or application-level deduplication).
- **Bottleneck Management**: Identify the single point of failure or performance bottleneck (like a master node) and minimize the data that must pass through it. If a bottleneck cannot be avoided, it must be prioritized for a fix later in the development lifecycle.
## Latency
we have to consider latency, most people consider median latency but larger companies consider a 99.9th percentile latency. 
- called tail latency
- however, this latency doesnt consider other failure's like network failure
- this tends to deal with the network, so we must reduce network load
- median latency is also called 50th percentile latency
## Security
- when building the software, we have to consider who is using it?
	- do we need secruity
	- do we need to verify?
	- all of theser will reduce performance
## Writes
- sacriface strong consistency to allow for better performance
- pass inconssitency to clients (if applicable)
## Durability and Fault Tolerance

Durability ensures that once data is written, it is not lost even if multiple components fail.

- **Rack-Aware Replication**: In a large datacenter, a single power failure or switch failure can take out an entire rack of servers.
- **Cross-Rack Spreading**: To ensure durability, replicas of the same data must be spread across different physical **dataracks**. This ensures that the loss of one rack does not result in the loss of all copies of the data.
## Avaliability
- For databases, relational databases destroies avaliability as they pritoize Consistency
- strong consistency reduces avaliability
## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Lease** | Distributed Lock with Expiration / TTL |
| **Datarack** | Availability Zone (AZ) / Fault Domain |
| **Linearizability** | Strong Consistency |
| **Sequential I/O** | Streaming I/O |

---

## Related

- [[CSE452/Case Studies/Google File System (GFS)|Google File System (GFS)]] — a case study in workload-specific optimization
- [[CSE452/Case Studies/Big Table|Big Table]] — a case study in layering systems to avoid Paxos in the critical path
- [[CSE452/Sharding/Shard Master|Shard Master]] — the service that manages shard assignments and leases
- [[CSE452/Paxos/Paxos|Paxos]] — the foundation for the fault-tolerant metadata services
- [[CSE451/Memory Fundamentals/Physical Memory|Physical Memory (CSE351)]] — underlying hardware concepts related to performance