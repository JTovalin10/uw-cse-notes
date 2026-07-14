# CSE451: Kernel Stack

The **Kernel Stack** is a per-process (or per-thread) stack used when the CPU is executing in kernel mode.

## Key Characteristics
- **Per-Process**: Every process has its own unique kernel stack.
- **Fixed Size**: It is typically very small compared to the user stack. On many systems (like traditional x86), it is exactly **one page (4 KB)** in size.
- **Location**: It resides in kernel memory, which is inaccessible to user-mode code.

## Purpose
When a process enters the kernel (via a [[Traps|Trap]], [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception|Exception]], or [[Interrupts|Interrupt]]), the hardware or low-level entry code switches the stack pointer ([[ESP]]/[[RSP]]) to this kernel stack. 

It is used to store:
- Saved user-mode registers (the **Trap Frame**)
- Local variables for kernel functions
- Return addresses for nested kernel function calls

## Limits
Because it is only **1 page** (4 KB), kernel code must be careful:
- No large local arrays or structures on the stack.
- No deep recursion.
- If the kernel stack overflows, it usually results in a **Double Fault** and a system crash (panic).

---
## x86 Kernel Stack Contents
When a trap, exception, or interrupt fires, the hardware and low-level entry code push a **trap frame** onto the kernel stack containing:
- [[Stack Segment]] (SS)
- Extended Stack Pointer ([[ESP]])
- [[Code Segment]] (CS)
- [[EFLAGS]]
- Other saved general-purpose registers
	- [[EAX]]
	- [[EBX]]
	- [[ECX]]
	- [[EDX]]
	- [[ESI]]
	- [[EDI]]
	- [[EBP]]

![[Pasted image 20260105151204.png]]

## Related
- [[Traps|Traps]] — one of the events that switches execution onto the kernel stack
- [[Operating Systems/Virtualization/Mechanisms/Exceptions/Exception]] — another event that uses the kernel stack
- [[Interrupts|Interrupts]] — hardware interrupts also enter through the kernel stack
- [[Interrupt Stack]] — the related per-processor stack used specifically for interrupt handling
- [[Mode Storage]] — the privilege mode is saved onto the kernel stack during a context switch
- [[ESP]] / [[RSP]] — the stack pointer registers redirected to the kernel stack on kernel entry

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Kernel Stack | Kernel-mode stack / per-thread kernel stack |
| Trap Frame | Trap frame / interrupt stack frame (also called "pt_regs" in Linux) |