# CSE452: Key Takeaways in Performance and Durability

Case studies like **[[Google File System (GFS)|Google File System (GFS)]]**, **[[Big Table|Big Table]]**, and **[[Dynamo|Dynamo]]** highlight several recurring strategies for building high-performance, durable, and available distributed systems at scale.

---

## Performance Strategies

The primary goal for performance is to maximize hardware utilization (especially sequential throughput on HDDs) and minimize the overhead of consensus.

### Avoiding Paxos in the Critical Path
While **[[Paxos|Paxos]]** is necessary for correctness in the face of failures, it is often too slow for every individual operation due to the multiple network round-trips required for agreement.
- **Leases**: Instead of reaching consensus on every write, a master can **lease** a shard or file chunk to a specific server for a set duration (e.g., 60 seconds).
- The lease holder has full control over that data for the duration of the lease.
- Leases are extended as long as the shard is in use, avoiding the need for constant re-negotiation with a **[[Shard Master|Shard Master]]**.

### Workload-Specific Optimization
Systems must be designed for their specific expected workload rather than being "general purpose" at the cost of performance.
- **Large vs. Small Pages**: GFS optimizes for very large files (hundreds of megabytes) because that was the primary Google workload. It "eats the cost" of inefficiency for small files to gain massive throughput on large ones.
- **Hardware Alignment**: Aligning software patterns with physical hardware strengths. For example, using **sequential reads and writes** to maximize Hard Disk Drive (HDD) throughput, even if it complicates the application logic.

### Pushing Complexity to the Application
To keep the core system fast, some consistency guarantees can be offloaded to the application layer.
- **Selective Linearizability**: Instead of making the entire system **[[Linearizability|linearizable]]**, a system might only guarantee it for metadata, leaving the application to handle potential inconsistencies in the data itself (e.g., via checksums or application-level deduplication).
- **Bottleneck Management**: Identify the single point of failure or performance bottleneck (like a master node) and minimize the data that must pass through it. 

## Latency and Availability

In large-scale systems, performance is often measured not by the average case, but by the "worst-case" behavior.

### Tail Latency
- **99.9th Percentile (P99.9)**: Large companies prioritize the 99.9th percentile latency over the median (P50). 
- If a user's request triggers 100 sub-requests to different services, the overall latency is dominated by the slowest sub-request. Therefore, even a "one in a thousand" slow request can impact a significant portion of total traffic.
- **Tail Latency Factors**: Network congestion, background garbage collection, and hardware "hiccups" all contribute to tail latency.

### Availability vs. Consistency (CAP Tension)
There is a fundamental tension between **[[Consistency|Consistency]]** and **[[Dynamo#Core Philosophy: Availability > Consistency|Availability]]**.
- **Strong Consistency (CP)**: Prioritizes data correctness. If the network is partitioned, writes are blocked to prevent divergence (e.g., Paxos-based systems).
- **High Availability (AP)**: Prioritizes service uptime. Writes are always accepted, even if it means data becomes temporarily inconsistent or "stale" (e.g., Dynamo).
- **Business Impact**: For companies like Amazon, availability directly impacts revenue. A customer cannot buy items if the shopping cart is unavailable due to a network partition.

## Durability and Fault Tolerance

Durability ensures that once data is written, it is not lost even if multiple components fail.

### Rack-Aware Replication
In a large datacenter, failures are correlated. A single power failure or switch failure can take out an entire rack of servers.
- **Cross-Rack Spreading**: To ensure durability, replicas of the same data must be spread across different physical **dataracks**. This ensures that the loss of one rack does not result in the loss of all copies of the data.

### Security and Verification
Implementing security (encryption, authentication, and data verification) often comes at a performance cost.
- **Checksums**: Used to verify data integrity against bit rot or disk failures.
- **Verification Overhead**: Every layer of verification adds latency. Systems must decide where to "trust" the hardware and where to verify software-level invariants.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Lease** | Distributed Lock with Expiration / TTL |
| **Datarack** | Availability Zone (AZ) / Fault Domain |
| **Linearizability** | Strong Consistency |
| **Sequential I/O** | Streaming I/O |
| **99.9th Percentile** | P99.9 / Tail Latency |

---

## Related

- [[Google File System (GFS)|Google File System (GFS)]] — a case study in workload-specific optimization
- [[Big Table|Big Table]] — a case study in layering systems to avoid Paxos in the critical path
- [[Dynamo|Dynamo]] — a case study in prioritizing availability over consistency
- [[Shard Master|Shard Master]] — the service that manages shard assignments and leases
- [[Paxos|Paxos]] — the foundation for the fault-tolerant metadata services
- [[CSE351/Memory Fundamentals/Physical Memory|Physical Memory (CSE351)]] — underlying hardware concepts related to performance