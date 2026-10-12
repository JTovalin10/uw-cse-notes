# Datacenter Systems: Execution Environments and Virtualization

Virtualization provides isolated, efficient software duplicates of physical computing hardware, enabling cloud datacenters to multiplex diverse multi-tenant workloads onto shared physical servers to maximize resource utilization while preserving strict availability, security, and performance boundaries.

## Topics

- [[Datacenter Systems/Execution Environments and Virtualization/Application Taxonomy and Consolidation|Application Taxonomy and Consolidation]] — Application types, bare-metal limits, and the consolidation vs isolation tension
- [[Datacenter Systems/Execution Environments and Virtualization/Why OS Process Isolation Fails|Why OS Process Isolation Fails]] — Limits of process isolation in multi-tenant clouds
- [[Datacenter Systems/Execution Environments and Virtualization/Virtualization Abstraction and Hypervisor|Virtualization Abstraction and Hypervisor]] — The virtualization abstraction and VM architecture
- [[Datacenter Systems/Execution Environments and Virtualization/Multi-Tier Virtual Memory Hierarchy|Multi-Tier Virtual Memory Hierarchy]] — GVA, GPA, and HPA tiers
- [[Datacenter Systems/Execution Environments and Virtualization/Operational Capabilities of Virtual Machines|Operational Capabilities of Virtual Machines]] — Snapshots, migration, and management advantages
- [[Datacenter Systems/Execution Environments and Virtualization/Live VM Migration Walkthrough|Live VM Migration Walkthrough]] — Migration during a host kernel upgrade
- [[Datacenter Systems/Execution Environments and Virtualization/Process Sharing vs VM Sandboxing Walkthrough|Process Sharing vs VM Sandboxing Walkthrough]] — Multi-tenant failure scenario comparison
- [[Datacenter Systems/Execution Environments and Virtualization/Failure Modes|Failure Modes]] — Noisy neighbors, dirty-rate divergence, table exhaustion, and the virtualization tax
- [[Datacenter Systems/Execution Environments and Virtualization/Popek-Goldberg Criteria|Popek-Goldberg Criteria]] — Formal virtualization criteria
- [[Datacenter Systems/Execution Environments and Virtualization/Diurnal Workload Co-Location|Diurnal Workload Co-Location]] — Utilization formulation for co-located workloads
- [[Datacenter Systems/Execution Environments and Virtualization/Hypervisor Types and VT-x|Hypervisor Types and VT-x]] — Type 1 vs Type 2 hypervisors and hardware assistance

## Related

- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Warehouse-scale computing foundations and the Cloud Operator Pyramid of Concerns
- [[Microservices, RPC, and Cloud Infrastructure|Microservices, RPC, and Cloud Infrastructure]] — Microservice architectures, Docker containerization, and gRPC
- [[Operating Systems/Virtualization/Containers and Virt|Containers and Virtualization]] — Operating system namespaces and cgroups vs. hypervisor hardware virtualization
- [[Operating Systems/Virtualization/Virtual Machine/Virtual Machine|Virtual Machines]] — In-depth operating system virtualization mechanisms and shadow page tables
- [[Operating Systems/Memory/Virtual Memory|Virtual Memory]] — Paging, Translation Lookaside Buffers (TLBs), and address translation
