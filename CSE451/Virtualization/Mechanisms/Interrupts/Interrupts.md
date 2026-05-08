# Course: Interrupts

**Interrupts** are signals that pause the CPU to handle urgent events, which are ideally hidden from the user. They fix the problem of **Polling** by letting devices notify the CPU rather than having the CPU constantly check device status.

> Note: Interrupts can be temporarily deferred by the kernel — this is crucial for implementing mutual exclusion (mutex). See [[Interrupt Masking]].

## Components
- [[Source of Interrupts]] — timer, I/O devices, software, exceptions
- [[How Device Interrupts Work]] — where the CPU runs, what stack it uses, how work is preserved
- [[#Safe Interrupts]] — interrupt vector, atomic transfer, transparent restartable execution
- [[Interrupt Types Summary]] — hardware, software (trap), and exception types
- [[#Interrupt Timeout]] — what happens if an interrupt handler runs too long

## Safe Interrupts
To ensure interrupts are handled safely, the OS uses:
- **[[Interrupt Vector]]**: A table of function pointers for interrupt dispatch.
- **[[Atomic Transfer of Control]]**: Ensures the transition to the handler is uninterruptible.
- **[[Transparent Restartable Execution]]**: Ensures the interrupted process can resume without error.

## Interrupt Stack
The interrupt stack is a **per-processor stack located in kernel memory**. Usually, a process/thread has both a kernel and a user stack.

The interrupt handler cannot run on the stack of the interrupted user process because the user stack may be corrupted or inaccessible.

![[Screenshot 2026-01-05 at 4.21.13 PM.png]]

## Interrupt Timeout
What happens if an interrupt handler runs too long?
- It depends on how the OS is configured.
- Data held by a device might be lost or remain pending if the OS takes too long to respond.

## Related
- [[Interrupt Handler]] — the code that runs when an interrupt fires
- [[Interrupt Vector]] — the table of function pointers for interrupt dispatch
- [[Interrupt Masking]] — how the OS temporarily disables interrupts
- [[Traps]] — software-initiated counterpart to hardware interrupts
- [[CLI]] / [[STI]] — x86 instructions to disable/enable interrupts
- [[CSE351/System Programming/Exceptions]] — exceptions at the systems programming level
