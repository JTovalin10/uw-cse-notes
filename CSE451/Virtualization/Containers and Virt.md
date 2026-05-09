# CSE451: Virtualization and Containers

Virtualization allows multiple isolated Operating System instances to run on a single physical machine by virtualizing the underlying hardware.

### Hardware-Assisted Virtualization
Modern CPUs (e.g., Intel VT-x) provide specific support for the **[[Hypervisor (VMM)]]**.

- **[[Root Mode]]**: The mode in which the Hypervisor runs (Ring -1).
- **[[Guest Mode]]**: The mode in which the Guest OS runs.
- **[[VMCS (Virtual Machine Control Structure)]]**: A hardware structure that stores the state of a virtual machine.
- **[[VM Exit]]**: Occurs when the Guest performs a privileged operation, forcing a transition to Root Mode so the Hypervisor can emulate the instruction.

### Type 1 vs Type 2 Hypervisors
- **[[Type 1 (Bare Metal)]]**: Runs directly on the hardware (e.g., Xen, VMware ESXi). More efficient but harder to manage.
- **[[Type 2 (Hosted)]]**: Runs as an application within a Host OS (e.g., VirtualBox, VMware Workstation). Easier to install but introduces host-OS overhead.
- **[[KVM (Kernel-based Virtual Machine)]]**: A hybrid approach where the Linux kernel itself becomes a Type 1 hypervisor.

### Containers
**[[Containers]]** provide OS-level virtualization. Unlike VMs, containers share the same host kernel, making them significantly lighter and faster.

#### Core Linux Technologies
- **[[Namespaces]]**: Provide **isolation**. Each container has its own view of the system (e.g., PID namespace prevents a container from seeing other processes).
- **[[Control Groups (cgroups)]]**: Provide **resource limiting**. Restricts the amount of CPU, memory, and I/O a container can consume.
- **[[Union FS (OverlayFS)]]**: Allows multiple file systems to be layered. Each container starts with a read-only "image" layer and a private writable layer on top.

### Paravirtualization
- **[[virtio]]**: A standardized interface for "virtual IO" where the Guest OS is aware it is running in a VM and uses optimized drivers to communicate with the Hypervisor, bypassing expensive hardware emulation.

### Related
- [[CSE451/Virtualization/KVM]]
- [[CSE451/Virtualization/Memory Ballooning]]
