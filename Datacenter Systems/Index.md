# Datacenter Systems: Index

Engineering principles, architectures, and performance optimizations for warehouse-scale datacenter computing.

---

## Topics

### Foundations & Course Overview
- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Warehouse-scale computing fundamentals, evolution of software delivery, the Cloud Operator Pyramid of Concerns, and datacenter hardware trade-offs.
  - [[Datacenter Systems/Course Introduction and Overview/Datacenter Challenges and Software Delivery|Datacenter Challenges and Software Delivery]] — Motivation, engineering challenges, and the evolution of software delivery
  - [[Datacenter Systems/Course Introduction and Overview/Cloud Service Abstraction Hierarchy|Cloud Service Abstraction Hierarchy]] — IaaS, PaaS, and SaaS layering
  - [[Datacenter Systems/Course Introduction and Overview/Cloud Operator Pyramid of Concerns|Cloud Operator Pyramid of Concerns]] — Google's pyramid of operator concerns
  - [[Datacenter Systems/Course Introduction and Overview/Primary Datacenter Engineering Concerns|Primary Datacenter Engineering Concerns]] — Core engineering concerns of datacenter design
  - [[Datacenter Systems/Course Introduction and Overview/Class Roadmap and Prerequisites|Class Roadmap and Prerequisites]] — Class topics and expected background
  - [[Datacenter Systems/Course Introduction and Overview/Monolithic Appliance vs Cloud SaaS Trace|Monolithic Appliance vs Cloud SaaS Trace]] — End-to-end comparison trace
  - [[Datacenter Systems/Course Introduction and Overview/Failure Modes|Failure Modes]] — Stragglers, resource stranding, and incast
  - [[Datacenter Systems/Course Introduction and Overview/Availability, Tail Latency, and PUE Formulas|Availability, Tail Latency, and PUE Formulas]] — Formal availability, fan-out tail latency, and PUE
- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hardware building blocks (1U/blade servers, DAS/NAS storage, networking fabric), bisection bandwidth trade-offs, power/cooling infrastructure, and PUE formal analysis.
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/WSCs vs Traditional Datacenters|WSCs vs Traditional Datacenters]] — Differences and cost efficiency at scale
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/The Datacenter as a Computer|The Datacenter as a Computer]] — The WSC abstraction and topology
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/Hardware Building Blocks|Hardware Building Blocks]] — Servers, storage, and networking fabric
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/Scatter-Gather Query Trace|Scatter-Gather Query Trace]] — Processing a query across a WSC
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/Failure Modes|Failure Modes]] — Faults, bisection bandwidth, and thermal limits
  - [[Datacenter Systems/Warehouse-Scale Computer Architecture/Power, PUE, and AFR Formulas|Power, PUE, and AFR Formulas]] — Power dynamics, PUE, and failure rates
- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Cluster operating systems, resource schedulers (Borg/Kubernetes), application frameworks, web search & video serving pipelines, tail-latency mitigation, and cloud security.
  - [[Datacenter Systems/Workloads and Software Infrastructure/Software Taxonomy and Trade-offs|Software Taxonomy and Trade-offs]] — WSC software taxonomy and datacenter vs desktop software
  - [[Datacenter Systems/Workloads and Software Infrastructure/Platform and Cluster Infrastructure|Platform and Cluster Infrastructure]] — Platform-level and cluster-level software
  - [[Datacenter Systems/Workloads and Software Infrastructure/Workload Diversity|Workload Diversity]] — Production application mechanics
  - [[Datacenter Systems/Workloads and Software Infrastructure/Cloud Stack and Performance Toolbox|Cloud Stack and Performance Toolbox]] — Multi-tenancy and the performance and availability toolbox
  - [[Datacenter Systems/Workloads and Software Infrastructure/Live VM Migration Trace|Live VM Migration Trace]] — Migration during host maintenance
  - [[Datacenter Systems/Workloads and Software Infrastructure/Failure Modes|Failure Modes]] — Tail latency, noisy neighbors, and alert fatigue
  - [[Datacenter Systems/Workloads and Software Infrastructure/Scatter-Gather Latency and Hedged Requests|Scatter-Gather Latency and Hedged Requests]] — Fan-out latency formulation and hedging

- [[Datacenter Systems/Computing Building Blocks|Computing Building Blocks]] — Scale-up vs scale-out cost and communication model, brawny vs wimpy cores, and accelerator scaling (TPU vs video coding).
- [[Datacenter Systems/Server Memory Systems|Server Memory Systems]] — Multisocket NUMA servers, QPI and CXL, the cache and DRAM latency hierarchy from registers to cross-rack memory, application memory behavior, and the limits of wimpy servers.
- [[Datacenter Systems/Memory Consistency and Cache Coherence|Memory Consistency and Cache Coherence]] — Consistency as specification vs coherence as implementation, sequential consistency, write buffers, total store order, FENCEs and atomics, and single-writer/multiple-reader coherence.
- [[Datacenter Systems/Right-Sizing Datacenters|Right-Sizing Datacenters]] — Workload and node characteristics, and why cheaper, less powerful nodes can win for I/O and network bound tasks.

### Lab Foundations & Infrastructure
- [[Microservices, RPC, and Cloud Infrastructure|Microservices, RPC, and Cloud Infrastructure]] — Microservice vs. monolith trade-offs, gRPC and Protocol Buffer serialization, Docker and Kubernetes container orchestration, Go concurrency, and Google Cloud Platform (GCP) lab workflows.
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Monolith vs Microservices|Monolith vs Microservices]] — Architectural comparison
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/RPC and Pass-by-Value Semantics|RPC and Pass-by-Value Semantics]] — Remote procedure call semantics
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/gRPC and Protocol Buffers|gRPC and Protocol Buffers]] — gRPC, protobuf, and wire encoding
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Docker and Kubernetes|Docker and Kubernetes]] — Containers and orchestration
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Go and GCP Lab Infrastructure|Go and GCP Lab Infrastructure]] — Go systems programming and GCP lab setup
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/gRPC Call Trace|gRPC Call Trace]] — A full gRPC call from client to server
  - [[Datacenter Systems/Microservices, RPC, and Cloud Infrastructure/Failure Modes|Failure Modes]] — Schema drift, cascading timeouts, OOMKilled, and credit exhaustion

### Virtualization & Execution Environments
- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Datacenter workload taxonomy, limits of OS process isolation, Popek-Goldberg virtualization criteria, hypervisor architecture, three-tier memory hierarchies, and live VM migration.
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
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem|The Popek-Goldberg Virtualization Theorem]] — Formal ISA requirements for direct execution virtualization, trap-and-emulate mechanics, x86/MIPS/ARM architectural violations, hardware-assisted VT-x/AMD-V extensions, and virtual I/O emulation/virtio architecture.
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Requirements and System Model|Requirements and System Model]] — Core requirements, assumptions, and instruction classification
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Trap-and-Emulate Mechanism and Traces|Trap-and-Emulate Mechanism and Traces]] — How traps are emulated, with an interrupt trace
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Architectural Violations and Mitigations|Architectural Violations and Mitigations]] — Classic ISAs that break the theorem and their fixes
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Virtual IO Emulation and Virtio|Virtual IO Emulation and Virtio]] — Full I/O emulation versus paravirtualized virtio
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/Formal Definition|Formal Definition]] — Formal statement of the theorem
  - [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem/VT-x and EPT Extensions|VT-x and EPT Extensions]] — Hardware-assisted extensions
- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — CPU virtualization, hypervisor nested memory paging (Shadow PTs vs Intel EPT/NPT), KVM instruction emulation, 1GB/2MB superpage optimizations, paravirtualized virtio I/O, and dynamic memory ballooning.
  - [[Datacenter Systems/Virtual Machines/Motivation and Trade-offs|Motivation and Trade-offs]] — The three virtues, core challenges, and benefits/costs of VMs
  - [[Datacenter Systems/Virtual Machines/CPU Virtualization Mechanisms|CPU Virtualization Mechanisms]] — Trap-and-emulate, binary translation, paravirtualization, VT-x/AMD-V, and the Popek-Goldberg condition
  - [[Datacenter Systems/Virtual Machines/Memory Virtualization Foundations|Memory Virtualization Foundations]] — Paging recap, the GVA/GPA/HPA hierarchy, and the composite translation
  - [[Datacenter Systems/Virtual Machines/Software Memory Virtualization|Software Memory Virtualization]] — Real guest page tables, shadow page tables, and paravirtualized memory management
  - [[Datacenter Systems/Virtual Machines/Nested Paging with EPT and NPT|Nested Paging with EPT and NPT]] — Hardware two-dimensional page walks, superpages, VPID, and page modification logging
  - [[Datacenter Systems/Virtual Machines/KVM Memory Virtualization|KVM Memory Virtualization]] — GPA to HVA mapping and software instruction emulation in KVM
  - [[Datacenter Systems/Virtual Machines/Memory Ballooning|Memory Ballooning]] — Overcommitment, double paging, and the balloon driver
  - [[Datacenter Systems/Virtual Machines/Edge Cases and Failure Modes|Edge Cases and Failure Modes]] — Failure modes across CPU, memory, and consolidation mechanisms
- [[Datacenter Systems/Containers|Containers]] — Operating system-level virtualization, Linux namespaces (PID, mount, net), control groups (cgroups) resource limits, shared kernel attack surface and negative dcache thrashing, and comparisons with Type-1/Type-2 VMs.
  - [[Datacenter Systems/Containers/OS-Level Virtualization|OS-Level Virtualization]] — Why containers exist, virtualizing the syscall interface, and language-level virtualization
  - [[Datacenter Systems/Containers/Namespace Isolation|Namespace Isolation]] — Per-container file systems, process IDs, network identity, and resource views
  - [[Datacenter Systems/Containers/Cgroups|Cgroups]] — Resource weights and limits, and why shared kernel data structures remain a weakness
  - [[Datacenter Systems/Containers/Containers vs Virtual Machines|Containers vs Virtual Machines]] — Performance, security, and cost trade-offs
  - [[Datacenter Systems/Containers/Serverless Functions and Enclaves|Serverless Functions and Enclaves]] — The third and fourth execution models
  - [[Datacenter Systems/Containers/Network Virtualization|Network Virtualization]] — Virtual IP and MAC addresses and packet encapsulation
- [[Datacenter Systems/IO Virtualization|IO Virtualization]] — Server hardware interconnects (PCIe, QPI, CXL), virtual-to-physical I/O interposition, VM encapsulation and live migration, PIO/MMIO/DMA, LAPIC interrupts, high-throughput virtio DMA ring buffers, SR-IOV hardware slicing, and IOMMU address translation.
  - [[Datacenter Systems/IO Virtualization/Motivation and Overview|Motivation and Overview]] — Why device state must be decoupled from physical hardware
  - [[Datacenter Systems/IO Virtualization/Physical IO Foundations|Physical IO Foundations]] — Interconnects, PIO/MMIO/DMA, and interrupts
  - [[Datacenter Systems/IO Virtualization/DMA Ring Buffers|DMA Ring Buffers]] — Driver and device coordination through circular descriptor queues
  - [[Datacenter Systems/IO Virtualization/IO Interposition and VirtIO|IO Interposition and VirtIO]] — Trap-and-emulate I/O, VirtIO, a PIO trace, and failure modes
  - [[Datacenter Systems/IO Virtualization/SR-IOV and IOMMU|SR-IOV and IOMMU]] — Hypervisor I/O bypass, hardware slicing, and DMA address translation

### Networking & Performance Modeling
- [[Datacenter Systems/Open vSwitch Network Virtualization|Open vSwitch Network Virtualization]] — Open vSwitch exact match cache, on-premise porting requirements, hardware-virtualized NICs (Nitro, Catapult, Snap), and VM migration forwarding.
- [[Datacenter Systems/Queuing Theory|Queuing Theory]] — Stable queuing model, response time and utilization, Little's Law, and best/worst/average arrival patterns.
- [[Datacenter Systems/Queueing and CPU Scheduling|Queueing and CPU Scheduling]] — Response time across multiple resources, shared vs per-server queues, load balancers, work stealing, scheduling policies and priorities, and multi-level scheduling.
- [[Datacenter Systems/Shenango|Shenango]] — Microsecond-granularity core reallocation for CPU efficiency with latency-sensitive workloads, and compute congestion detection.

---

## Related Courses
- [[Distributed Systems/Index|CSE452 — Distributed Systems]] — Distributed consensus, replication, and RPC semantics
- [[CSE451 Index|CSE451 — Operating Systems]] — Kernel abstractions, processes, and virtual memory
- [[CSE461 Index|CSE461 — Computer Networks]] — Packet switching, TCP/IP, congestion control, and routing
- [[Concurrency, Parallelism, and Rust/Index|Concurrency, Parallelism, and Rust]] — Concurrency models, async runtimes, and thread scheduling
