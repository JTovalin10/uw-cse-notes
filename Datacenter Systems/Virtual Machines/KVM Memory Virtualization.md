# Virtual Machines: KVM Memory Virtualization

## Mechanism 5: KVM Memory Virtualization & Instruction Emulation

The Kernel-based Virtual Machine (KVM) operates as a Type-2 hypervisor where the VM is represented as a standard Linux userspace process (`qemu-kvm`). While KVM relies on EPT today, its memory architecture introduces unique complexities when the hypervisor must emulate guest instructions (e.g., during an MMIO VM-Exit).

- **Accessing Guest-Physical Memory (GPA $\to$ HVA)**: In KVM, mapping guest-physical addresses is trivial. The userspace process maps the VM's physical RAM as a contiguous virtual memory region. The hypervisor accesses any guest-physical address simply by adding a constant offset: $\text{HVA} = \text{GPA} + \text{Offset}_{\text{VM}}$.
- **The Difficulty of Guest Virtual Addresses**: Accessing the guest's *virtual* address space from the hypervisor is incredibly difficult. The GVA $\to$ GPA mapping only exists inside the processor's MMU while the VM executes in Non-Root mode.
- **Software Instruction Decoding**: When a VM-Exit occurs, the KVM instruction decoder must read the faulting instruction from memory using the guest instruction pointer ($RIP$), and its memory operands all refer to guest virtual addresses. To resolve these, the KVM emulator must perform repeated **software page walks** of the guest page tables in memory to determine the correct guest-physical locations of the instruction and its operands.

![[Screenshots/KVM.png]]

## Related

- [[Datacenter Systems/Virtual Machines|Virtual Machines]] — Hub for this topic
- [[Datacenter Systems/Virtual Machines/Nested Paging with EPT and NPT|Nested Paging with EPT and NPT]] — Hardware two-dimensional page walks, superpages, VPID, and page modification logging
- [[Datacenter Systems/Virtual Machines/Memory Ballooning|Memory Ballooning]] — Overcommitment, double paging, and the balloon driver
