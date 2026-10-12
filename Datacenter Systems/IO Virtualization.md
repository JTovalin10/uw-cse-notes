# Datacenter Systems: IO Virtualization

I/O Virtualization decouples virtual machine input/output operations from underlying physical hardware interfaces through software interposition, enabling hypervisors to transparently manage, snapshot, and migrate live virtual machines across heterogeneous servers. It abstracts physical network interfaces, disk controllers, and hardware accelerators across multiple isolated execution environments, resolving the performance, latency, and security bottlenecks imposed by software hypervisors in high-throughput datacenter workloads.

## Topics

- [[Datacenter Systems/IO Virtualization/Motivation and Overview|Motivation and Overview]] — Why device state must be decoupled from physical hardware
- [[Datacenter Systems/IO Virtualization/Physical IO Foundations|Physical IO Foundations]] — Interconnects, PIO/MMIO/DMA, and interrupts
- [[Datacenter Systems/IO Virtualization/DMA Ring Buffers|DMA Ring Buffers]] — Driver and device coordination through circular descriptor queues
- [[Datacenter Systems/IO Virtualization/IO Interposition and VirtIO|IO Interposition and VirtIO]] — Trap-and-emulate I/O, VirtIO, a PIO trace, and failure modes
- [[Datacenter Systems/IO Virtualization/SR-IOV and IOMMU|SR-IOV and IOMMU]] — Hypervisor I/O bypass, hardware slicing, and DMA address translation

## Related

- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — CPU virtualization and hypervisor architectural models
- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Broad virtualization taxonomy and constraints
- [[Datacenter Systems/The Popek-Goldberg Virtualization Theorem|The Popek-Goldberg Virtualization Theorem]] — Formal CPU hardware trap-and-emulate requirements and virtual I/O emulation mechanics
- [[Operating Systems/Persistence/Storage/IO System Hardware Environment|I/O System Hardware Environment]] — Fundamentals of hardware storage buses and disk controllers
- [[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]] — Operating system mechanisms for hardware asynchronous event handling
