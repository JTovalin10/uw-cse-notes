threads are **concurrent executions sharing an address space (and some OS resources)**
- address spaces provide isolation (if you cant name it then you cant read or write to it)
- communication between processes is expensive
	- must go through the OS to move data from one address space to another
	- typically done via pipes, sockets, shared memory regions (which require syscalls to set up), or message passing
- threads that are in the same address space have cheap communication
	- just update a shared variable
	- use locks to control access
	- no need to cross address space boundaries or involve the OS for data transfer

because threads share the same address space, they can directly read and write the same memory locations. this makes sharing data trivial compared to inter-process communication (IPC), but it also introduces the need for [[Synchronization|synchronization]] to avoid race conditions.

threads within the same process also share:
- open file descriptors
- signal handlers
- working directory
- user and group IDs

what each thread gets privately:
- its own [[CSE451/Processes/CPUState/Stack Pointer]] and stack
- its own [[CSE451/Processes/CPUState/Program Counter]]
- its own set of CPU registers
- its own thread ID
