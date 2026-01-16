# What is it
it is a data structure used by the OS kernel to store all the information about a specific process. you can think of the PCB as the **Identity Card** or the **Medical Record** of a process. it contains exactly the [[Execution Context]] and [[Machine State]]

Every single process running has its own unique PCB stored in kernel memory

# What does it contain
the PCB is a struct. each os varies but agrees on:
- [[Process ID]] (PID)
- [[Process State]]
- [[Program Counter]]
- [[Registers]]
- [[CPU Scheduling Information]]
- [[Memory Management Information]]
- [[IO]] Status information
	- A list of I/O devices allocated to the process and a list of open files
- [[Accounting Information]]
## Lecture
Lecture agrees on most of these but syas
- [[Process ID]]
- Pointer to parent proc
- Execution State
- [[Registers]]
- Address Space info
- pointer for state queues
# Why is it important
it makes **multitasking** possible

When the OS performs a [[Context Switch]], it performs these steps which involve the PCB
1. Save
	1. saves the current state of the CPU (registers, PC etc) into the stopped process PCB
	2. schedule
		1. it selects the new process to run
	3. restore
		1. it reads the saved state from the new process PCB and loads it back into the CPU
