# User Threads

Cheap and good for common-case operations, but suffer in uncommon cases due to kernel obliviousness.

- Threading can be implemented entirely in user space
- Each thread keeps a separate stack and processor context in user space
- A user-level thread library handles scheduling and switching

## Context Switching

Library saves running thread's processor context → picks a new thread to run → restores its context and jumps to the saved PC
(Same flow as the kernel, but no kernel involvement)

## N:1 Scheduling

Many (N) application threads all share a single kernel thread. The kernel only sees one thread; a user-space library multiplexes N threads on top of it.

- **Pros:** thread creation and switching happens entirely in user space, which is an order of magnitude faster
- **Cons:** if any one of those N threads blocks (e.g., on I/O), the single kernel thread blocks and *all* N threads are stuck — this is the [[Blocking IO Problem]]

![[Screenshot 2026-02-09 at 11.38.55 AM.png]]
![[Screenshot 2026-02-09 at 11.38.59 AM.png]]

## Multiple Kernel Threads

We can have multiple kernel threads powering each address space.

![[Screenshot 2026-02-09 at 11.45.36 AM.png]]
