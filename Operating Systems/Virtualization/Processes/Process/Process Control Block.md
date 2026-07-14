# CSE451: Process Control Block

The **Process Control Block (PCB)** is a data structure used by the OS kernel to store all the information about a specific [[Process|process]]. You can think of the PCB as the **Identity Card** or the **Medical Record** of a process — it is exactly the "proc" data structure referenced throughout these notes (see [[Sequential Process And what is Proc|Sequential Process and What Is a Proc]] and [[Process Lifecycle Events|Process Lifecycle Events]]). It contains exactly the **[[Process#Execution Context|Execution Context]]** and **[[Process#Machine State|Machine State]]** of that process.

Every single process running has its own unique PCB stored in kernel memory. This is what the OS allocates when a process is created, and deallocates once the process has fully terminated (see [[Process Lifecycle Events|Process Lifecycle Events]]).

## What Does It Contain?

The PCB is a `struct`. Each OS varies in its exact fields, but they generally agree on:
- **[[Process#Process Identification (PID)|Process ID]] (PID)**
- **[[Process State|Process State]]**
- **[[CPU State#Program Counter (PC)|Program Counter]]**
- **[[CPU State#Registers|Registers]]**
- **[[CPU State#CPU Scheduling Information|CPU Scheduling Information]]**
- **Memory Management Information**: page table pointers and address space bookkeeping.
- **I/O Status Information**: a list of I/O devices allocated to the process and a list of open files.
- **Accounting Information**: CPU time used, time limits, and similar bookkeeping used for scheduling and resource accounting.

### Lecture Terminology

Lecture agrees on most of these but highlights specifically:
- **Process ID**
- Pointer to parent process
- Execution State
- **Registers**
- Address Space info
- Pointer for state queues (see [[State Queues|State Queues]])

## Why Is It Important?

The PCB is what makes **multitasking** possible: because every process's execution context is fully captured in its own PCB, the OS can pause any process at any point and later resume it with no loss of correctness, simply by saving and restoring the PCB's contents.

When the OS performs a **[[CPU State#Context Switch|Context Switch]]**, it performs these steps, each of which directly involves the PCB:
1. **Save**: Saves the current state of the CPU (registers, PC, etc.) into the stopped process's PCB.
2. **Schedule**: The [[Scheduling|scheduler]] selects the new process to run, typically based on the [[CPU State#CPU Scheduling Information|CPU Scheduling Information]] stored in each candidate process's PCB.
3. **Restore**: The OS reads the saved state from the new process's PCB and loads it back into the CPU, so the newly-scheduled process resumes exactly where it left off.

## Related
- [[Process|Process]]
- [[CPU State|CPU State]]
- [[CPU State#Context Switch|Context Switch]]
- [[Process State|Process State]]
- [[State Queues|State Queues]]
- [[Scheduling|Scheduling]]
- [[Sequential Process And what is Proc|Sequential Process and What Is a Proc]]
- [[Process Lifecycle Events|Process Lifecycle Events]]
- [[Representation of processes by the OS|Representation of Processes by the OS]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Process Control Block (PCB) / proc | task_struct (Linux) / Task Control Block |

