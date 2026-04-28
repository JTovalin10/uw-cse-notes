The **Kernel Stack** is a per-process (or per-thread) stack used when the CPU is executing in kernel mode.

## Key Characteristics
- **Per-Process**: Every process has its own unique kernel stack.
- **Fixed Size**: It is typically very small compared to the user stack. On many systems (like traditional x86), it is exactly **one page (4 KB)** in size.
- **Location**: It resides in kernel memory, which is inaccessible to user-mode code.

## Purpose
When a process enters the kernel (via a [[Traps|Trap]], [[Exception]], or [[Interrupts|Interrupt]]), the hardware or low-level entry code switches the stack pointer ([[ESP]]/[[RSP]]) to this kernel stack. 

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
- [[Stack Segment]] (SS)
- Extended Stack Pointer ([[ESP]]): 
- [[Code Segment]] (CS):
- [[EFLAGS]]
- Other Frame Pointers
	- [[EAX]]
	- [[EBX]]
	- [[ECX]]
	- [[EDX]]
	- [[ESI]]
	- [[EDI]]
	- [[EBP]]

![[Pasted image 20260105151204.png]]