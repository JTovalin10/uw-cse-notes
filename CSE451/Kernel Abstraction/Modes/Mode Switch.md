high level:

# Kernel to User
1. new process/thread start
	1. jump to first instruction in program/thread
2. return from interrupt, exception, system call
	1. resume suspended execution
3. process/thread context switch
	1. resume some other process
4. user-level upcall (UNIX signal)
	1. async notification to user program
	2. - Example:
	- user types control + c, it will call an interrupt and execute the code

# User to Kernel
- [[Interrupts]]
- [[CSE351/System Programming/Exceptions]]
- [[System Call]] (protected procedure call or a trap)
