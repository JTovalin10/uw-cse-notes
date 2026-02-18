**Extended Instruction Pointer** (32-bit)

# What it does
- Points to the **next instruction** to be executed
- Automatically incremented after each instruction fetch
- Modified by jumps, calls, returns, and interrupts

# Key points
- Cannot be directly modified by `mov` instructions
- Changed indirectly via `jmp`, `call`, `ret`, interrupts, exceptions
- When a function is called, EIP is pushed onto the stack (return address)
- When returning, `ret` pops the saved EIP back

# Related
- [[RIP]] - 64-bit version
- [[CSE451/Processes/CPUState/Program Counter]] - generic term for instruction pointer
