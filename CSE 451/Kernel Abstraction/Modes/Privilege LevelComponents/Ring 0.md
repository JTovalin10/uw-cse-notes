# Ring 0 (Kernel Mode)
- Full access to everything
- Can execute privileged instructions (like `cli` to disable interrupts, `hlt` to halt CPU)
- Can access all memory (including kernel memory)
- Can directly access hardware/I/O ports
- Can modify page tables, interrupt handlers, etc.
