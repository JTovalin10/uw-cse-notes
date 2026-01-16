# Ring 3 (User Mode)
- Limited access
- Can't execute privileged instructions (will cause a fault)
- Can only access its own virtual memory (page tables enforce this)
- Can't directly access hardware
- Must use system calls to ask the kernel to do privileged operations
