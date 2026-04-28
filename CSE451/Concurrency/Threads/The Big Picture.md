# The big picture
threads are about **[[concurrency]]** and **[[parallelism]]**

one way to get concurrency and parallelism is to use multiple processes
- the programs of distinct processes are isolated from each other
- each process has its own address space, so one process cannot directly access another's memory
- communication between processes requires OS-mediated IPC (pipes, sockets, shared memory)

however threads are another way to achieve this
- threads share a process - same address space, same OS resources
- threads have a private stack, CPU state - and are independently schedulable

the tradeoff:
| | multiple processes | multiple threads |
|---|---|---|
| isolation | strong - separate address spaces | weak - shared address space |
| communication | expensive (IPC through OS) | cheap (shared memory) |
| creation cost | high (new address space, copy page tables) | low (just allocate a stack + register set) |
| context switch cost | higher (TLB flush, page table swap) | lower (same address space, no TLB flush needed) |
| fault containment | good - crash in one process doesn't affect others | poor - a bug in one thread can corrupt shared memory and crash the whole process |

threads are preferred when tasks need to share data frequently and the overhead of IPC would be too costly. processes are preferred when isolation and fault tolerance matter more.
