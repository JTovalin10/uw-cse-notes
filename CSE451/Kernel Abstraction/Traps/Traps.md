# CSE451: Traps

A **trap** is a specific type of [[Interrupts|interrupt]] caused by the program currently running.

You can think of a trap as a formal request for help or an alarm triggered by the process itself. It is the mechanism a process uses to tell the OS "I need you to do something I'm not allowed to do" or "I made a mistake."

## Core Purpose
The trap is a **doorway into kernel mode**, through which a process running in user mode can execute a special trap instruction to run kernel mode code.

## Components
- [[How Traps Work]] — the five-step sequence from trigger to return-from-trap
- [[Types of Traps]] — intentional (syscall) vs. unintentional (exception/fault)
- [[Trap vs Interrupt]] — software-triggered and synchronous vs. external and asynchronous

## Related
- [[Interrupts]] — hardware-triggered counterpart
- [[System Call]] — the most common intentional trap
- [[Exception]] — unintentional trap caused by program error
- [[Trap Table]] — the dispatch table for trap handlers
- [[Atomic Transfer of Control]] — the hardware mechanism used during trap entry
- [[Transparent Restartable Execution]] — the illusion maintained after a trap
