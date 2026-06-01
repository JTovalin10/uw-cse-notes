# CSE451: Kernel Internals and Performance

The Kernel is the core component of the OS, managing hardware resources and providing a bridge between software and hardware.

### Kernel Architectures
- **[[Monolithic Kernel]]**: All OS services (File System, Networking, Device Drivers) run in kernel space. High performance but one bug can crash the entire system (e.g., Linux).
- **[[Microkernel]]**: Moves as many services as possible to user space. More robust and modular but slower due to intensive Inter-Process Communication (IPC) (e.g., Minix, Mach).

### Interrupt Handling
Interrupts are divided into two parts to maintain system responsiveness:
1. **[[Top Half]]**: The immediate response to hardware. It runs with interrupts disabled, performs minimal work (e.g., acknowledges hardware), and schedules the bottom half.
2. **[[Bottom Half]]**: Performs the heavy lifting (e.g., processing network packets). It runs with interrupts enabled.
    - **[[Softirq]]**: Fast, statically allocated, and can run on multiple CPUs simultaneously.
    - **[[Tasklet]]**: Built on top of softirqs but only run on one CPU at a time.
    - **[[Workqueue]]**: Runs in process context, meaning it can sleep.

### Kernel Interfaces
- **[[procfs (/proc)]]**: A virtual filesystem providing an interface to kernel data structures and process information.
- **[[sysfs (/sys)]]**: A virtual filesystem used for managing hardware devices and kernel parameters.
- **[[debugfs]]**: A virtual filesystem specifically for kernel debugging and tracing.

### Performance Profiling and Tracing
- **[[perf]]**: The standard Linux performance analysis tool. It can sample CPU registers, trace system calls, and count hardware events.
- **[[Flame Graph]]**: A visualization of profiled software, allowing for quick identification of the "hot paths" where the CPU spends the most time.
- **[[eBPF (Extended Berkeley Packet Filter)]]**: A revolutionary technology that allows running sandboxed programs inside the kernel without changing kernel source code. Used for high-performance networking and deep observability.
- **[[kprobes / uprobes]]**: Mechanisms for dynamically breaking into kernel or user functions to collect debug information.

### Related
- [[Signals and Syscalls]]
- [[CSE451/Kernel/Definitions/LKM]]
