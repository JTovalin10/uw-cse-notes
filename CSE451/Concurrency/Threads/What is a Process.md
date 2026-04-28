# What is a process
a process consists of (at least):
- an address space that contains
	- the code (text segment) for the running program
	- the data (global/static variables, heap) for the running program
- thread state
	- the [[CSE451/Processes/CPUState/Program Counter]] - where in the code the thread is currently executing
	- the [[CSE451/Processes/CPUState/Stack Pointer]] - points to the top of the current execution stack
	- CPU registers - hold intermediate computation values
- other OS resources
	- open file descriptors
	- network connections
	- signal handlers
	- process ID (PID)
	- accounting information (CPU time used, etc.)

a process is the OS's abstraction for a running program. it bundles together an address space with at least one thread of execution. without a thread, a process is just an inert container of memory - it is the thread that actually executes instructions.

see also: [[Process|Process]]
