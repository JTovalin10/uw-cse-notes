# x86-64 Programming

Overview of programming for the x86-64 architecture, focusing on memory model, registers, and instruction set basics.

## Architecture Fundamentals
x86-64 is a 64-bit extension of the x86 instruction set architecture. It uses a **CISC** (Complex Instruction Set Computer) design.

## Register Set
The x86-64 architecture provides 16 general-purpose 64-bit registers:
- `%rax`, `%rbx`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%rbp`, `%rsp`
- `%r8` through `%r15`

See [[x86-64 Registers|x86-64 Registers]] for details on their usage and conventions.

## Memory Model
- **Byte-addressable**: Each address refers to a single byte.
- **Little-endian**: Least significant byte is stored at the lowest address.
- **Address Space**: 64-bit addresses, though current implementations often use only 48 bits.

## Programming Topics
- [[x86-64 Instruction Format|Instruction Format]]
- [[x86-64 Operand Types|Operand Types]] (Immediates, Registers, Memory)
- [[x86-64 Memory Operands|Memory Addressing Modes]]
- [[Condition Codes|Condition Codes and Control Flow]]
- [[Hardware & Software Interface/x86-64 Assembly/Loops|Loops and Conditionals]]
- [[Jump Instructions|Jump Instructions]]

## Security Implications
Understanding x86-64 programming is critical for understanding memory-based vulnerabilities:
- [[Buffer Overflows|Buffer Overflows]]
- [[Memory Layout in a Program|Memory Layout and the Stack]]
