# CSE451: Pointer Registers (x86/x86-64)

**Pointer registers** are special-purpose registers that track important memory locations such as the instruction pointer and stack frame boundaries.

## EBP — Base Pointer / Frame Pointer (32-bit)
- Points to the **base of the current stack frame**
- Used to access local variables and function parameters
- **Callee-saved** (must be preserved across function calls)
- Makes debugging easier (enables stack traces)

## ESP — Extended Stack Pointer (32-bit)
- Points to the **top of the stack** (current position)
- Automatically modified by `push` (decrements ESP) and `pop` (increments ESP)
- Changes constantly during function execution

**ESP vs EBP:**
- **ESP**: Moves dynamically (top of stack)
- **EBP**: Fixed for the current frame (stable reference point)

## RBP — Register Base Pointer (64-bit)
- 64-bit version of [[EBP]]
- Points to the **base of the current stack frame**
- Often omitted in optimized 64-bit code (frame pointer omission)
- When used, set up at function entry: `push rbp; mov rbp, rsp`
- Restored at function exit: `leave` or `mov rsp, rbp; pop rbp`

**Stack frame layout when RBP is used:**
```
[RBP + 16]  → second argument (if passed on stack)
[RBP + 8]   → return address
[RBP]       → saved RBP (previous frame)
[RBP - 8]   → first local variable
```

## EIP — Extended Instruction Pointer (32-bit)
- Points to the **next instruction** to be executed
- Automatically incremented after each instruction fetch
- Cannot be directly modified by `mov` instructions
- Changed indirectly via `jmp`, `call`, `ret`, interrupts, exceptions
- When a function is called, EIP is pushed onto the stack (return address)

## RIP — Register Instruction Pointer (64-bit)
- 64-bit version of [[EIP]]
- Supports **RIP-relative addressing**:
```asm
mov rax, [rip + offset]  ; load from address relative to current instruction
```
- Commonly used for accessing global variables in shared libraries

## RSP — Register Stack Pointer (64-bit)
- 64-bit version of [[ESP]]
- In 64-bit mode, stack operations work with 8 bytes by default
- Must be 16-byte aligned before `call` instructions (AMD64 ABI requirement)
- **Red zone**: 128 bytes below RSP can be used without adjusting RSP (leaf functions only)

## Related
- [[General Purpose Registers]] — EAX, EBX, ECX, EDX, ESI, EDI
- [[EFLAGS]] — the flags register
- [[CSE451/Processes/CPUState/Program Counter]] — generic term for instruction pointer
- [[CSE451/Processes/CPUState/Stack Pointer]] — generic term for stack pointer
- [[Kernel Stack]] — how pointer registers are saved during kernel entry
- [[CSE351/System Programming/Exceptions]] — pointer registers saved during exceptions
