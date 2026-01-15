# What is it
a specific type of [[Interrupts]] caused by the program currently running

You can think of a trap as a formal request for help or an alarm triggered by the process itself. it is the mechanism a process uses to tell the OS "i need you to do something im not allowed to do" or "I made a mistake"

# Core purpose
the trap is a doorway between [[Mode Switch]] where a process running in user mode can execute a special trap instruction to do kernel mode code

# How it works
1. the trigger
	1. the process executes a special instruction (syscall) or causes an error (divide by zero)
2. the trap
	1. the hardware detects this, pauses the process, and raises the privilege level from user to kernel
3. the Handler
	1. the hardware loops up a pre-defined location called the [[Trap Table]] or [[Interrupt Vector]] Table to find the code responsible for handling this specific event (the trap handler)
4. The action
	1. the os executes the trap handler code (performs the file read or kills the crashing process)
5. return-from-trap
	1. if the process is allowed to continue, the OS executes a speical ```return-from-trap``` instruction, which lowers the priviledge back to user mode and resumes the process exactly where it left off
# Types of traps
1. Intentional (syscall)
	1. the process wants the OS attention
		1. code calls printf which calls write. the process cannot write to the screen directly so it executes a trap to ask the OS to do it
	2. Unintentional (exceptions/faults)
		1. the process did something illegal or nonsensical
			1. ex: divide by zero, access memory you down own (segfault), or executing an invalid instruction
			2. result
				1. the trap handler for these rrors usually kills the process
# Trap vs [[Interrupts]]
- trap
	- caused by software
	- is synchronous as happens at a specific line of code
- interrupt
	- caused by external device
	- can happen at any time