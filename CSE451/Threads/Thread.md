# What is it
OSTEP: *"A multi-threaded program has more than one point of execution (i.e., multiple PCs, each of which is being fetched and executed from). Each thread is very much like a separate process, except for one difference: they share the same address space and thus can access the same data."*

A thread is a single sequence of execution within a [[Process]]. It is the smallest unit of CPU scheduling.

A process can have multiple threads, all sharing the same address space but each with their own execution context.

# What does it do
- Allows concurrent execution within a single process
- Enables parallelism on multi-core CPUs
- Shares resources (memory, files) with other threads in the same process
- Each thread has its own:
	- [[CSE451/Processes/CPUState/Program Counter]] - tracks which instruction to execute next
	- [[Registers]] - holds thread-specific data
	- [[CSE451/Processes/CPUState/Stack Pointer]] / Stack - for function calls and local variables

# Why use threads
- **Responsiveness** - UI can stay responsive while background work happens
- **Resource sharing** - threads share memory, cheaper than IPC between processes
- **Economy** - creating/switching threads is cheaper than processes
- **Parallelism** - can utilize multiple CPU cores

# Thread States
Same as [[Process State]]:
- Running
- Ready
- Blocked/Waiting

# Types
- **User-level threads** - managed by user-space library, kernel unaware
- **Kernel-level threads** - managed by OS, kernel schedules them directly
- **Hybrid** - maps many user threads to fewer kernel threads

# Related
- [[Process vs Thread]]
- [[Context Switch]]
- [[Process]]

# Source
- OSTEP Chapter 26: Concurrency - An Introduction
