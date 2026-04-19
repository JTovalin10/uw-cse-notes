# CSE451: Interrupt Vector

An **interrupt vector** (or **Interrupt Descriptor Table, IDT**) is an array of function pointers that tells the CPU where to jump when an interrupt fires.

This creates safety through **controlled entry points** — the user process cannot jump to arbitrary kernel addresses; it can only reach the predefined handlers.

![[Screenshot 2026-01-07 at 12.00.18 PM.png]]

## Security
The interrupt vector contains a checksum so that a malicious actor cannot redirect it to their own code.

## Related
- [[Interrupts]] — what uses the interrupt vector for dispatch
- [[Trap Table]] — similar concept for traps/syscalls
- [[Safe Interrupts]] — the interrupt vector is one of the three elements of safe interrupt handling
- [[Interrupt Handler]] — the functions the vector points to
