# CSE451: Trap Table

The **Trap Table** is equivalent to the [[Interrupt Vector]] — it is the kernel data structure that maps trap/interrupt numbers to their handler functions.

When a trap fires, the hardware indexes into the trap table to find the address of the appropriate handler code. This ensures controlled entry into the kernel at a limited number of predefined points.

## Related
- [[Interrupt Vector]] — the same concept (the trap table is the interrupt vector)
- [[How Traps Work]] — how the trap table is used during trap handling
- [[System Call]] — uses the trap table to dispatch system call handlers
