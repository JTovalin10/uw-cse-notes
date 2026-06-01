# CSE451: Process Control Block

The **Process Control Block (PCB)** is a data structure used by the OS kernel to store all the information about a specific process. You can think of the PCB as the **Identity Card** or the **Medical Record** of a process. It contains exactly the **[[Process#Execution Context|Execution Context]]** and **[[Process#Machine State|Machine State]]**.

Every single process running has its own unique PCB stored in kernel memory.

# What does it contain?
The PCB is a `struct`. Each OS varies but agrees on:
- **[[Process#Process Identification (PID)|Process ID]] (PID)**
- **[[Process State|Process State]]**
- **[[CPU State#Program Counter|Program Counter]]**
- **[[CPU State#Registers|Registers]]**
- **[[CPU State#CPU Scheduling Information|CPU Scheduling Information]]**
- **[[Memory Management Information|Memory Management Information]]**
- **[[IO|I/O Status Information]]**
	- A list of I/O devices allocated to the process and a list of open files.
- **[[Accounting Information|Accounting Information]]**

## Lecture Notes
Lecture agrees on most of these but highlights:
- **Process ID**
- Pointer to parent process
- Execution State
- **Registers**
- Address Space info
- Pointer for state queues

# Why is it important?
It makes **multitasking** possible.

When the OS performs a **[[CPU State#Context Switch|Context Switch]]**, it performs these steps which involve the PCB:
1. **Save**: Saves the current state of the CPU (registers, PC, etc.) into the stopped process's PCB.
2. **Schedule**: It selects the new process to run.
3. **Restore**: It reads the saved state from the new process's PCB and loads it back into the CPU.
