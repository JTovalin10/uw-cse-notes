# Key idea
separate the concept of a process from that of a minimal "thread of control" (execution state: stack, stack pointer, program counter, registers). this execution state is usually called a **thread** or a **lightweight process (LWP)**.

historically, the process was both the unit of resource ownership (address space, files) and the unit of scheduling (what the CPU runs). the key insight is to decouple these two roles:

- **process** = unit of resource ownership
	- owns the address space
	- owns open files, sockets, and other OS resources
	- acts as a container
- **thread** = unit of scheduling / execution
	- has its own stack, program counter, and registers
	- is what the CPU actually runs
	- can be independently scheduled

this separation means:
- you can have multiple threads of execution within a single resource container (process)
- creating a new thread is cheap because you don't need to duplicate the address space
- switching between threads in the same process is cheap because you don't need to swap page tables

this is the fundamental design principle behind modern multithreaded operating systems (Linux, Windows, macOS all follow this model).
