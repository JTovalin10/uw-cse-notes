# Execution Environments and Virtualization: Multi-Tier Virtual Memory Hierarchy

## Multi-Tier Virtual Memory Hierarchy
In a non-virtualized system, the operating system manages a two-level memory mapping: Virtual Address to Physical Address. 

In a virtualized datacenter system, memory management expands into a **three-tier memory hierarchy**:

```mermaid
flowchart LR
    GVA["1. Guest Virtual Address (GVA)<br/>(App pointers inside VM)"] 
    -->|Guest Page Table| GPA["2. Guest Physical Address (GPA)<br/>(Contiguous memory illusion)"]
    GPA -->|Extended Page Table (EPT)| HPA["3. Host Physical Address (HPA)<br/>(Actual physical DRAM chips)"]
```

1. **Guest Virtual Address (GVA)**:
   - The virtual address space used by individual guest user applications executing inside the VM.
2. **Guest Physical Address (GPA)**:
   - The physical address space presented to the Guest OS. The Guest OS believes GPA maps directly to physical RAM chips starting at address `0x00000000`.
3. **Host Physical Address (HPA)**:
   - The actual physical memory addresses in the host server's physical DRAM modules, managed strictly by the hypervisor.

### Hardware-Assisted Two-Dimensional Page Walks (EPT / NPT)
Modern CPUs provide hardware-assisted paging (Intel **Extended Page Tables - EPT**, AMD **Nested Page Tables - NPT**). The hardware Memory Management Unit (MMU) automatically walks both page tables:
- Guest Page Table: Translates $\text{GVA} \longrightarrow \text{GPA}$.
- Hypervisor Extended Page Table: Translates $\text{GPA} \longrightarrow \text{HPA}$.
- This eliminates the need for slow software shadow page tables, allowing guest memory access to run at near-native physical hardware speed.

## Industry Standard Terms

| Course Term | Industry / Production Term |
| :--- | :--- |
| **GVA / GPA / HPA** | Guest Virtual / Guest Physical / Host Physical Address (Three-Tier Memory) |
| **EPT / NPT** | Extended Page Tables (Intel) / Nested Page Tables (AMD) / Second Level Address Translation (SLAT) |

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Virtualization Abstraction and Hypervisor|Virtualization Abstraction and Hypervisor]] — The virtualization abstraction and VM architecture
- [[Datacenter Systems/Execution Environments and Virtualization/Operational Capabilities of Virtual Machines|Operational Capabilities of Virtual Machines]] — Snapshots, migration, and management advantages
