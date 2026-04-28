# CSE451: Mode Storage

The CPU's current privilege mode needs to be stored somewhere so the hardware can check it on every instruction.

## Where Mode is Stored
- **x86**: stored in [[EFLAGS]]
	- When a thread is running, the mode is in the CPU's EFLAGS register
	- When the thread is context-switched out, it is stored in the [[Kernel Stack]]
- **MIPS**: stored in the status register

The [[Process Control Block]] (PCB) stores this when the process is context-switched.

## Related
- [[Hardware Modes]] — the modes being stored
- [[EFLAGS]] — the x86 register that holds mode
- [[Kernel Stack]] — where mode is saved on context switch
- [[Process Control Block]] — the OS data structure that persists mode information
