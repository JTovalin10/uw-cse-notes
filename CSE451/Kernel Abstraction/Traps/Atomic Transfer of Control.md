# CSE451: Atomic Transfer of Control

**Atomic transfer of control** is the hardware mechanism that transitions from user mode to kernel mode in a single, uninterruptible step. It is one of the three requirements for [[Safe Interrupts]].

The single atomic instruction simultaneously changes:
- **Program counter** — jumps to the kernel handler
- **Stack pointer** — switches to the kernel stack
- **Memory protection** — updates to kernel address space
- **Kernel/user mode** — elevates privilege from user to kernel

All four transitions happen together, ensuring no partial state exists where the CPU is partially in user mode and partially in kernel mode.

## Related
- [[Traps]] — traps use atomic transfer of control to enter the kernel
- [[Interrupts]] — interrupts also use atomic transfer
- [[Safe Interrupts]] — atomic transfer is one of three safety requirements
- [[Transparent Restartable Execution]] — the complementary mechanism for returning to user mode
- [[Mode Switch]] — the general concept of switching between user and kernel mode
