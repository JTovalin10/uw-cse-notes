# Execution Environments and Virtualization: Failure Modes

## Edge Cases, Failure Modes & Mitigations

### 1. Noisy Neighbor Memory Bus & L3 Cache Contention
- **Failure Mode**: Although hypervisors isolate CPU instruction execution and memory address spaces, physical hardware structures—such as the Last-Level L3 CPU Cache (LLC) and the shared DDR5 memory bus—are shared across physical cores. A memory-streaming VM can saturate memory bus bandwidth, causing cache-line evictions and severe 99.9th-percentile tail-latency spikes in co-located latency-sensitive VMs.
- **Mitigation**:
  - Deploy **Hardware Cache Partitioning** (e.g., Intel Resource Director Technology - RDT / Cache Allocation Technology - CAT) to partition portions of the L3 cache exclusively to latency-sensitive VMs.
  - Implement NUMA-aware scheduling: bind VMs strictly to specific Non-Uniform Memory Access (NUMA) sockets and dedicated local memory channels.

### 2. Live Migration Dirty-Rate Divergence (Stalling)
- **Failure Mode**: During the pre-copy phase of live migration, if a write-heavy database VM dirties memory pages faster than the datacenter network fabric can transmit them ($\text{Dirty Rate} > \text{Network Bandwidth}$), the migration never converges. The pre-copy phase loops indefinitely, wasting network bandwidth.
- **Mitigation**:
  - **CPU Throttling**: The hypervisor deliberately injects micro-sleep delays into the guest VM's CPU execution, artificially throttling its write rate until network transfer catches up.
  - **Post-Copy Migration**: Instantly pause the VM, copy the CPU registers to the destination host, immediately resume execution on Host B, and fault-in missing memory pages over the network on demand (demand paging).

### 3. Kernel Resource Table Exhaustion in Process-Based Containers
- **Failure Mode**: When using lightweight containerization (Docker/Kubernetes without MicroVMs), all containers share the host Linux kernel. If one container creates an uncontrolled volume of network sockets, file descriptors, or zombie processes, the host kernel crashes or refuses new connections cluster-wide.
- **Mitigation**:
  - Enforce strict kernel limits using Linux Control Groups (`cgroups` `pids.max`, `memory.max`).
  - Deploy lightweight hardware-isolated MicroVMs (e.g., AWS Firecracker, Kata Containers) to provide full independent guest kernels for untrusted multi-tenant workloads.

### 4. Two-Dimensional Page Table Walking Latency (Virtualization Tax)
- **Failure Mode**: With hardware-nested page tables (EPT/NPT), a Translation Lookaside Buffer (TLB) miss in the guest application requires a 2D page walk. For a 4-level guest page table and a 4-level host page table, resolving a single memory address can require up to:
  $$(4 + 1) \times (4 + 1) - 1 = 24 \text{ physical memory accesses}$$
  This amplifies memory latency by up to 400% on pointer-chasing data structures.
- **Mitigation**: Configure **Huge Pages** (2 MB or 1 GB memory pages instead of 4 KB pages) in both the guest OS and the hypervisor, reducing the page table depth from 4 levels down to 2 or 3 and drastically cutting TLB miss penalties.

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Process Sharing vs VM Sandboxing Walkthrough|Process Sharing vs VM Sandboxing Walkthrough]] — Multi-tenant failure scenario comparison
- [[Datacenter Systems/Execution Environments and Virtualization/Popek-Goldberg Criteria|Popek-Goldberg Criteria]] — Formal virtualization criteria
