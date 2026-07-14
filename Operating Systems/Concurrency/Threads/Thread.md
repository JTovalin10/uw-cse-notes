# CSE451: Thread

OSTEP: *"A multi-threaded program has more than one point of execution (i.e., multiple PCs, each of which is being fetched and executed from). Each thread is very much like a separate process, except for one difference: they share the same address space and thus can access the same data."*

A **thread** is a single sequence of execution within a **[[Operating Systems/Virtualization/Processes/Process|Process]]**. It is the smallest unit of CPU scheduling. This matches the **[[Key Idea]]** of separating the unit of resource ownership (the process) from the unit of scheduling (the thread).

A process can have multiple threads, all sharing the same address space but each with their own execution context.

## What a Thread Does
- Allows concurrent execution within a single process
- Enables parallelism on multi-core CPUs
- Shares resources (memory, files) with other threads in the same process
- Each thread has its own:
	- **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Program Counter (PC)|Program Counter]]** — tracks which instruction to execute next
	- **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Registers|Registers]]** — holds thread-specific data
	- **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Stack Pointer (SP)|Stack Pointer]]** / Stack — for function calls and local variables

## Why Use Threads
- **Responsiveness** — UI can stay responsive while background work happens
- **Resource sharing** — threads share memory, cheaper than IPC between processes
- **Economy** — creating/switching threads is cheaper than processes
- **Parallelism** — can utilize multiple CPU cores

See **[[Value of Process Thread Separation]]** for concrete walkthroughs of each of these motivations (web servers, GUIs, producer/consumer).

## Thread States

Same as **[[Operating Systems/Virtualization/Processes/Process/Process State|Process State]]**:
- Running
- Ready
- Blocked/Waiting

## Types of Threads
- **User-level threads** — managed by a user-space library, kernel unaware. See **[[Thread Levels/User Threads|User Threads]]**.
- **Kernel-level threads** — managed by the OS, kernel schedules them directly. See **[[Thread Levels/Kernel Threads|Kernel Threads]]**.
- **Hybrid** — maps many user threads to fewer kernel threads. See **[[Thread Levels/Scheduler Activations|Scheduler Activations]]**.

For a full comparison of the tradeoffs between these types, see **[[Thread Levels/User vs Kernel Threads|User vs Kernel Threads]]** and the overall **[[Thread Levels]]** hub.

## Deep Dive

Every thread also has a small amount of **thread-local storage (TLS)** in addition to its stack, registers, and program counter — a per-thread area for variables that should not be shared across threads even though the rest of the address space is shared (e.g., `errno` in POSIX, or a per-thread random number generator seed). This is distinct from the private stack: TLS is typically allocated statically or via a dedicated allocation call (e.g., `pthread_key_create`), rather than growing dynamically like a stack does.

## Industry Standard Terms
- **Thread** -> pthread (`pthread_t`) / `java.lang.Thread` / Windows thread `HANDLE`
- **Thread state (PC, SP, registers)** -> Thread Control Block (TCB)
- **Process** -> OS process / Process Control Block (PCB)

## Related
- [[Systems Programming/Concurrency/Threads|CSE333: Threads]]
- [[Data Structures and Parallelism/Parallelism/Concurrency And Locks|CSE332: Concurrency and Locks]]
- [[Operating Systems/Virtualization/Processes/ProcessComponents/Process vs Thread|Process vs Thread]]
- [[Operating Systems/Virtualization/Processes/Process|Process]]
- [[Key Idea]]
- [[Thread Levels]]
- [[Threads and Processes]]

## Source
- OSTEP Chapter 26: Concurrency - An Introduction
