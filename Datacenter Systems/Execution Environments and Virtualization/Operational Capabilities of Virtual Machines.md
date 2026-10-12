# Execution Environments and Virtualization: Operational Capabilities of Virtual Machines

## Operational Capabilities & Advantages of Virtual Machines

### 1. Server Consolidation & High Utilization
Small applications requiring only 5% of a server are packaged into compact VMs. The hypervisor bin-packs dozens of distinct VMs onto a single physical server, driving aggregate hardware utilization up to 70–80%.

### 2. Resource Disaggregation & I/O Indirection
Virtual machines do not bind directly to local physical hard drives. Instead, the hypervisor presents a **Virtual Block Device** to the guest OS:
- The guest OS reads and writes disk sectors to its virtual disk.
- The hypervisor intercepts these I/O operations and routes them over high-speed datacenter storage fabrics (e.g., NVMe-over-Fabrics, iSCSI) to remote, replicated storage clusters.
- **Decoupled Storage**: Storage is disaggregated from compute. If a physical compute server crashes, the VM's stateful disk image remains completely intact and accessible across the datacenter network.

### 3. Transparent Checkpointing, Restart & Live Migration
Because a virtual machine's complete state—its CPU registers, memory pages, virtual device states, and network sockets—is fully encapsulated in software by the hypervisor:
- **Transparent Checkpointing**: The hypervisor can freeze the VM, snapshot its entire RAM and register state to storage, and restart it later or clone it for debugging.
- **Live Migration**: The hypervisor can transfer an actively running VM from one physical server to another **without interrupting the running application or dropping active network connections**.

### 4. Alignment with the Cloud Operator Pyramid
Virtualization introduces architectural overhead (the "virtualization tax"):
- Single-server performance is slightly lower due to hypervisor indirection, VM-exit traps, and two-dimensional page walks.
- However, under the **Cloud Operator Pyramid of Concerns**, **Availability** and **Manageability** strictly supersede raw single-server performance. The ability to live-migrate workloads to apply kernel patches, replace failing hardware, and isolate multi-tenant crashes justifies the minor performance penalty.

## Industry Standard Terms

| Course Term | Industry / Production Term |
| :--- | :--- |
| **Live Migration** | VM Pre-Copy Live Migration / vMotion |
| **Resource Disaggregation** | Composable Infrastructure / NVMe-over-Fabrics (NVMe-oF) Storage |

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Multi-Tier Virtual Memory Hierarchy|Multi-Tier Virtual Memory Hierarchy]] — GVA, GPA, and HPA tiers
- [[Datacenter Systems/Execution Environments and Virtualization/Live VM Migration Walkthrough|Live VM Migration Walkthrough]] — Migration during a host kernel upgrade
