# CSE451: Virtual Machines

**Virtual Machines (VMs)** provide an isolated environment that mimics a physical computer, allowing multiple operating systems to run on a single piece of hardware.

## Why Use Virtual Machines?

1.  **Isolation & Security**:
    *   **OS Development**: Isolate system bugs and protect hardware while developing new operating systems.
    *   **Sandboxing**: Safely run and test potentially dangerous software without affecting the host system.
2.  **Legacy Support**: Simulate legacy environments to run older applications on modern hardware.
3.  **Data Centers and Cloud Computing**:
    *   Cloud providers manage massive data centers with vast amounts of hardware.
    *   By running many virtual machines on physical hardware, providers can efficiently distribute services to clients.

## What is a Virtual Machine?

A complete compute environment with its own isolated processing capabilities, memory, and communication channels.

![[Virtual Machine.png]]

## Terminology

*   **Host OS**: The primary operating system running directly on the physical hardware.
*   **Guest OS**: The operating system running within the Virtual Machine using the virtualized hardware.
*   **[[Hypervisor (VMM)|Hypervisor (Virtual Machine Monitor - VMM)]]**: Software that creates and runs Virtual Machines by virtualizing hardware resources.
    *   **[[Type 1 (Bare Metal)|Type-1 (Bare Metal)]]**: Runs directly on the system's hardware (e.g., Microsoft Hyper-V, VMware ESXi, Xen).
    *   **[[Type 2 (Hosted)|Type-2 (Hosted)]]**: Runs as an application on a host OS (e.g., VirtualBox, VMware Workstation, KVM/QEMU).

![[Hypervisors.png]]

## System-Level Virtual Machines

*   Possess their own virtualized hardware.
*   Can run any operating system of choice.
*   The **Guest OS** runs in a less-privileged "user mode," while the hypervisor manages privileged operations. This mirrors the [[User Mode|User Mode]] vs [[Kernel Mode|Kernel Mode]] distinction a normal OS enforces between applications and the kernel, except here the Hypervisor plays the role of the more-privileged layer and the entire Guest OS — kernel included — is pushed down into the less-privileged role.

![[System-Level Virtual Machines.png]]

### CPU Virtualization and Privileged Instructions

For a Guest OS to execute privileged instructions, the hypervisor must intervene. Common solutions include:

1.  **Binary Translation**: The hypervisor scans guest code and replaces sensitive instructions with calls to the hypervisor (high overhead), since every potentially privileged instruction must be found and rewritten before it ever executes.
2.  **Hardware-Assisted Virtualization**: Modern processors (Intel VT-x, AMD-V) introduce a "non-root" mode for guests — this corresponds to **[[Containers and Virt#Hardware-Assisted Virtualization|Guest Mode]]**, with the Hypervisor itself running in **[[Containers and Virt#Hardware-Assisted Virtualization|Root Mode]]** — allowing some instructions to run at native speed while trapping others.
3.  **Trap & Emulate**: The Guest OS attempts a privileged instruction, causing a hardware trap to the hypervisor, which then emulates the instruction. This may not work for all instructions on older architectures, since some privileged instructions on x86 historically failed silently instead of trapping, making them impossible to intercept this way.
4.  **Paravirtualization**: The Guest OS is "enlightened" — it is modified to know it is virtualized and uses **Hypercalls** to communicate directly with the hypervisor, replacing the sensitive instruction with an explicit, cooperative call instead of relying on the hardware to trap on it.

### Guest App System Call Flow (Type-2 Example)

1.  The guest application makes a system call; the hardware detects this and traps to the **Hypervisor**.
2.  The Hypervisor analyzes the instruction, updates its virtual hardware state, and (in Type-2) might trap to the **Host OS**, since a Type-2 Hypervisor is itself just an application running on top of the Host OS and cannot directly perform privileged operations on the real hardware.
3.  The **Host OS** emulates the system call and returns control to the Hypervisor.
4.  The Hypervisor increments the guest app's `%RIP` (Instruction Pointer), restores state, and calls **VM-Entry** to return to the guest. Incrementing `%RIP` past the trapping instruction is necessary so that the Guest resumes execution after the instruction that caused the trap, rather than re-triggering the same trap in an infinite loop.

## Memory Virtualization

### Shadow Page Tables
The Hypervisor maintains a **Shadow Page Table** that maps Guest virtual addresses directly to Host physical addresses, kept in sync with the Guest's own page tables by trapping every update the Guest makes.

*   **Pros**:
    *   Portable across different operating systems and hardware, since the technique requires no cooperation from the Guest OS and no special hardware support.
    *   Very fast once the Shadow Page Table is populated, because address translation for the [[Memory Management Unit|MMU]] hits the shadow table directly with no extra indirection at lookup time.
*   **Cons**:
    *   Significant overhead due to frequent trapping and emulation, since every Guest page table write must be intercepted and reflected into the shadow table to keep the two consistent.
    *   Requires managing multiple sets of page tables (the Guest's own tables plus the Hypervisor's shadow table).
    *   Frequent TLB flushes, since the shadow table changes on every Guest page table modification and the [[Translation Lookaside Buffer (TLB)|TLB]] must be invalidated to avoid using stale translations.

![[Shadow Page Table.png]]

### Paravirtualization
The Guest OS manages its own page tables but communicates changes to the hypervisor via hypercalls to maintain mapping consistency, avoiding the need for the Hypervisor to intercept every single page-table write the way Shadow Page Tables do.

![[Paravirtualization.png]]

## I/O Virtualization

*   **Hypervisor Emulation**:
    1.  The Guest OS traps to the Hypervisor.
    2.  The Hypervisor performs I/O on its behalf.
    3.  The Guest OS is interrupted to start its handler.
    4.  After fulfillment, the Guest OS traps back to the Hypervisor.
    *   **Result**: Two traps per I/O operation, which is very slow, since every I/O request and its completion each cost a separate expensive Guest-to-Hypervisor transition.

*   **VirtIO (Paravirtualization)**:
    *   Uses a **[[virtio|Virtual Queue]]** to minimize traps.
    *   The Guest and Hypervisor share a region of RAM for the queue, so requests can be written into shared memory without needing a trap just to hand them off.
    *   Requests are batched asynchronously into the Hypervisor, amortizing the cost of a trap across many I/O requests instead of paying it per-request.
    *   Once complete, the Hypervisor interrupts the Guest OS to receive results.

![[VirtIO's Virtual Queue.png]]

## Containers vs. Virtual Machines

*   **[[Containers and Virt#Containers|Containers]]**:
    *   Share the Host OS kernel.
    *   The Host OS isolates containers using **[[Containers and Virt#Core Linux Technologies|namespaces]]** and **[[Containers and Virt#Core Linux Technologies|control groups (cgroups)]]**, acting like a process with its own resources.
*   **Virtual Machines**:
    *   Use a hypervisor to virtualize hardware.
    *   Each VM runs its own full Guest OS, separate from the Host OS.

### Trade-offs
*   **Security**: VMs are generally more secure due to higher-level isolation (hardware-level), since a Guest OS is confined by the Hypervisor's hardware-enforced boundary rather than by kernel-level mechanisms it might share with other tenants.
*   **Efficiency**: Containers are more scalable, start faster, and make better use of hardware resources since they don't run a full kernel — there is no second kernel to boot and no virtualized hardware devices to emulate for each isolated instance.

## Deep Dive

### Why Trap & Emulate Struggled on x86
Classic **Trap & Emulate** virtualization depends on every sensitive (privileged) instruction causing a trap when executed outside of the most-privileged ring, so the Hypervisor gets a chance to intervene. Popek and Goldberg's 1974 virtualization requirements formalized this: a CPU architecture is efficiently virtualizable only if all sensitive instructions are also privileged instructions (i.e., they always trap when run in user mode). Original x86 violated this: certain instructions (e.g., `POPF`, which can silently modify the interrupt flag) behaved differently in user mode without trapping at all, silently failing instead of notifying the Hypervisor. This is precisely the gap that Hardware-Assisted Virtualization (VT-x/AMD-V) and Binary Translation were built to close, and it is why pure Trap & Emulate was historically infeasible on x86 without one of those two supplementary techniques.

## Formal Definition / Simplified Explanation

### Formal Definition
Following Popek and Goldberg (1974), a hypervisor is a **Virtual Machine Monitor (VMM)** if it satisfies three properties over the set of all instructions in the architecture:
1.  **Equivalence**: A program running under the VMM behaves identically (except for timing) to running on the bare hardware.
2.  **Resource Control**: The VMM has complete control over virtualized resources.
3.  **Efficiency**: A statistically dominant fraction of instructions must execute without VMM intervention.

An architecture is **classically virtualizable** if and only if the set of *sensitive instructions* (instructions that either alter or depend on the configuration of virtualized hardware) is a subset of the set of *privileged instructions* (instructions that trap when executed outside the highest privilege ring).

### Simplified Explanation
For a CPU to be virtualizable "the easy way" (Trap & Emulate), every instruction that the Guest might try to cheat with has to make the hardware yell for help (trap) automatically. If even one sneaky instruction can quietly do something to real hardware state without tripping an alarm, the Hypervisor cannot rely on Trap & Emulate alone — it has to either rewrite the Guest's code ahead of time (Binary Translation) or get help from newer, purpose-built CPU features (Hardware-Assisted Virtualization).

## Industry Standard Terms

| Course Term | Industry-Standard Equivalent |
|---|---|
| Hypervisor (Virtual Machine Monitor - VMM) | Virtualization Layer / VMM |
| Type-1 (Bare Metal) | Native Hypervisor |
| Type-2 (Hosted) | Hosted Hypervisor |
| Trap & Emulate | Classic trap-and-emulate virtualization |
| Hardware-Assisted Virtualization | Intel VT-x / AMD-V (Hardware Virtual Machine, HVM) |
| Hypercalls | Paravirtualized system calls (analogous to a syscall, but Guest-to-Hypervisor) |
| Shadow Page Table | Memory Management Unit (MMU) virtualization / Shadow paging |
| VirtIO Virtual Queue | Paravirtualized I/O ring buffer (virtqueue, per the VirtIO spec) |
| VM-Entry | Resuming/dispatching a Guest (analogous to a context switch back to user mode) |

## Related
- [[Containers and Virt|Virtualization and Containers]] — Root/Guest Mode, VM Exit, Type 1/Type 2 hypervisors, and Linux container primitives in more depth
- [[Memory Management Unit|Memory Management Unit]] — the hardware the Shadow Page Table must stay consistent with
- [[Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]] — why Shadow Page Table updates trigger TLB flushes
- [[User Mode|User Mode]] / [[Kernel Mode|Kernel Mode]] — the privilege-level distinction that Root Mode/Guest Mode extends
- [[Meltdown|Meltdown]] — a case where hardware speculative-execution side effects cross an isolation boundary, conceptually related to why VM isolation guarantees must be hardware-enforced

## References

*   *Operating Systems: Principles and Practice* (2nd Edition)
*   *Hardware and Software Support for Virtualization*
*   *Compiler Design: Virtual Machines*
*   VMScape