# CSE451: Threads and Processes

**[[Operating Systems/Virtualization/Processes/Process|Process]]**: defines the address space and general process attributes — the house.
**[[Thread]]**: defines a sequential execution stream within a process — the people living in the house.

A thread is bound to a single process/address space:
- Address spaces can have multiple threads executing within them
- Sharing data between threads is cheap, and so is creating them
- But all threads in a process live and die together: if the process is killed, all its threads are terminated

Threads become the unit of scheduling:
- Processes/address spaces are just containers in which threads execute
- The OS scheduler operates at the thread level, not the process level
- When we say "a process is running," we really mean "a thread belonging to that process is running on a core"

This is a direct restatement of the **[[Key Idea]]**: the process is the unit of resource ownership, while the thread is the unit of scheduling.

The relationship:
- A process always has at least one thread (the main thread) — see **[[What is a Process]]**
- Additional threads are created explicitly (e.g., `pthread_create` in POSIX, `CreateThread` in Windows) — see **[[Achieving Multithreading]]** for the mechanics of thread creation
- All threads in a process share: code, global data, heap, open files
- Each thread has its own: stack, registers, program counter, thread-local storage — see **[[Address Space with Threads]]** for how these private stacks are laid out within the shared address space

Analogy extended:
- The **house** (process) provides the shared space: kitchen, living room, bathroom (address space, files, resources)
- The **people** (threads) each have their own bedroom (private stack) and can move around the shared spaces independently
- If the house burns down (process crash), everyone inside is affected

## Industry Standard Terms
- **Thread creation** -> `pthread_create()` (POSIX) / `CreateThread()` (Windows)
- **Process** -> OS process / Process Control Block (PCB)

## Related
- [[Systems Programming/Concurrency/Threads|CSE333: Implementation - POSIX Threads (pthreads)]]
- [[Data Structures and Parallelism/Parallelism/Concurrency And Locks|CSE332: Concurrency and Locks]]
- [[Key Idea]]
- [[Thread]]
- [[What is a Process]]
- [[Achieving Multithreading]]
- [[Address Space with Threads]]
