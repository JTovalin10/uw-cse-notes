# CSE451: Ring 3 (User Mode)

**Ring 3** is the least privileged CPU execution mode. It corresponds to [[User Mode]].

- Limited access
- Cannot execute [[Privileged Instructions]] (will cause a [[General Protection Fault (GPF)]])
- Can only access its own virtual memory (page tables enforce this)
- Cannot directly access hardware
- Must use [[System Call|system calls]] to ask the kernel to perform privileged operations

## Related
- [[Ring 0]] — the most privileged ring (kernel mode)
- [[Privilege Level]] — the parent concept
- [[User Mode]] — the OS-level concept corresponding to Ring 3
- [[General Protection Fault (GPF)]] — raised when Ring 3 attempts something restricted
