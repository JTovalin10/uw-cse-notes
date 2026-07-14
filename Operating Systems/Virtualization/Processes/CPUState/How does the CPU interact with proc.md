# CSE451: How Does the CPU Interact with Proc

When a process is running, its **[[CPU State|CPU State]]** lives inside the physical CPU itself: the [[CPU State#Registers|Registers]] contain the process's current values, and the CPU is actively reading and updating them as instructions execute. This is the "live" half of a process's execution — the other half sits dormant in the process's **proc** (the OS's internal data structure for tracking a process, also called the **[[Process Control Block|Process Control Block (PCB)]]**) whenever the process is not currently running.

## When the OS Gets Control

The OS does not run continuously alongside a user process — it only regains control of the CPU when one of three events occurs:
- **[[Operating Systems/Virtualization/Mechanisms/Traps/Traps|Traps]]**: the program executes a syscall, deliberately asking the OS to do something on its behalf.
- **[[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]]**: the program does something unexpected (e.g., a divide-by-zero or an illegal memory access), forcing the OS to intervene.
- **[[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]]**: a hardware device requests service (e.g., a timer fires, or a disk finishes an I/O operation), asynchronously interrupting whatever the CPU was doing.

## Saving and Restoring State

Whenever one of these events transfers control to the OS, the OS saves the CPU state of the currently running process into that process's proc, so that none of its progress is lost. Later, when the OS returns that process to the running state, it loads the hardware registers back up with the values from that process's proc — the general [[CPU State#Registers|Registers]], the [[CPU State#Stack Pointer (SP)|Stack Pointer]], and the [[CPU State#Program Counter (PC)|Instruction Pointer]] — so the process resumes exactly where it left off, unaware that it was ever paused.

## Context Switch

The act of switching the CPU from one process to another — saving the old process's state out to its proc, and loading a new process's state in from its proc — is called a **[[CPU State#Context Switch|Context Switch]]**. On today's hardware, a single context switch takes only a few microseconds, but systems may perform 100+ of these switches per second, since the CPU is constantly being timeshared across many processes (and, within a process, across many threads — see [[Process vs Thread|Process vs Thread]]).

## Choosing the Next Process

Deciding which process to run next — that is, which proc's saved state gets loaded back into the CPU on the next context switch — is the job of **[[Scheduling|Scheduling]]**. The scheduler examines the [[CPU State#CPU Scheduling Information|CPU Scheduling Information]] stored in each process's [[Process Control Block|PCB]] (priority, position in the [[State Queues|state queues]], etc.) to make this decision.

## Related
- [[CPU State|CPU State]]
- [[Process Control Block|Process Control Block]]
- [[Scheduling|Scheduling]]
- [[Operating Systems/Virtualization/Mechanisms/Traps/Traps|Traps]]
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]]
- [[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]]
- [[State Queues|State Queues]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| proc | Process Control Block (PCB) / task_struct (Linux) |
| Trap | Software interrupt / syscall trap |
