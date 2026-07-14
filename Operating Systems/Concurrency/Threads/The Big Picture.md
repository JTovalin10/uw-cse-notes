# CSE451: The Big Picture

Threads are about achieving concurrency and parallelism, as introduced in **[[Threads Overview]]**.

One way to get concurrency and parallelism is to use multiple processes:
- The programs of distinct processes are isolated from each other
- Each process has its own address space, so one process cannot directly access another's memory
- Communication between processes requires OS-mediated Inter-Process Communication (IPC) (pipes, sockets, shared memory)

However, threads are another way to achieve this:
- **[[Thread|Threads]]** share a process — same address space, same OS resources
- Threads have a private stack, CPU state — and are independently schedulable

The tradeoff:

| | Multiple Processes | Multiple Threads |
|---|---|---|
| Isolation | Strong — separate address spaces | Weak — shared address space |
| Communication | Expensive (IPC through OS) | Cheap (shared memory) |
| Creation cost | High (new address space, copy page tables) | Low (just allocate a stack + register set) |
| Context switch cost | Higher (TLB flush, page table swap) | Lower (same address space, no TLB flush needed) |
| Fault containment | Good — crash in one process doesn't affect others | Poor — a bug in one thread can corrupt shared memory and crash the whole process |

Threads are preferred when tasks need to share data frequently and the overhead of IPC would be too costly. Processes are preferred when isolation and fault tolerance matter more. This is the same isolation-versus-sharing tradeoff explored concretely in **[[Value of Process Thread Separation]]**, and the mechanics of *how* threads achieve their cheaper creation and switching costs are covered in **[[Achieving Multithreading]]**.

## Industry Standard Terms
- **Inter-Process Communication (IPC)** -> pipes, sockets, shared memory segments, message queues
- **TLB flush** -> Translation Lookaside Buffer invalidation on address-space switch

## Related
- [[Threads Overview]]
- [[Thread]]
- [[Achieving Multithreading]]
- [[Value of Process Thread Separation]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
