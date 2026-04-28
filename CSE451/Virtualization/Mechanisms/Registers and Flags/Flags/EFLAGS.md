# CSE451: EFLAGS

**EFLAGS** stands for the **Extended FLAGS register**. It is a special-purpose x86 register that contains **status flags** and **control flags** about the CPU's current state.

## Components
- [[Status Flags]] — carry, zero, sign, overflow, parity flags
- [[Control Flags]] — interrupt flag (IF), direction flag (DF), trap flag (TF)

## Relevance to the OS
- The **current privilege mode** (user vs. kernel) is stored in EFLAGS when a thread is running
- When a thread is context-switched out, its EFLAGS is saved on the [[Kernel Stack]]

## Related
- [[IF]] — the interrupt enable bit within EFLAGS
- [[CLI]] / [[STI]] — instructions that modify the interrupt flag
- [[Mode Storage]] — details on where mode information is stored
- [[General Purpose Registers]] — other x86 registers
