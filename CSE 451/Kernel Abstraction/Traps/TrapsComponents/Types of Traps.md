# Types of traps
1. Intentional (syscall)
	1. the process wants the OS attention
		1. code calls printf which calls write. the process cannot write to the screen directly so it executes a trap to ask the OS to do it
	2. Unintentional (exceptions/faults)
		1. the process did something illegal or nonsensical
			1. ex: divide by zero, access memory you don't own (segfault), or executing an invalid instruction
			2. result
				1. the trap handler for these errors usually kills the process
