# CSE451: Process Management

In operating systems, **Process Management** is the core responsibility of the kernel to oversee the execution, resource allocation, and isolation of programs.

## The Process Model

An [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] executes diverse activities:
- **User Programs**: Web browsers, text editors.
- **Batch Jobs**: Data processing scripts.
- **System Programs**: Print spoolers, network daemons, file servers.

Each of these activities is encapsulated in a **[[Process|Process]]**. A process is more than just the executable code (the "Program"); it is the **active execution** of that program — see [[Process#Process vs Program|Process vs Program]] for the distinction.

### Execution Context

A process includes its entire **[[Process#Execution Context|Execution Context]]**, which consists of:
- **[[CPU State|CPU State]]**: Program counter, stack pointer, and general-purpose registers.
- **[[Process#Process's Address Space (idealized)|Memory State]]**: Code, data, stack, and heap.
- **OS Resources**: Open file descriptors, signal handlers, and security credentials.

All of this state is what the OS records in a process's **[[Process Control Block|Process Control Block (PCB)]]** whenever the process isn't actively running.

## Responsibilities of Process Management

The OS's process module (often called the **Process Manager**) performs several critical functions:

1. **[[Process Creation|Creation and Termination]]**: Managing the lifecycle of processes via syscalls like `fork()` and `exec()`. See [[Process Lifecycle Events|Process Lifecycle Events]] for the full creation-to-termination timeline.
2. **[[Scheduling|CPU Scheduling]]**: Deciding which process gets to run on the CPU at any given time to ensure fairness and efficiency.
3. **[[Process State|State Management]]**: Tracking whether a process is Running, Ready, or Blocked (waiting for I/O), and moving its [[Process Control Block|PCB]] between the appropriate [[State Queues|state queues]] as its status changes.
4. **Synchronization and Communication**: Providing mechanisms (IPC) for processes to share data and coordinate actions without interfering with each other's private state.

## Process Isolation

The fundamental goal of process management is **Isolation**. Every process should believe it has the entire CPU and a private, contiguous block of memory to itself. The kernel enforces this via:
- **[[Operating Systems/Virtualization/Mechanisms/Modes/Hardware Modes|Hardware Protection]]**: Utilizing Kernel/User mode bits to prevent user processes from executing privileged instructions.
- **[[Operating Systems/Virtualization/Memory/Address Translation/Address Translation|Address Translation]]**: Mapping virtual addresses to physical memory (via the **[[Operating Systems/Virtualization/Mechanisms/Memory/Virtual Addresses|Virtual Addresses]]** mechanism) so one process cannot access another's memory.

This isolation is what makes it safe for the OS to freely context switch between mutually distrusting processes — see [[CPU State#Context Switch|Context Switch]] and [[Process vs Thread|Process vs Thread]] for how this isolation differs from the weaker guarantees provided between threads of the same process.

## Related
- [[Process|Process Overview]]
- [[Scheduling|Scheduling]]
- [[Process Control Block|Process Control Block (PCB)]]
- [[Process State|Process State]]
- [[State Queues|State Queues]]
- [[Process Lifecycle Events|Process Lifecycle Events]]
- [[Process vs Thread|Process vs Thread]]
- [[Systems Programming/Process Management/Process Management|Systems: Process Management (API View)]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Process Manager | Process scheduler / kernel process subsystem |
| Process Isolation | Memory protection / sandboxing |

