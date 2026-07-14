# CSE451: Threads Overview

**[[Thread|Threads]]** are concurrent executions sharing an address space (and some OS resources).

## Concurrency vs. Parallelism
- **Concurrency**: Logically (and possibly physically) simultaneous operations for convenience or simplicity. It is about *dealing with* many things at once.
- **Parallelism**: Physically simultaneous operations for performance. It is about *doing* many things at once.

## Why Threads?
- **Address Space Sharing**: Address spaces provide isolation. Communication between processes is expensive because it must go through the OS (pipes, sockets, shared memory syscalls). This isolation-versus-sharing tradeoff is laid out in more detail in **[[The Big Picture]]**.
- **Cheap Communication**: Threads within the same address space can communicate cheaply by updating shared variables. They use locks to control access, avoiding the need for OS intervention for data transfer.
- **Shared Resources**: Threads within the same process share:
	- Open file descriptors
	- Signal handlers
	- Working directory
	- User and group IDs

## Thread-Specific State
While they share much, each thread has its own private:
- **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Stack Pointer|Stack Pointer]]** and stack
- **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Program Counter|Program Counter]]**
- Set of CPU registers
- Thread ID

This division of "shared" vs. "private" state is exactly what **[[Address Space with Threads]]** lays out spatially within the process's address space.

## Challenges
Because threads share the same address space and can directly read/write the same memory locations, they require **[[Operating Systems/Concurrency/Synchronization|synchronization]]** to avoid race conditions. See **[[Value of Process Thread Separation]]** for concrete examples (like producer/consumer) where this sharing is a double-edged sword — cheap to communicate, but requiring careful coordination.

## Related
- [[Operating Systems/Concurrency/Threads/Threads]]
- [[Operating Systems/Virtualization/Processes/Process|Process]]
- [[Operating Systems/Concurrency/Synchronization]]
- [[The Big Picture]]
- [[Value of Process Thread Separation]]
- [[Thread Levels]]
