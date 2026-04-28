# Virtual Machines

Virtual Machines (VMs) provide an isolated environment that mimics a physical computer, allowing multiple operating systems to run on a single piece of hardware.

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
*   **Hypervisor (Virtual Machine Monitor - VMM)**: Software that creates and runs Virtual Machines by virtualizing hardware resources.
    *   **Type-1 (Bare Metal)**: Runs directly on the system's hardware (e.g., Microsoft Hyper-V, VMware ESXi, Xen).
    *   **Type-2 (Hosted)**: Runs as an application on a host OS (e.g., VirtualBox, VMware Workstation, KVM/QEMU).

![[Hypervisors.png]]

## System-Level Virtual Machines

*   Possess their own virtualized hardware.
*   Can run any operating system of choice.
*   The **Guest OS** runs in a less-privileged "user mode," while the hypervisor manages privileged operations.

![[System-Level Virtual Machines.png]]

### CPU Virtualization and Privileged Instructions

For a Guest OS to execute privileged instructions, the hypervisor must intervene. Common solutions include:

1.  **Binary Translation**: The hypervisor scans guest code and replaces sensitive instructions with calls to the hypervisor (high overhead).
2.  **Hardware-Assisted Virtualization**: Modern processors (Intel VT-x, AMD-V) introduce a "non-root" mode for guests, allowing some instructions to run at native speed while trapping others.
3.  **Trap & Emulate**: The Guest OS attempts a privileged instruction, causing a hardware trap to the hypervisor, which then emulates the instruction. This may not work for all instructions on older architectures.
4.  **Paravirtualization**: The Guest OS is "enlightened"—it is modified to know it is virtualized and uses **Hypercalls** to communicate directly with the hypervisor.

### Guest App System Call Flow (Type-2 Example)

1.  The guest application makes a system call; the hardware detects this and traps to the **Hypervisor**.
2.  The Hypervisor analyzes the instruction, updates its virtual hardware state, and (in Type-2) might trap to the **Host OS**.
3.  The **Host OS** emulates the system call and returns control to the Hypervisor.
4.  The Hypervisor increments the guest app's `%RIP` (Instruction Pointer), restores state, and calls **VM-Entry** to return to the guest.

## Memory Virtualization

### Shadow Page Tables
*   **Pros**:
    *   Portable across different operating systems and hardware.
    *   Very fast once the Shadow Page Table is populated.
*   **Cons**:
    *   Significant overhead due to frequent trapping and emulation.
    *   Requires managing multiple sets of page tables.
    *   Frequent TLB flushes.

![[Shadow Page Table.png]]

### Paravirtualization
The Guest OS manages its own page tables but communicates changes to the hypervisor via hypercalls to maintain mapping consistency.

![[Paravirtualization.png]]

## I/O Virtualization

*   **Hypervisor Emulation**:
    1.  The Guest OS traps to the Hypervisor.
    2.  The Hypervisor performs I/O on its behalf.
    3.  The Guest OS is interrupted to start its handler.
    4.  After fulfillment, the Guest OS traps back to the Hypervisor.
    *   **Result**: Two traps per I/O operation, which is very slow.

*   **VirtIO (Paravirtualization)**:
    *   Uses a **Virtual Queue** to minimize traps.
    *   The Guest and Hypervisor share a region of RAM for the queue.
    *   Requests are batched asynchronously into the Hypervisor.
    *   Once complete, the Hypervisor interrupts the Guest OS to receive results.

![[VirtIO's Virtual Queue.png]]

## Containers vs. Virtual Machines

*   **Containers**:
    *   Share the Host OS kernel.
    *   The Host OS isolates containers using namespaces and control groups (cgroups), acting like a process with its own resources.
*   **Virtual Machines**:
    *   Use a hypervisor to virtualize hardware.
    *   Each VM runs its own full Guest OS, separate from the Host OS.

### Trade-offs
*   **Security**: VMs are generally more secure due to higher-level isolation (hardware-level).
*   **Efficiency**: Containers are more scalable, start faster, and make better use of hardware resources since they don't run a full kernel.

## References

*   *Operating Systems: Principles and Practice* (2nd Edition)
*   *Hardware and Software Support for Virtualization*
*   *Compiler Design: Virtual Machines*
*   VMScape