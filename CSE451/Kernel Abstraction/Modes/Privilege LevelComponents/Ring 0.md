# CSE451: Ring 0 (Kernel Mode)

**Ring 0** is the most privileged CPU execution mode. It corresponds to [[Kernel Mode]].

- Full access to everything
- Can execute [[Privileged Instructions]] (e.g., `cli` to disable interrupts, `hlt` to halt the CPU)
- Can access all memory, including kernel memory
- Can directly access hardware/I/O ports
- Can modify page tables, interrupt handlers, and other protected structures

## Related
- [[Ring 3]] — the least privileged ring (user mode)
- [[Privilege Level]] — the parent concept
- [[Kernel Mode]] — the OS-level concept corresponding to Ring 0
