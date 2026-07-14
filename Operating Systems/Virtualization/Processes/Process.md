# CSE451: Process

A **[[Process|Process]]** is an **abstraction** provided by the OS that encapsulates a running program. This is the OS's fundamental unit for representing an active, executing computation — as opposed to the program itself, which is just static code sitting passively on disk.

## Process vs Program

| Program | Process |
|---------|---------|
| Static code on disk | Dynamic execution in memory |
| One copy | Multiple instances possible |
| Passive | Active |

The same program can be launched multiple times, producing multiple independent processes — each with its own copy of the process abstraction described below, even though they all execute the same underlying code. This distinction (dynamic execution context vs. static bytes) is elaborated further in [[Sequential Process And what is Proc|Sequential Process and What Is a Proc]].

## Process Identification (PID)

A **Process ID (PID)** is a unique number (like a Social Security Number) that distinguishes this process from all others on the system.
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
- **[[CPU State|CPU state]]** (at least one), consisting of:
    - The EIP (Program Counter), indicating the next instruction.
    - The Stack Pointer (ESP).
    - Other general-purpose register values.
- **A set of OS resources**:
    - Open files, network connections, sound channels, etc.

### Process's Address Space (idealized)
![[Pasted image 20260116002309.png]]

## Execution Context

**Execution Context** refers to the dynamic parts of a running program. For example, if we were to "freeze" a program in the middle of a calculation, the execution context is exactly what we need to save to resume it later without the program knowing it stopped. This is precisely the information a **[[Process Control Block|Process Control Block (PCB)]]** stores on behalf of a paused process, and precisely what gets saved and restored during a **[[CPU State#Context Switch|Context Switch]]**.

### Examples
- [[CPU State#Program Counter (PC)|Program Counter]]
- [[CPU State#Registers|Registers]]
- [[Operating Systems/Virtualization/Mechanisms/Memory/Virtual Addresses|Virtual Addresses]]
- **OS Resources**: If the process was writing to a file, the OS needs to remember which file was open and the current position of the "cursor" in that file (file descriptor).

## Machine State

Machine state — the full set of information that fully determines a process's current behavior — can be broken down into three categories:
1. **Memory** (the Address Space)
2. **Registers** (the [[CPU State|CPU State]])
3. **I/O Information**

Together, the [[#Execution Context|Execution Context]] and Machine State are exactly what the OS must save into a process's **[[Process Control Block|Process Control Block (PCB)]]** whenever that process is not currently running, and restore from the PCB whenever it is scheduled to run again — see [[How does the CPU interact with proc|How does the CPU interact with proc]] for the mechanics of that save/restore cycle.

## Formal Definition
OSTEP: A process is an **abstraction** provided by the OS that encapsulates:
- The program code (text segment)
- Current activity (program counter, registers)
- Memory (stack, heap, data segments)
- OS resources (open files, network connections)

## Simplified Explanation
A process is "a program, actually running." The program on disk is just bytes — instructions and data sitting there doing nothing. The moment the OS loads it, gives it memory, and starts executing its instructions, it becomes a process: something with a current position (program counter), a private scratch space (stack/heap), and a set of things it's allowed to touch (open files, resources).

## Related
- [[Process State|Process State]]
- [[Process Control Block|Process Control Block]]
- [[CPU State|CPU State]]
- [[CPU State#Context Switch|Context Switch]]
- [[Sequential Process And what is Proc|Sequential Process and What Is a Proc]]
- [[Process vs Thread|Process vs Thread]]
- [[How does the CPU interact with proc|How does the CPU interact with proc]]
- [[Systems Programming/Process Management/Process Management|CSE333: Process Management]]
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]]
- [[Optimizing Fork|Optimizing Fork]]

## Industry Standard Terms
| Course Term | Industry-Standard Equivalent |
|---|---|
| Process | OS process / task |
| PID | Process ID |

