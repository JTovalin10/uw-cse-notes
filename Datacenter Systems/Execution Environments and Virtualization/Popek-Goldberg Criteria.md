# Execution Environments and Virtualization: Popek-Goldberg Criteria

## 1. The Popek-Goldberg Virtualization Theorem

### Formal Definition
Let the instruction set architecture (ISA) of a physical processor be $\mathcal{I}$. The instruction set is partitioned into three disjoint classes:
1. **Privileged Instructions** ($\mathcal{I}_{\text{privileged}}$): Instructions that trap to the supervisor/kernel mode when executed in user mode (e.g., modifying control registers, halting CPU).
2. **Sensitive Instructions** ($\mathcal{I}_{\text{sensitive}}$): Instructions that inspect or manipulate hardware configuration or behavior depending on the CPU execution mode:
   - *Control-sensitive*: Instructions that alter hardware resource allocation without trapping (e.g., disabling interrupts, modifying page table roots).
   - *Behavior-sensitive*: Instructions whose behavior or result differs depending on whether executed in kernel or user mode (e.g., `POPF`, reading current privilege level).
3. **Innocuous Instructions** ($\mathcal{I}_{\text{innocuous}}$): All remaining instructions (e.g., `ADD`, `MOV`, `JMP`).

```
Theorem (Popek & Goldberg, 1974):
A processor architecture is strictly virtualizable under direct execution if and only if:
```

$$\mathcal{I}_{\text{sensitive}} \subseteq \mathcal{I}_{\text{privileged}}$$

```mermaid
flowchart LR
    subgraph NonVirtualizable ["Classic x86 (Non-Virtualizable)"]
        S1["Sensitive Instructions"]
        P1["Privileged Instructions"]
        S1 -.->|17 Sensitive Unprivileged Instructions<br/>(e.g., POPF, PUSHF, SMSW)| S1_leak["Fail to trap! Silently fail or leak host state."]
    end

    subgraph Virtualizable ["Hardware-Assisted Virtualization (Intel VT-x / AMD-V)"]
        P2["Privileged Mode (Root)"]
        S2["Guest Mode (Non-Root)"]
        S2 -->|All sensitive ops trigger VMEXIT| P2
    end
```

### Why Classic x86 Broke Popek-Goldberg
The original x86 architecture contained **17 sensitive instructions that were not privileged**. For example:
- The `POPF` (Pop to Flags) instruction modifies the Interrupt Flag (`IF`) in kernel mode, but when executed in user mode, it simply **silently failed without trapping**.
- A guest OS running in user mode attempting to disable interrupts would believe interrupts were disabled, but the hardware ignored the write, causing subtle kernel race conditions.
- **Hardware-Assisted Resolution**: Intel VT-x and AMD-V introduced two orthogonal operational modes: **VMX Root Operation** (hypervisor) and **VMX Non-Root Operation** (guest OS). In non-root mode, all sensitive instructions explicitly trigger a hardware **VM-Exit** trap to the hypervisor, satisfying the Popek-Goldberg condition.

### Simplified Explanation
For virtualization to work efficiently, whenever a guest operating system tries to do something that affects the real physical hardware (like turning off interrupts or remapping physical memory), the CPU must automatically freeze the guest and alert the hypervisor. If the CPU lets the guest do it silently without an alert, virtualization breaks.

## Related

- [[Datacenter Systems/Execution Environments and Virtualization|Execution Environments and Virtualization]] — Hub for this topic
- [[Datacenter Systems/Execution Environments and Virtualization/Failure Modes|Failure Modes]] — Noisy neighbors, dirty-rate divergence, table exhaustion, and the virtualization tax
- [[Datacenter Systems/Execution Environments and Virtualization/Diurnal Workload Co-Location|Diurnal Workload Co-Location]] — Utilization formulation for co-located workloads
