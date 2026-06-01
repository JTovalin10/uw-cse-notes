# Course: CPU State

The **CPU State** consists of the values held in the CPU registers at a given point in time, which are essential for the execution and resumption of a process.

## Program Counter (PC)
The **Program Counter** (also known as the Instruction Pointer) tells the OS exactly which instruction the process was about to execute next. Without this, the OS wouldn't know where to resume execution after a pause.

## Registers
**Registers** are high-speed storage locations within the CPU. 
> OSTEP: "Many instructions explicitly read or update registers... key among them is the [[#Program Counter (PC)|Program Counter]] (PC)... and the [[#Stack Pointer (SP)|Stack Pointer]] (SP)."

Saving these registers is the core mechanic of a [[#Context Switch]].

## Stack Pointer (SP)
The **Stack Pointer** is a specific CPU register that stores the memory address of the top of the stack. It acts like a bookmark that tells the CPU where the valid data ends and the free space begins.

### How it Moves
On most architectures, the stack grows **downward**:
- **Function Call**: The SP moves down to make room for local variables and the return address.
- **Function Return**: The SP moves up, effectively discarding the local variables and freeing that space.

### Why it is Critical
Without the stack pointer, the program would lose track of where its local variables are and would not know where to return after a function finishes.

## CPU Scheduling Information
This includes info needed by the OS to decide when this process should run:
- Priority level
- Pointers to scheduling queues
- Other implementation-dependent data

## Context Switch
A **Context Switch** is the process of storing the state of a running process and restoring the state of a different, previously suspended process. This creates the illusion of multitasking on a single CPU.

### Steps
1. **Interrupt**: A timer goes off or an I/O request happens, signaling the OS to switch.
2. **Save State**: The OS takes a "snapshot" of the current process and saves the PC, SP, and other registers into its [[Process Control Block|Process Control Block (PCB)]].
3. **Load State**: The OS loads the saved PC, SP, and registers of the next process from its PCB back into the CPU.
4. **Resume**: The CPU begins executing the new process exactly where it left off.

### The Cost
Context switching is **pure overhead**. While the switch is happening, the CPU is performing administrative work rather than running user code. Excessive switching can make a system feel sluggish.

## Related
- [[Process|Process]]
- [[Process State|Process State]]
- [[Interrupts|Interrupts]]
