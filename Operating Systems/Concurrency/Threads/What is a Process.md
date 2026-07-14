# CSE451: What Is a Process

A **[[Operating Systems/Virtualization/Processes/Process|process]]** consists of (at least):
- An address space that contains
	- The code (text segment) for the running program
	- The data (global/static variables, heap) for the running program
- Thread state
	- The **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Program Counter (PC)|Program Counter]]** — where in the code the thread is currently executing
	- The **[[Operating Systems/Virtualization/Processes/CPUState/CPU State#Stack Pointer (SP)|Stack Pointer]]** — points to the top of the current execution stack
	- CPU registers — hold intermediate computation values
- Other OS resources
	- Open file descriptors
	- Network connections
	- Signal handlers
	- Process ID (PID)
	- Accounting information (CPU time used, etc.)

A process is the OS's abstraction for a running program. It bundles together an address space with at least one **[[Thread]]** of execution. Without a thread, a process is just an inert container of memory — it is the thread that actually executes instructions. This is the same "unit of resource ownership vs. unit of scheduling" distinction introduced in **[[Key Idea]]**.

## Deep Dive

Because a process is guaranteed to have at least one thread, that first thread is often called the **main thread**. When a program's entry point (e.g., `main()`) begins executing, the OS has already allocated the process's address space and started the main thread running within it. Any additional threads the program creates (see **[[Achieving Multithreading]]**) are siblings of the main thread, sharing the same address space but each getting their own stack and register set, as detailed in **[[Address Space with Threads]]**.

## Industry Standard Terms
- **Process** -> OS process / `task_struct` (Linux) / Process Control Block (PCB)
- **Thread state** -> Thread Control Block (TCB) fields (PC, SP, registers)
- **Address space** -> Virtual Address Space

## Related
- [[Operating Systems/Virtualization/Processes/Process|Process]]
- [[Thread]]
- [[Key Idea]]
- [[Threads and Processes]]
- [[Operating Systems/Processes/Process and Thread Fundamentals]]
