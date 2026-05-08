# Course: Threads Overview

Threads are **concurrent executions sharing an address space (and some OS resources)**.

## Concurrency vs. Parallelism
- **Concurrency**: Logically (and possibly physically) simultaneous operations for convenience or simplicity. It is about *dealing with* many things at once.
- **Parallelism**: Physically simultaneous operations for performance. It is about *doing* many things at once.

## Why Threads?
- **Address Space Sharing**: Address spaces provide isolation. Communication between processes is expensive because it must go through the OS (pipes, sockets, shared memory syscalls).
- **Cheap Communication**: Threads within the same address space can communicate cheaply by updating shared variables. They use locks to control access, avoiding the need for OS intervention for data transfer.
- **Shared Resources**: Threads within the same process share:
    - Open file descriptors
    - Signal handlers
    - Working directory
    - User and group IDs

## Thread-Specific State
While they share much, each thread has its own private:
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Stack Pointer|Stack Pointer]] and stack
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Program Counter|Program Counter]]
- Set of CPU registers
- Thread ID

## Challenges
Because threads share the same address space and can directly read/write the same memory locations, they require [[Synchronization|synchronization]] to avoid race conditions.

## Related
- [[CSE451/Concurrency/Threads/Threads]]
- [[CSE451/Virtualization/Processes/Process|Processes]]
- [[Synchronization]]
