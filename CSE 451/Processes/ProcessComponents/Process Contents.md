- A process consists of (at least)
	- An address space containing
		- the code (instructions) for the running program
		- the data for the running program (static data, heap, stack)
	- (At least one) CPU state, consisiting of
		- The EIP, indicating the next instruction
		- the stack pointer (ESP)
		- other general purpose register values
	- A set of OS resources
		- open files, network connection, sounds channels,...

# Key Components
- **[[Process Control Block]]**: OS data structure storing process state
- **[[Execution Context]]**: CPU state needed to resume execution
- **Address Space**: Virtual memory assigned to the process
