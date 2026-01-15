- Ring 0 (kernel mode)
	- Full access to everything
	- Can execute privileged instructions (like `cli` to disable interrupts, `hlt` to halt CPU)
	- Can access all memory (including kernel memory)
	- Can directly access hardware/I/O ports
	- Can modify page tables, interrupt handlers, etc.
- Ring 3 (user mode)
	- Limited access
	- Can't execute privileged instructions (will cause a fault)
	- Can only access its own virtual memory (page tables enforce this)
	- Can't directly access hardware
	- Must use system calls to ask the kernel to do privileged operations

# Dual-Mode restrictions
## [[Privileged Instructions]]
- available to kernel but not user code
## Limits on memory accesses
- to prevent user code form overwriting the kernel
- to prevent user from reading data it shouldn't
# Timer
- to regain control from a user program in a loop
**Provides a safe way to switch from user mode to kernel mode and vice versa**