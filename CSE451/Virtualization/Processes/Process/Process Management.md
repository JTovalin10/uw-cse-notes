# CSE 451: Process Management

In operating systems, **Process Management** is the core responsibility of the kernel to oversee the execution, resource allocation, and isolation of programs.

## The Process Model
An [[CSE451/Virtualization/Architecture/Operating System|Operating System]] executes diverse activities:
- **User Programs**: Web browsers, text editors.
- **Batch Jobs**: Data processing scripts.
- **System Programs**: Print spoolers, network daemons, file servers.

Each of these activities is encapsulated in a **[[CSE451/Virtualization/Processes/Process|Process]]**. A process is more than just the executable code (the "Program"); it is the **active execution** of that program.

### Execution Context
A process includes its entire **[[CSE451/Virtualization/Processes/Process#Execution Context|Execution Context]]**, which consists of:
- **[[CSE451/Virtualization/Processes/CPUState/CPU State#Registers|CPU State]]**: Program counter, stack pointer, and general-purpose registers.
- **[[CSE451/Virtualization/Processes/Process#Process's Address Space (idealized)|Memory State]]**: Code, data, stack, and heap.
- **OS Resources**: Open file descriptors, signal handlers, and security credentials.

## Responsibilities of Process Management
The OS's process module (often called the **Process Manager**) performs several critical functions:

1.  **[[CSE451/Virtualization/Processes/ProcessComponents/Process Creation|Creation and Termination]]**: Managing the lifecycle of processes via syscalls like `fork()` and `exec()`.
2.  **[[CSE451/Virtualization/Processes/Scheduling|CPU Scheduling]]**: Deciding which process gets to run on the CPU at any given time to ensure fairness and efficiency.
3.  **[[CSE451/Virtualization/Processes/Process/Process State|State Management]]**: Tracking whether a process is Running, Ready, or Blocked (waiting for I/O).
4.  **[[CSE451/Virtualization/Processes/Process/Process Control Block|Synchronization and Communication]]**: Providing mechanisms (IPC) for processes to share data and coordinate actions without interfering with each other's private state.

## Process Isolation
The fundamental goal of process management is **Isolation**. Every process should believe it has the entire CPU and a private, contiguous block of memory to itself. The kernel enforces this via:
- **[[CSE451/Virtualization/Mechanisms/Modes/Hardware Modes|Hardware Protection]]**: Utilizing Kernel/User mode bits to prevent user processes from executing privileged instructions.
- **[[CSE451/Virtualization/Memory/Address Translation/Address Translation|Address Translation]]**: Mapping virtual addresses to physical memory so one process cannot access another's memory.

## Related
- [[CSE451/Virtualization/Processes/Process|Process Overview]]
- [[CSE451/Virtualization/Processes/Scheduling|Scheduling]]
- [[CSE451/Virtualization/Processes/Process/Process Control Block|Process Control Block (PCB)]]
- [[CSE333/Process Management/Process Management|Systems: Process Management (API View)]]
