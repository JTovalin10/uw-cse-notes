# CSE451: User Mode

**User mode** is the CPU's restricted execution state in which ordinary application code runs.

- Cannot directly access hardware
- Cannot execute [[Privileged Instructions]]
- Must use [[System Call|system calls]] for privileged operations
- Memory access is restricted to the process's own virtual address space (enforced by page tables)

Contrast with [[Kernel Mode]], which has no such restrictions.

## Related
- [[Kernel Mode]] — the privileged counterpart
- [[Hardware Modes]] — the parent concept
- [[Ring 3]] — the x86 privilege ring corresponding to user mode
- [[System Call]] — how user-mode code requests privileged operations
- [[General Protection Fault (GPF)]] — raised when user mode violates restrictions
