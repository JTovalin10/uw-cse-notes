# IO Virtualization: Motivation and Overview

## IO Virtualization Motivation & Overview

In a bare-metal execution environment, the operating system kernel communicates directly with physical hardware devices (e.g., Network Interface Cards, NVMe SSDs) via hardware-defined control channels. However, in a multi-tenant datacenter, virtualizing these physical interfaces is notoriously difficult because hardware interfaces are diverse, complex, and highly vendor-specific.

If virtual machines were tightly coupled to specific physical hardware devices:
- A virtual machine could not be easily migrated to another physical server that lacks the exact same hardware model.
- A virtual machine's complete state could not be easily saved, as much of the execution state resides opaquely inside the physical device hardware.
- Multiple virtual machines could not securely and concurrently share a single physical device without risking data corruption or cross-tenant data leaks.

To solve this, hypervisors implement **I/O Interposition**, systematically intercepting and translating virtual device accesses into safe, multiplexed physical device operations.

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Production Equivalent |
| :--- | :--- | :--- |
| **I/O Interposition** | Software Device Emulation | QEMU device models |

## Related

- [[Datacenter Systems/IO Virtualization|IO Virtualization]] — Hub for this topic
- [[Datacenter Systems/IO Virtualization/Physical IO Foundations|Physical IO Foundations]] — Interconnects, PIO/MMIO/DMA, and interrupts
