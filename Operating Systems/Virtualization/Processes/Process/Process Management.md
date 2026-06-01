# CSE 451: Process Management

In operating systems, **Process Management** is the core responsibility of the kernel to oversee the execution, resource allocation, and isolation of programs.

## The Process Model
An [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] executes diverse activities:
- **User Programs**: Web browsers, text editors.
- **Batch Jobs**: Data processing scripts.
- **System Programs**: Print spoolers, network daemons, file servers.

Each of these activities is encapsulated in a **[[Process|Process]]**. A process is more than just the executable code (the "Program"); it is the **active execution** of that program.

### Execution Context
A process includes its entire **[[Process#Execution Context|Execution Context]]**, which consists of:
- **[[CPU State#Registers|CPU State]]**: Program counter, stack pointer, and general-purpose registers.
- **[[Process#Process's Address Space (idealized)|Memory State]]**: Code, data, stack, and heap.
- **OS Resources**: Open file descriptors, signal handlers, and security credentials.

## Responsibilities of Process Management
The OS's process module (often called the **Process Manager**) performs several critical functions:

1.  **[[Process Creation|Creation and Termination]]**: Managing the lifecycle of processes via syscalls like `fork()` and `exec()`.
2.  **[[Scheduling|CPU Scheduling]]**: Deciding which process gets to run on the CPU at any given time to ensure fairness and efficiency.
3.  **[[Process State|State Management]]**: Tracking whether a process is Running, Ready, or Blocked (waiting for I/O).
4.  **[[Process Control Block|Synchronization and Communication]]**: Providing mechanisms (IPC) for processes to share data and coordinate actions without interfering with each other's private state.

## Process Isolation
The fundamental goal of process management is **Isolation**. Every process should believe it has the entire CPU and a private, contiguous block of memory to itself. The kernel enforces this via:
- **[[Hardware Modes|Hardware Protection]]**: Utilizing Kernel/User mode bits to prevent user processes from executing privileged instructions.
- **[[Address Translation|Address Translation]]**: Mapping virtual addresses to physical memory so one process cannot access another's memory.

## Related
- [[Process|Process Overview]]
- [[Scheduling|Scheduling]]
- [[Process Control Block|Process Control Block (PCB)]]
- [[Systems Programming/Process Management/Process Management|Systems: Process Management (API View)]]
