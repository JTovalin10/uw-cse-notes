# CSE451: Interrupts

**Interrupts** are signals that pause the CPU to handle urgent events, which are ideally hidden from the user.

Note: interrupts can be temporarily deferred by the kernel — this is crucial for implementing mutual exclusion (mutex). See [[Interrupt Masking]].

Interrupts fix the problem of Polling by letting devices notify the CPU rather than having the CPU constantly check device status.

## Components
- [[Source of Interrupts]] — timer, I/O devices, software, exceptions
- [[How Device Interrupts Work]] — where the CPU runs, what stack it uses, how work is preserved
- [[Safe Interrupts]] — interrupt vector, atomic transfer, transparent restartable execution
- [[Interrupt Types Summary]] — hardware, software (trap), and exception types
- [[Interrupt Timeout]] — what happens if an interrupt handler runs too long

## Interrupt Stack
The interrupt stack is a **per-processor stack located in kernel memory**. Usually a process/thread has both a kernel and a user stack.

The interrupt handler cannot run on the stack of the interrupted user process because the user stack may be corrupted.

![[Screenshot 2026-01-05 at 4.21.13 PM.png]]

## Related
- [[Interrupt Handler]] — the code that runs when an interrupt fires
- [[Interrupt Vector]] — the table of function pointers for interrupt dispatch
- [[Interrupt Masking]] — how the OS temporarily disables interrupts
- [[Interrupt Stack]] — detailed note on the interrupt stack
- [[Traps]] — software-initiated counterpart to hardware interrupts
- [[CLI]] / [[STI]] — x86 instructions to disable/enable interrupts
- [[CSE351/System Programming/Exceptions]] — exceptions at the systems programming level
