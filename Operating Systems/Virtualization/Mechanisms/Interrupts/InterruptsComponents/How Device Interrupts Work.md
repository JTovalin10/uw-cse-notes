# How do Device Interrupts work?
- where does the CPU run after an interrupt
	- kernel
- what stack does it use
	- kernel stack
- is the work the CPU had been doing before the interrupt lost forever
	- no
- if not, how does the CPU know how to resume that work
	- The CPU saves the program counter and registers before handling the interrupt, then restores them afterward
