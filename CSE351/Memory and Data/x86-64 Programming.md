# x86-64 Programming

Overview of programming for the x86-64 architecture, focusing on memory model, registers, and instruction set basics.

## Architecture Fundamentals
x86-64 is a 64-bit extension of the x86 instruction set architecture. It uses a **CISC** (Complex Instruction Set Computer) design.

## Register Set
The x86-64 architecture provides 16 general-purpose 64-bit registers:
- `%rax`, `%rbx`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%rbp`, `%rsp`
- `%r8` through `%r15`

See [[CSE351/x86-64 Assembly/x86-64 Registers|x86-64 Registers]] for details on their usage and conventions.

## Memory Model
- **Byte-addressable**: Each address refers to a single byte.
- **Little-endian**: Least significant byte is stored at the lowest address.
- **Address Space**: 64-bit addresses, though current implementations often use only 48 bits.

## Programming Topics
- [[CSE351/x86-64 Assembly/x86-64 Instruction Format|Instruction Format]]
- [[CSE351/x86-64 Assembly/x86-64 Operand Types|Operand Types]] (Immediates, Registers, Memory)
- [[CSE351/x86-64 Assembly/x86-64 Memory Operands|Memory Addressing Modes]]
- [[CSE351/x86-64 Assembly/Condition Codes|Condition Codes and Control Flow]]
- [[CSE351/x86-64 Assembly/Loops|Loops and Conditionals]]
- [[CSE351/x86-64 Assembly/Jump Instructions|Jump Instructions]]

## Security Implications
Understanding x86-64 programming is critical for understanding memory-based vulnerabilities:
- [[CSE484/Memory Exploits/Buffer Overflows|Buffer Overflows]]
- [[CSE484/Memory Exploits/Memory Layout in a Program|Memory Layout and the Stack]]
