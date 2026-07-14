# CSE451: CPU State

The **CPU State** consists of the values held in the CPU registers at a given point in time, which are essential for the execution and resumption of a **[[Process|Process]]**. Whenever the OS needs to pause a process and later resume it exactly where it left off, the CPU State is precisely the information that must be preserved.

## Program Counter (PC)
The **Program Counter (PC)** (also known as the Instruction Pointer) tells the OS exactly which instruction the process was about to execute next. Without this, the OS wouldn't know where to resume execution after a pause.

## Registers
**Registers** are high-speed storage locations within the CPU.
> OSTEP: "Many instructions explicitly read or update registers... key among them is the [[#Program Counter (PC)|Program Counter]] (PC)... and the [[#Stack Pointer (SP)|Stack Pointer]] (SP)."

Saving these registers is the core mechanic of a [[#Context Switch|Context Switch]].

## Stack Pointer (SP)
The **Stack Pointer (SP)** is a specific CPU register that stores the memory address of the top of the stack. It acts like a bookmark that tells the CPU where the valid data ends and the free space begins.

### How it Moves
On most architectures, the stack grows **downward**:
- **Function Call**: The SP moves down to make room for local variables and the return address.
- **Function Return**: The SP moves up, effectively discarding the local variables and freeing that space.

### Why it is Critical
Without the stack pointer, the program would lose track of where its local variables are and would not know where to return after a function finishes. Together, the PC and SP form the minimum information the CPU needs to keep executing a program's instruction stream correctly — this is why both are saved and restored on every [[#Context Switch|Context Switch]].

## CPU Scheduling Information
This includes info needed by the OS to decide when this process should run:
- Priority level
- Pointers to scheduling queues (see [[State Queues|State Queues]])
- Other implementation-dependent data

This scheduling information lives alongside the PC, SP, and registers inside the process's **[[Process Control Block|Process Control Block (PCB)]]**, and is consulted whenever the **[[Scheduling|Scheduler]]** decides which process runs next.

## Context Switch
A **Context Switch** is the process of storing the state of a running process and restoring the state of a different, previously suspended process. This creates the illusion of multitasking on a single CPU — from the perspective of any individual process, it looks as though it has the CPU entirely to itself, even though the CPU is really being timeshared among many processes.

### Steps
1. **Interrupt**: A timer goes off or an I/O request happens, signaling the OS to switch (see [[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]]).
2. **Save State**: The OS takes a "snapshot" of the current process and saves the PC, SP, and other registers into its [[Process Control Block|Process Control Block (PCB)]].
3. **Load State**: The OS loads the saved PC, SP, and registers of the next process from its PCB back into the CPU.
4. **Resume**: The CPU begins executing the new process exactly where it left off, unaware that it was ever paused.

### The Cost
Context switching is **pure overhead**. While the switch is happening, the CPU is performing administrative work (saving and restoring register state) rather than running user code. Excessive switching can make a system feel sluggish, since cycles spent context switching are cycles not spent making forward progress on any process's actual work. This overhead is a central trade-off in [[Scheduling|CPU Scheduling]] policy — for example, the choice of time-slice length in [[Scheduling#3. Round Robin (RR)|Round Robin]] directly weighs context switch cost against responsiveness.

## Deep Dive
On real hardware, a context switch is more than just swapping the PC, SP, and general-purpose registers. On architectures with per-process address spaces, the OS must also update the page table base register (e.g., `CR3` on x86) to point at the new process's page tables, which can trigger a flush or partial invalidation of the **Translation Lookaside Buffer (TLB)** — this is part of why switching between processes is more expensive than switching between threads of the same process, since threads share an address space and thus share page tables and TLB entries (see [[Process vs Thread|Process vs Thread]]).

## Related
- [[Process|Process]]
- [[Process State|Process State]]
- [[Operating Systems/Virtualization/Mechanisms/Interrupts/Interrupts|Interrupts]]
- [[Process Control Block|Process Control Block]]
- [[Scheduling|Scheduling]]
- [[State Queues|State Queues]]
- [[How does the CPU interact with proc|How does the CPU interact with proc]]
