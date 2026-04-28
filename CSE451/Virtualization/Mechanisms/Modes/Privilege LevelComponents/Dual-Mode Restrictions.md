# CSE451: Dual-Mode Restrictions

Dual-mode operation enforces security and stability through three hardware mechanisms:

## 1. Privileged Instructions
Available only to kernel mode (Ring 0), not to user code. See [[Privileged Instructions]].

## 2. Limits on Memory Accesses
- Prevents user code from overwriting the kernel
- Prevents user code from reading data it is not authorized to access
- Enforced by base/bound registers or page tables

## 3. Timer
- Allows the OS to regain control from a user program that loops indefinitely
- The timer fires a hardware interrupt that returns control to the kernel

**Together, these three mechanisms provide a safe way to switch from user mode to kernel mode and back.**

## Related
- [[Privilege Level]] — the parent concept
- [[Privileged Instructions]] — the restricted instruction set
- [[Base and Bounds]] — one mechanism for memory access limits
- [[CSE451/Kernel Abstraction/Memory/Virtual Addresses]] — paging-based memory protection
- [[Interrupts]] — how the timer interrupt reclaims control
