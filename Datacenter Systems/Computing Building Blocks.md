# Datacenter Systems: Computing Building Blocks

To increase capacity, a system can **scale up** (buy a bigger single machine) or **scale out** (add more machines). Scaling out with clusters of low-end or mid-range servers has been more cost-effective than using high-end shared-memory systems. This note builds a simple model of why, then examines how small each scale-out server should be, and finally how the answer changes for accelerators.

## A Model to Reason About Scale-Out vs Scale-Up

### The Naive Cost Argument

A simple processor-centric cost-efficiency analysis says that a single server of capacity $N \times M$ is more expensive than $N$ servers of capacity $M$. High-end machines carry a price premium, so on cost alone scale-out wins.

This analysis fails to consider communication. A large **Symmetric Multiprocessor (SMP)** server (a single machine whose cores all share one memory) has far better intercommunication performance than a cluster of smaller servers (many separate machines connected over a network):

| | SMP server (scale-up) | Cluster of servers (scale-out) |
| :--- | :--- | :--- |
| Shared memory | One address space across all cores | Each server has private DRAM |
| Cost of reaching data on another core or node | Latency on the order of 100 nanoseconds | Network round trip on the order of 100 microseconds |
| Failure and cost profile | Expensive, large failure domain | Cheap commodity parts |

The SMP advantage only applies to workloads that fit on a single SMP. Once a workload outgrows one machine, it must communicate over the network anyway.

### Accessing a Remote Node Is Slower Than DRAM

Going to another node moves the cost of an access from nanoseconds (local DRAM) to microseconds (network). Assume a fixed local computation time of 1 ms per unit of work. The program execution time is then:

$$\text{time} = 1\text{ms} + f \cdot \left(100\text{ns} \cdot \text{LocalAccessFraction} + 100\mu\text{s} \cdot \text{RemoteAccessFraction}\right)$$

- $f$ is the number of global accesses per work unit (1 ms).
- If accesses to the global store are uniformly distributed among nodes, the fraction of global accesses that map to the local node is $1/N$, where $N$ is the number of nodes. The remaining $(N-1)/N$ are remote.

Substituting:

$$\text{time} = 1\text{ms} + f \cdot \left(\tfrac{1}{N} \cdot 100\text{ns} + \tfrac{N-1}{N} \cdot 100\mu\text{s}\right)$$

Because $\tfrac{N-1}{N}$ rises quickly toward 1, almost every access becomes remote after only a few nodes. The remote term dominates, and $f$ controls how much it hurts.

### Reading the Graphs

![[Performance in Hypothetical SMP Clusters.png]]

- The y-axis is normalized execution time relative to a single large SMP server, and the x-axis is the number of nodes in the cluster.
- Workloads with more communication (larger $f$) are penalized much more. For high communication, execution time jumps sharply from 1 to 2 nodes, because going from 1 node (everything local) to 2 nodes (half of accesses remote) introduces the expensive remote term.
- After a few nodes the curve flattens: the fraction of remote accesses is already close to 1, so adding more nodes costs little extra per access.

![[Performance Advantage of Large SMP Servers.png]]

- The y-axis is the performance edge a cluster gains from using high-end (large SMP) nodes, and the x-axis is the cluster size.
- The edge shrinks as the cluster grows. For a large cluster most accesses are remote regardless of node size, so paying for big SMP nodes buys little. Due to their high cost, large SMPs are not a worthwhile investment as the number of cores increases.
- The edge is largest for high-communication workloads and nearly zero for light-communication ones.

The takeaway is that we need to balance performance and cost.

## Granularity of Scale-Out: Brawny vs Wimpy Cores

The model above argues for using "wimpy" cores (slower, cheaper, lower-power) in mid-range commodity servers instead of "brawny" cores in high-end SMPs.

### Arguments for Wimpy Cores

- **Price-performance**: multicore CPUs in mid-range servers typically carry a price-performance premium over lower-end processors, so the same amount of throughput can be bought two to five times cheaper with multiple smaller CPUs.
- **Memory- and I/O-bound applications**: many applications are memory- or I/O-bound, so faster CPUs do not scale well for larger applications. This further enhances the price advantage of smaller CPUs.
- **Power**: slower CPUs tend to be more power efficient. Typically, CPU power decreases by $O(k^2)$ when CPU frequency decreases by a factor of $k$.

### Problems With This Path

- **Amdahl's Law**: as the number of offered parallel threads increases, it becomes difficult to reduce serialization and communication overheads, which limit speedup or scaleup. See [[Data Structures and Parallelism/Parallelism/Amdahl's Law|Amdahl's Law]].
- **Tail latency**: response-time variability increases when handling a parallelized request, so tail latency will increase. Lower-end servers make this worse.
- **Utilization**: small servers have lower utilization.
- **Partitioning overhead**: even embarrassingly parallel algorithms are sometimes less efficient when computation and data are partitioned into smaller pieces. To avoid this, a thread makes only local progress, but it may execute longer, and overhead increases as the pieces get smaller.

### Where This Leaves Us

- Throughput-oriented workloads prefer systems that minimize the cost of computation. This leads to servers with somewhat slower cores but higher throughput, and less memory per core to reduce system cost.
- CPU architecture also plays a role: ARM-based servers are becoming more popular.
- The pros and cons of finer granularity provide broad guidelines for design decisions. Designs maximizing single-core speed, and designs improving per-socket throughput by reducing single-core speed, both have their place in server fleets. But the further apart their speeds are, the less likely any single-socket price-per-throughput advantage will play out in actual deployments, due to the overheads above.

## Scale-Up vs Scale-Out for Accelerators

Accelerator systems are custom-designed and target vertically-integrated solutions for specific workloads, often at lower volumes than traditional servers, so their design trade-offs can differ.

| Accelerator | Direction | Why |
| :--- | :--- | :--- |
| ML accelerators (TPU) | Scale up | TPUs use an ICI-based (inter-chip interconnect) network so that many TPUs act together and perform better |
| Video coding (VCU) | Scale out | Video coding tasks do not communicate with each other. Deployment uses Ethernet-based networking integrated with scale-out task scheduling |

Scale-up offers significant performance and performance-per-cost advantages for smaller-sized workloads. But cost efficiency, the ability to leverage industry hardware, and the large software investment in datacenter (DS) management will always make scale-out important for much larger workloads.

## Related
- [[Datacenter Systems/Warehouse-Scale Computer Architecture/Hardware Building Blocks|Hardware Building Blocks]]
- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]]
- [[Datacenter Systems/Queuing Theory|Queuing Theory]]
- [[Data Structures and Parallelism/Parallelism/Amdahl's Law|Amdahl's Law]]

## Industry Standard Terms
- **Scale up** → vertical scaling
- **Scale out** → horizontal scaling
- **Brawny cores** → high-performance / high-frequency cores
- **Wimpy cores** → low-power throughput cores (e.g., ARM-based servers)
- **SMP server** → shared-memory multiprocessor (NUMA-based large server)
- **ICI** → inter-chip interconnect
