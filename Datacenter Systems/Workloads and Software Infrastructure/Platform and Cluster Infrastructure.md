# Workloads and Software Infrastructure: Platform and Cluster Infrastructure

## Architecture & Core Mechanics

### Platform-Level Software & Virtualization

Platform software standardizes single-machine operations across cluster nodes:
- **Kernel Tuning**: Homogeneous hardware permits aggressive transport parameter tuning (e.g., TCP socket window sizes, retransmission timeouts, and congestion control parameters like DCTCP).
- **Virtualization & Containerization**:
  - *Hypervisors (e.g., KVM)*: Provide strong security isolation and hardware portability for Infrastructure-as-a-Service (IaaS) cloud workloads at the cost of slight I/O virtualization overhead.
  - *Containers (e.g., Docker/cgroups/namespaces)*: Share the host OS kernel, offering lightweight encapsulation, sub-second startup times, and minimal overhead for internal microservices.
  - *Live VM Migration*: Hypervisors migrate running Virtual Machine instances across physical hosts without dropping network socket state, enabling zero-downtime host maintenance and kernel patching.

### Cluster-Level Infrastructure Software

Cluster-level infrastructure coordinates resources across thousands of nodes:

#### 1. Resource Management & Scheduling
The cluster scheduler (e.g., Google Borg, Kubernetes) acts as the central control plane:
- Maps incoming tasks to physical compute blades based on CPU, RAM, storage, and accelerator constraints.
- Enforces priority tiers and resource quotas, allowing high-priority online services to preempt low-priority offline batch jobs.
- Incorporates power budgets and correlated failure domains (racks, power buses, ToR switches) into placement decisions to maximize fault tolerance.

#### 2. Reusable Cluster Infrastructure
Core building blocks deployed across the cluster:
- **Reliable Distributed Storage**: Filesystems providing high throughput and multi-way replication (e.g., GFS, Colossus).
- **Remote Procedure Call (RPC) Frameworks**: Low-latency, strongly typed inter-service communication protocols (e.g., gRPC, Protocol Buffers).
- **Distributed Synchronization**: Consensus services for leader election, locking, and metadata management (e.g., Chubby, ZooKeeper, Etcd).

## Related

- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Hub for this topic
- [[Datacenter Systems/Workloads and Software Infrastructure/Software Taxonomy and Trade-offs|Software Taxonomy and Trade-offs]] — WSC software taxonomy and datacenter vs desktop software
- [[Datacenter Systems/Workloads and Software Infrastructure/Workload Diversity|Workload Diversity]] — Production application mechanics
