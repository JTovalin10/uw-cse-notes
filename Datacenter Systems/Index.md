# Datacenter Systems: Index

Engineering principles, architectures, and performance optimizations for warehouse-scale datacenter computing.

---

## Topics

### Foundations & Course Overview
- [[Datacenter Systems/Course Introduction and Overview|Course Introduction and Overview]] — Warehouse-scale computing fundamentals, evolution of software delivery, the Cloud Operator Pyramid of Concerns, and datacenter hardware trade-offs.
- [[Datacenter Systems/Warehouse-Scale Computer Architecture|Warehouse-Scale Computer Architecture]] — Hardware building blocks (1U/blade servers, DAS/NAS storage, networking fabric), bisection bandwidth trade-offs, power/cooling infrastructure, and PUE formal analysis.
- [[Datacenter Systems/Workloads and Software Infrastructure|Workloads and Software Infrastructure]] — Cluster operating systems, resource schedulers (Borg/Kubernetes), application frameworks, web search & video serving pipelines, tail-latency mitigation, and cloud security.

### Lab Foundations & Infrastructure
- [[Datacenter Systems/Quiz Section 1 — Microservices, RPC, and Cloud Infrastructure|Quiz Section 1 — Microservices, RPC, and Cloud Infrastructure]] — Microservice vs. monolith trade-offs, gRPC and Protocol Buffer serialization, Docker and Kubernetes container orchestration, Go concurrency, and Google Cloud Platform (GCP) lab workflows.

### Virtualization & Execution Environments
- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Datacenter workload taxonomy, limits of OS process isolation, Popek-Goldberg virtualization criteria, hypervisor architecture, three-tier memory hierarchies, and live VM migration.
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem|The Popek-Goldberg Virtualization Theorem]] — Formal ISA requirements for direct execution virtualization, trap-and-emulate mechanics, x86/MIPS/ARM architectural violations, hardware-assisted VT-x/AMD-V extensions, and virtual I/O emulation/virtio architecture.
- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — CPU virtualization, hypervisor nested memory paging (Shadow PTs vs Intel EPT/NPT), KVM instruction emulation, 1GB/2MB superpage optimizations, and dynamic memory ballooning.
- [[Datacenter Systems/IO Virtualization|I/O Virtualization]] — Virtual-to-physical I/O interposition, VM encapsulation and live migration, physical I/O interfaces (PIO, MMIO, DMA, LAPIC interrupts), and high-throughput virtio DMA ring buffers.

---

## Related Courses
- [[Distributed Systems/Index|CSE452 — Distributed Systems]] — Distributed consensus, replication, and RPC semantics
- [[CSE451 Index|CSE451 — Operating Systems]] — Kernel abstractions, processes, and virtual memory
- [[CSE461 Index|CSE461 — Computer Networks]] — Packet switching, TCP/IP, congestion control, and routing
- [[Concurrency, Parallelism, and Rust/Index|Concurrency, Parallelism, and Rust]] — Concurrency models, async runtimes, and thread scheduling
