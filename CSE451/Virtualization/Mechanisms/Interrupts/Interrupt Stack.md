# CSE451: Interrupt Stack

The **interrupt stack** is a per-processor stack located in kernel (not user) memory. Usually a process/thread has both a kernel stack and a user stack.

## Why not use the user stack?

The interrupt handler cannot run on the interrupted user process's stack because the user stack may be corrupted. Using a separate, kernel-owned stack ensures safe, isolated execution of interrupt handling code.

![[Screenshot 2026-01-07 at 12.01.34 PM.png]]

## Related
- [[Interrupts]] — what causes the switch to the interrupt stack
- [[Interrupt Handler]] — the code that runs on this stack
- [[Kernel Stack]] — the related per-process kernel stack
