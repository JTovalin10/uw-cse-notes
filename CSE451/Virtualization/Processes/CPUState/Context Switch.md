# What is it
A **Context Switch** is the process of storing the state and restoring the state of a different, previously suspended process

This creates an illusion where a single CPU appears to be doing 100 things at once (multitasking)

# Steps
1. [[Interrupts]]
	1. a timer goes off (or a I/O request happens) telling the OS its time to switch
2. Save State: the OS takes a "snapshot" of the currently running process and saves
	1. the [[CSE451/Processes/CPUState/Program Counter]]
	2. [[CSE451/Processes/CPUState/Stack Pointer]]
	3. [[Registers]]
	4. this data is stored in the [[Process Control Block]] (PCB)
3. Load State: the OS looks at the PCB of the next process in line. It loads that process's saved PC, SP, and registers back into the CPU
4. Resume: the CPU begins executing the new process exactly where it left off
# The Cost
Context switching is **pure overhead**. While the switch is happening, the CPU is doing admin work, not running user code. If an OS switches too frequently, the system becomes sluggish