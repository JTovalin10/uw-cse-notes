# CSE451: Kernel Mode

**Kernel mode** is the CPU's privileged execution state in which the running code has full access to all hardware resources.

- Can read/write any memory address
- Can access any I/O device
- Can read/write any disk sector
- Can send/receive any network packet
- Can execute [[Privileged Instructions]] (disable interrupts, modify page tables, etc.)

Contrast with [[User Mode]], which restricts all of these capabilities.

## Related
- [[User Mode]] — the restricted counterpart
- [[Hardware Modes]] — the parent concept
- [[Ring 0]] — the x86 privilege ring corresponding to kernel mode
- [[Mode Switch]] — how the CPU transitions into kernel mode
