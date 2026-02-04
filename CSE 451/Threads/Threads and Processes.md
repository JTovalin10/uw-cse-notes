# Threads and processes
**processes**: defines the address space and general process attributes - the house
**thread**: defines a sequential execution stream within a process - the people living in the house

a thread is bound to a single process / address space
- address spaces can have multiple threads executing within them
- sharing data between threads is cheap, and so is creating them
- but all threads in a process live and die together: if the process is killed, all its threads are terminated

threads become the unit of scheduling
- processes / address spaces are just containers in which threads execute
- the OS scheduler operates at the thread level, not the process level
- when we say "a process is running," we really mean "a thread belonging to that process is running on a core"

the relationship:
- a process always has at least one thread (the main thread)
- additional threads are created explicitly (e.g., `pthread_create` in POSIX, `CreateThread` in Windows)
- all threads in a process share: code, global data, heap, open files
- each thread has its own: stack, registers, program counter, thread-local storage

analogy extended:
- the **house** (process) provides the shared space: kitchen, living room, bathroom (address space, files, resources)
- the **people** (threads) each have their own bedroom (private stack) and can move around the shared spaces independently
- if the house burns down (process crash), everyone inside is affected
