# IO Virtualization: Physical IO Foundations

## Physical I/O Foundations & Hardware Interfaces

Before I/O can be virtualized, it is necessary to understand how the CPU discovers and drives physical I/O natively. Physical distance from the CPU die dictates access latency and available bandwidth:
- **On-Chip & Coherent Interconnects (Low Latency)**: Inter-socket communication uses high-speed coherent interconnects like **QuickPath Interconnect (QPI)** or **Ultra Path Interconnect (UPI)**.
- **Peripheral & Storage Interconnects (High Bandwidth)**: I/O devices operate over **PCI Express (PCIe)** buses optimized for bulk data throughput.
- **Compute Express Link (CXL)**: A cache-coherent protocol running over physical PCIe wires for low-latency memory sharing.

![[Screenshots/Server Hardware.png]]

CPUs employ specific mechanisms to interact with I/O devices:
1. **Port-Mapped I/O (PIO)**: Dedicated 16-bit physical memory address space using `in`/`out` instructions.
2. **Memory-Mapped I/O (MMIO)**: Control registers and memory buffers mapped directly into the physical memory address space.
3. **Direct Memory Access (DMA)**: The I/O device asynchronously accesses system RAM directly to read or write data, notifying the CPU only when the bulk transfer completes.

When asynchronous operations finish, the device triggers a **hardware interrupt**, managed by the **Local Advanced Programmable Interrupt Controller (LAPIC)** on each CPU core.

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Production Equivalent |
| :--- | :--- | :--- |
| **QPI / UPI** | Ultra Path Interconnect | Intel UPI, AMD Infinity Fabric (IF) |
| **CXL** | Compute Express Link | CXL 2.0 / 3.0 memory expansion modules |
| **Hardware Interrupt Controller** | LAPIC / IOAPIC | CPU APIC cores |

## Related

- [[Datacenter Systems/IO Virtualization|IO Virtualization]] — Hub for this topic
- [[Datacenter Systems/IO Virtualization/Motivation and Overview|Motivation and Overview]] — Why device state must be decoupled from physical hardware
- [[Datacenter Systems/IO Virtualization/DMA Ring Buffers|DMA Ring Buffers]] — Driver and device coordination through circular descriptor queues
