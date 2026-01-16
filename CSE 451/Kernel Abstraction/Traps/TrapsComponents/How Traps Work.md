# How Traps Work
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
