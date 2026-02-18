**Register Instruction Pointer** (64-bit)

# What it does
- 64-bit version of [[EIP]]
- Points to the **next instruction** to be executed in x86-64 mode
- Automatically incremented after each instruction fetch

# Key points
- Cannot be directly modified by `mov` instructions
- Changed indirectly via `jmp`, `call`, `ret`, interrupts, exceptions
- Supports **RIP-relative addressing** in 64-bit mode
	- Instructions can reference memory relative to RIP
	- Makes position-independent code easier

# RIP-relative addressing
```asm
mov rax, [rip + offset]  ; load from address relative to current instruction
```
This is commonly used for accessing global variables in shared libraries.

# Related
- [[EIP]] - 32-bit version
- [[CSE451/Processes/CPUState/Program Counter]] - generic term for instruction pointer
