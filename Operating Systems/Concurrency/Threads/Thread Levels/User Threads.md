# CSE451: User Threads

**User threads** are cheap and good for common-case operations, but suffer in uncommon cases due to kernel obliviousness.

- Threading can be implemented entirely in user space
- Each thread keeps a separate stack and processor context in user space
- A user-level thread library handles scheduling and switching

## Context Switching

Library saves running thread's processor context -> picks a new thread to run -> restores its context and jumps to the saved PC.

(Same flow as the kernel, but no kernel involvement — contrast with **[[Kernel Threads]]**, which requires a trap into the kernel for every switch.)

## N:1 Scheduling

Many (N) application threads all share a single kernel thread. The kernel only sees one thread; a user-space library multiplexes N threads on top of it.

- **Pros**: thread creation and switching happens entirely in user space, which is an order of magnitude faster
- **Cons**: if any one of those N threads blocks (e.g., on I/O), the single kernel thread blocks and *all* N threads are stuck — this is the **[[Blocking IO Problem]]**

![[Screenshot 2026-02-09 at 11.38.55 AM.png]]
![[Screenshot 2026-02-09 at 11.38.59 AM.png]]

## Multiple Kernel Threads

We can have multiple kernel threads powering each address space, which reduces (but does not eliminate) the blast radius of one user thread blocking — this middle-ground approach is what **[[Scheduler Activations]]** formalizes with explicit kernel/user-scheduler communication.

![[Screenshot 2026-02-09 at 11.45.36 AM.png]]

## Industry Standard Terms
- **User thread** -> Green thread / fiber / userland thread
- **N:1 scheduling** -> Green threading model / "many-to-one" threading
- **User-level thread library** -> Userland threading runtime (e.g., early Java green threads, Go's earlier goroutine scheduler design before M:N hybrid)

## Related
- [[Thread Levels]]
- [[Kernel Threads]]
- [[User vs Kernel Threads]]
- [[Blocking IO Problem]]
- [[Scheduler Activations]]
