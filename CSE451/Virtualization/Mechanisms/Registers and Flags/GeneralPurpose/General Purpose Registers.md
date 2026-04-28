# CSE451: General Purpose Registers (x86/x86-64)

The x86 architecture provides several **general purpose registers** used for arithmetic, data movement, and function arguments. In 64-bit mode, their names are prefixed with `R` (RAX, RBX, etc.).

## EAX — Accumulator Register
- Primary register for arithmetic operations
- Holds **return values** from functions
- Used for multiplication/division results
- Often the "main" working register

## EBX — Base Register
- General-purpose register
- **Callee-saved** (the function must preserve it)
- Often used to hold base addresses or pointers
- Less commonly used in modern calling conventions

## ECX — Counter Register
- Used as a **loop counter** (e.g., in the `loop` instruction)
- Holds **shift/rotate counts**
- 4th function argument in some calling conventions
- Often used in string operations

## EDX — Data Register
- Used with EAX for **multiplication** (EDX:EAX = 64-bit result)
- Used with EAX for **division** (EDX = remainder)
- Overflow register for extended arithmetic
- 3rd function argument in some calling conventions

## ESI — Source Index
- **Source pointer** for string/memory operations
- Used in `movs`, `cmps`, `lods` instructions
- 2nd function argument in x86-64 Linux calling convention

## EDI — Destination Index
- **Destination pointer** for string/memory operations
- Used in `movs`, `stos`, `scas` instructions
- 1st function argument in x86-64 Linux calling convention

## Summary Table

| Register | Name | Primary Use | Calling Convention |
|----------|------|-------------|--------------------|
| EAX | Accumulator | Return value, arithmetic | Return value |
| EBX | Base | Base addresses | Callee-saved |
| ECX | Counter | Loop counter, shifts | 4th arg (some) |
| EDX | Data | Multiply/divide overflow | 3rd arg (some) |
| ESI | Source Index | String source | 2nd arg (Linux x64) |
| EDI | Destination Index | String destination | 1st arg (Linux x64) |

## Related
- [[Pointer Registers]] — EBP, ESP, EBP, RBP, RIP, RSP
- [[EFLAGS]] — the flags register
- [[Kernel Stack]] — how registers are saved during a kernel entry
- [[Context Switch]] — registers are saved/restored on context switches
- [[CSE351/System Programming/Exceptions]] — registers saved during exceptions
