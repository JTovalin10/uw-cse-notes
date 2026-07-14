# CSE451: Key Idea

Separate the concept of a **[[Operating Systems/Virtualization/Processes/Process|process]]** from that of a minimal "thread of control" (execution state: stack, stack pointer, program counter, registers). This execution state is usually called a **[[Thread]]** or a **lightweight process (LWP)**.

Historically, the process was both the unit of resource ownership (address space, files) and the unit of scheduling (what the CPU runs). The key insight is to decouple these two roles:

- **Process** = unit of resource ownership
	- Owns the address space
	- Owns open files, sockets, and other OS resources
	- Acts as a container
- **[[Thread]]** = unit of scheduling / execution
	- Has its own stack, program counter, and registers
	- Is what the CPU actually runs
	- Can be independently scheduled

This separation means:
- You can have multiple threads of execution within a single resource container (process)
- Creating a new thread is cheap because you don't need to duplicate the address space
- Switching between threads in the same process is cheap because you don't need to swap page tables — see **[[Achieving Multithreading]]** for how the OS implements this context-switch mechanism

This is the fundamental design principle behind modern multithreaded operating systems (Linux, Windows, macOS all follow this model). See **[[Threads and Processes]]** for the house/people analogy that makes this separation concrete, and **[[Value of Process Thread Separation]]** for why this decoupling is valuable even on a single core.

## Deep Dive

The decoupling of "unit of resource ownership" from "unit of scheduling" mirrors a broader pattern in OS design: separating **mechanism from policy** (see [[Operating Systems/Virtualization/Architecture/Operating System|Operating System]] design principles). The process defines the mechanism for resource containment, while the thread scheduler's policy (round robin, priority, etc.) determines execution order independently of how resources are grouped. This is also the conceptual ancestor of Linux's `clone()` syscall, which lets a caller create a new schedulable entity while selectively sharing (or not sharing) the address space, file descriptor table, and other resources with the parent — blurring the traditional line between "process" and "thread" into a single spectrum of shared/unshared resources.

## Formal Definition

$$\text{Process} = \langle \text{AddressSpace}, \text{Resources}, \{T_1, T_2, \dots, T_n\} \rangle$$

where each $T_i$ is a thread defined by its own execution state $\langle PC_i, SP_i, \text{Registers}_i \rangle$, and all $T_i$ share the same $\text{AddressSpace}$ and $\text{Resources}$.

### Simplified Explanation

A process is the box; threads are the workers inside the box. The box holds the shared stuff (memory, files); each worker carries only their own personal notebook (stack, registers, and a bookmark for where they are in the instructions).

## Industry Standard Terms
- **Thread** -> pthread (POSIX Threads) / `java.lang.Thread` / Windows `HANDLE` to a thread object
- **Lightweight Process (LWP)** -> Solaris/older Unix terminology for a kernel-scheduled thread; roughly equivalent to a kernel thread in Linux
- **Process** -> OS process / `task_struct` (Linux kernel implementation)

## Related
- [[Thread]]
- [[Threads and Processes]]
- [[Value of Process Thread Separation]]
- [[Achieving Multithreading]]
- [[Operating Systems/Virtualization/Processes/Process|Process]]
- [[Operating Systems/Processes/Process and Thread Fundamentals]]
