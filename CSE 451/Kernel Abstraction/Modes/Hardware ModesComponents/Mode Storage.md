# Mode Storage
- on x86 its stored in EFLAGS
	- when thread is running its stored in CPU EFLAGS register
	- when not running (context switched out) its stored in [[Kernel Stack]]
- on MIPS its stored in status register

Process Control Block (PCB) stores this when context switched.
