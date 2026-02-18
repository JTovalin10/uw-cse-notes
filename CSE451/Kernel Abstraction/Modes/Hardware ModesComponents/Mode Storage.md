# Mode Storage
- on x86 it's stored in EFLAGS
	- when a thread is running, it's stored in the CPU EFLAGS register
	- when not running (context switched out), it's stored in [[Kernel Stack]]
- on MIPS its stored in status register

Process Control Block (PCB) stores this when context switched.
