# CSE451: How Device Interrupts Work

When a device raises an interrupt, several questions determine how safely and transparently the CPU handles it:

- **Where does the CPU run after an interrupt?**
	- The CPU switches to kernel mode. The [[Interrupt Vector]] is consulted to find the correct interrupt handler, and execution jumps there via [[Atomic Transfer of Control]].
- **What stack does it use?**
	- The CPU switches to the [[Interrupt Stack]] — a per-processor stack located in kernel memory, not the interrupted process's own user stack.
- **Is the work the CPU had been doing before the interrupt lost forever?**
	- No. The interrupted process's execution state is preserved so it can resume exactly where it left off.
- **If not, how does the CPU know how to resume that work?**
	- The CPU saves the program counter and registers before handling the interrupt (onto the interrupt/kernel stack), then restores them afterward once the [[Interrupt Handler]] finishes — this is what provides [[Transparent Restartable Execution]].

## Related
- [[Interrupts|Interrupts]] — the parent concept
- [[Interrupt Handler]] — the code that runs during the interrupt
- [[Interrupt Stack]] — the stack used while handling the interrupt
- [[Interrupt Vector]] — how the CPU finds the correct handler
- [[Atomic Transfer of Control]] — the uninterruptible transition into the handler
- [[Transparent Restartable Execution]] — how the interrupted process resumes without knowing anything happened

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Device Interrupt | Hardware interrupt / IRQ (Interrupt Request) |
