# IO Virtualization: SR-IOV and IOMMU

## Two-Dimensional IOMMU Address Translation Invariant

Let $GPA$ be a Guest Physical Address and $HPA$ be the actual Host Physical Address.
Let $T_{\text{IOMMU}}$ represent the hardware IOMMU page table mapping function for a given PCIe Device Function $VF_k$:
$$T_{\text{IOMMU}}(VF_k, GPA) \to HPA$$

For any DMA memory transaction $Op(VF_k, GPA, \text{Length})$ issued by virtual device $VF_k$:

### Formal Definition
$$\forall GPA \in \text{Domain}(Op), \quad T_{\text{IOMMU}}(VF_k, GPA) \in \text{MemoryRegion}(\text{VM}_k)$$
$$\text{MemoryController}(GPA) = \begin{cases} 
HPA = T_{\text{IOMMU}}(VF_k, GPA) & \text{if } GPA \in \text{ValidPages}(\text{VM}_k) \\
\text{FAULT} & \text{otherwise}
\end{cases}$$

### Simplified Explanation
The IOMMU acts as a hardware firewall and address translator for PCIe devices: it ensures a virtual machine's network card can only access the exact host DRAM pages assigned to that specific virtual machine.

## Deep Dive

### Hypervisor I/O Bypass, SR-IOV & IOMMU
For high-performance datacenter workloads, paravirtualized VirtIO still introduces software latency overhead due to hypervisor context switches. Datacenter systems implement **Hypervisor I/O Bypass** to deliver bare-metal I/O performance directly to Guest VMs.

![[Screenshots/Hypervisor IO Bypass.png]]

**Single Root I/O Virtualization (SR-IOV)** allows a single physical PCIe device to partition itself into multiple distinct "Virtual Functions" (VFs).
- The hypervisor securely maps a VF directly into the guest VM's memory space using the hardware IOMMU for DMA isolation.
- The Guest VM loads native hardware drivers that interact directly with its assigned VF, achieving near-zero `vmexit` overhead and bare-metal throughput.
- **Trade-off**: While SR-IOV provides bare-metal performance, it shatters device hardware independence, severely restricting transparent live migration.

**Device IOMMU (Input-Output Memory Management Unit)**
Directly granting Guest VMs raw PCIe DMA access introduces a critical security hazard: physical PCIe DMA engines bypass the CPU MMU. The **IOMMU** (e.g., **Intel VT-d**, **AMD-Vi**) resolves this by providing hardware address translation and protection for PCIe DMA requests.

![[Screenshots/Device IOMMU.png]]

- **Address Translation Hierarchy**: The IOMMU translates Device Virtual Addresses or Guest Physical Addresses directly to **Host Physical Addresses (HPA)** using I/O page tables managed by the hypervisor.
- **Isolation & Fault Protection**: If a Guest VM attempts a DMA transfer outside its granted physical memory pages, the IOMMU blocks the transaction, raises a hardware fault interrupt, and isolates the guest.
- **Posted Interrupts (Exitless Interrupt Delivery)**: Advanced virtualization hardware (such as Intel APIC-v and posted-interrupt processing) routes physical PCIe device interrupts directly into Guest vCPUs without triggering VM-Exits to the hypervisor, removing hardware trap latency and drastically increasing I/O throughput.

## Industry Standard Terms

| Course Term | Industry / Standard Term | Real-World Production Equivalent |
| :--- | :--- | :--- |
| **Exitless Interrupts** | Posted Interrupts / APIC-v | Intel VT-d Posted Interrupts, AMD AVIC |
| **Direct Hardware Assignment** | SR-IOV / PCIe Passthrough | Mellanox ConnectX SR-IOV VFs |
| **Device IOMMU** | I/O Memory Management Unit | Intel VT-d, AMD-Vi, ARM SMMU |

## Related

- [[Datacenter Systems/IO Virtualization|IO Virtualization]] — Hub for this topic
- [[Datacenter Systems/IO Virtualization/IO Interposition and VirtIO|IO Interposition and VirtIO]] — Trap-and-emulate I/O, VirtIO, a PIO trace, and failure modes
