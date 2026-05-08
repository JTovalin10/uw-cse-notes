# Course: CSE451 - Processes

A process is an **abstraction** provided by the OS that encapsulates a running program.

## Formal Definition
OSTEP: A process is an **abstraction** provided by the OS that encapsulates:
- The program code (text segment)
- Current activity (program counter, registers)
- Memory (stack, heap, data segments)
- OS resources (open files, network connections)

## Process vs Program
| Program | Process |
|---------|---------|
| Static code on disk | Dynamic execution in memory |
| One copy | Multiple instances possible |
| Passive | Active |

## Process Identification (PID)
A **Process ID (PID)** is a unique number (like SSN) that distinguishes this process from all others.
- The name for a process is called a process ID (PID).
- It is typically an integer.
- The PID namespace is global to the system; only one process at a time has a particular PID.
- Operations that create processes (e.g., `fork`) return a PID.
- Operations on processes take PIDs as an argument (e.g., `kill`, `wait`, `nice`).

## Process Contents
A process consists of (at least):
- **An address space** containing:
    - The code (instructions) for the running program.
    - The data for the running program (static data, heap, stack).
- **CPU state** (at least one), consisting of:
    - The EIP (Program Counter), indicating the next instruction.
    - The Stack Pointer (ESP).
    - Other general-purpose register values.
- **A set of OS resources**:
    - Open files, network connections, sound channels, etc.

### Process's Address Space (idealized)
![[Pasted image 20260116002309.png]]

## Execution Context
**Execution Context** refers to the dynamic parts of a running program. For example, if we were to "freeze" a program in the middle of a calculation, the execution context is exactly what we need to save to resume it later without the program knowing it stopped.

### Examples
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Program Counter (PC)|Program Counter]]
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Registers|Registers]]
- [[CSE451/Virtualization/Mechanisms/Memory/Virtual Addresses|Virtual Addresses]]
- **OS Resources**: If the process was writing to a file, the OS needs to remember which file was open and the current position of the "cursor" in that file (file descriptor).

## Machine State
Machine state can be broken down into three categories:
1. **Memory** (the Address Space)
2. **Registers** (the CPU State)
3. **I/O Information**

## Related
- [[CSE451/Virtualization/Processes/Process/Process State|Process State]]
- [[CSE451/Virtualization/Processes/Process/Process Control Block|Process Control Block]]
- [[CSE451/Virtualization/Processes/CPUState/CPU State|CPU State]]
- [[CSE451/Virtualization/Processes/CPUState/CPU State#Context Switch|Context Switch]]
- [[CSE333/Process Management/Process Management|CSE333: Process Management]]
- [[CSE451/Virtualization/Memory/Concepts/Virtual Addresses]]
- [[Optimizing Fork]]
