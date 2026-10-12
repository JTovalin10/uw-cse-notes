# Execution Environments and Virtualization: Hypervisor Types and VT-x

## Deep Dive

### Type 1 (Bare-Metal) vs. Type 2 (Hosted) Hypervisors

| Architectural Dimension | Type 1 Hypervisor (Bare-Metal) | Type 2 Hypervisor (Hosted) |
| :--- | :--- | :--- |
| **Execution Layer** | Runs directly on bare physical server hardware (Ring 0 / VMX Root). | Runs as an application process inside a standard host OS (e.g., macOS, Windows). |
| **I/O Path** | Implements lean, direct hardware drivers; minimal kernel overhead. | Traverses guest OS $\to$ hypervisor $\to$ host OS kernel $\to$ physical device. |
| **Context Switch Overhead** | Low: Hardware VMCS state swap directly on physical CPU. | High: Double scheduling (host OS schedules hypervisor thread, which schedules vCPU). |
| **Target Environment** | Enterprise cloud datacenters (AWS Nitro, GCP KVM, VMware ESXi). | Developer desktop testing (VirtualBox, VMware Workstation, QEMU). |

### Hardware-Assisted Virtualization Mechanics (Intel VT-x)
Modern datacenter virtualization relies on the **Virtual Machine Control Structure (VMCS)**, a 4 KB memory region maintained by the CPU for every virtual processor:
- **`VMPTRLD`**: Loads the physical memory pointer of the active VMCS into the processor core.
- **`VMENTRY`**: The hypervisor executes `VMENTRY`, causing the hardware CPU to transition from VMX Root to VMX Non-Root mode, loading guest registers (%rip, %rsp, CR3 page table pointer) and executing guest instructions.
- **`VMEXIT`**: When the guest OS attempts a sensitive operation (e.g., executing `CPUID`, writing to control registers, or handling a physical hardware interrupt), the hardware CPU immediately halts the guest, writes guest state into the VMCS, transitions back to VMX Root mode, and jumps to the hypervisor's exit handler.

## Industry Standard Terms

| Course Term | Industry / Production Term |
| :--- | :--- |
| **Hypervisor / VMM** | Virtual Machine Monitor / Bare-Metal Hypervisor (Type 1) |
| **Host OS** | Hypervisor Kernel / Dom0 (Xen) / Parent Partition (Hyper-V) |

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Diurnal Workload Co-Location|Diurnal Workload Co-Location]] — Utilization formulation for co-located workloads
