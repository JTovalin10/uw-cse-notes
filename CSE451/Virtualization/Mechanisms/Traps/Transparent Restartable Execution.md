# CSE451: Transparent Restartable Execution

**Transparent restartable execution** means that the user program does not know an interrupt or trap occurred. After the kernel handles the event, the user program resumes exactly where it left off.

This is one of the three requirements for [[Safe Interrupts]].

## How It Works
The kernel saves the complete execution state of the user program (registers, program counter, stack pointer) before handling the interrupt, then restores that state before returning to user mode. The user program sees no discontinuity.

## Related
- [[Safe Interrupts]] — transparent restartable execution is one of three safety requirements
- [[Atomic Transfer of Control]] — the complementary mechanism for entering the kernel
- [[Interrupt Handler]] — the end of the handler atomically restores state and returns
- [[Context Switch]] — related concept for process switching
