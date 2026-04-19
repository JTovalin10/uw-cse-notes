# CSE451: Interrupt Handler

An **interrupt handler** (also called an **Interrupt Service Routine, ISR**) is the kernel code that executes when an interrupt fires. It is often part of a device driver.

## Key Properties
- **Non-blocking** — runs to completion with all interrupts turned off
	- Any expensive actions should be done without a mutex; acquire the lock only for the critical update
	- Minimum necessary work to allow the device to take the next interrupt
	- Any waiting must be of limited duration
- Wakes up another thread to do the real work
	- Linux: uses a semaphore
- The rest of the device driver runs as a kernel thread

## End of Interrupt Handler
1. Handler restores saved registers
2. Atomically returns to the interrupted process/thread:
	- Restores the program counter, stack, and status word/condition codes
	- Switches back to user mode

## Related
- [[Interrupts]] — what triggers the handler
- [[Interrupt Vector]] — the dispatch table that maps interrupts to handlers
- [[Interrupt Masking]] — interrupts are disabled while the handler runs
- [[Interrupt Stack]] — the stack the handler runs on
