# CSE451: Interrupt Masking

**Interrupt masking** allows the OS to temporarily disable interrupt processing.

- The [[Interrupt Handler]] runs with interrupts off; they are re-enabled when the handler completes
- The OS kernel can also turn [[Interrupts]] off directly:
	- Example: when determining the next process/thread to run
	- On x86 this is only permitted in kernel mode:
		- [[CLI]]: disables maskable interrupts
		- [[STI]]: enables interrupts
		- Only applies to the current CPU (on a multicore machine)

## When Another Device Interrupts During Masking
If another device raises an interrupt while interrupts are masked, the interrupt is latched. When interrupts are re-enabled, the handler sees it and takes action.

## Related
- [[Interrupts]] — the mechanism being masked
- [[CLI]] — x86 instruction to disable interrupts
- [[STI]] — x86 instruction to enable interrupts
- [[IF]] — the interrupt flag bit in EFLAGS
- [[Disabling Interrupts]] — using this as a synchronization mechanism
