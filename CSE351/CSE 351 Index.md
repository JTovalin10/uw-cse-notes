# CSE 351 - Hardware/Software Interface

## Number Representation
- [[Binary and Hexadecimal]]
- [[Unsigned Integers]]
- [[Two's Complement]]
- [[Bitwise Operations]]
- [[Bit Shifting]]
- [[Overflow]]

## Memory Fundamentals
- [[Words and Memory]]
- [[Endianness]]
- [[CSE351/Memory Fundamentals/Pointers]]
- [[Pointer Arithmetic]]

## x86-64 Assembly
- [[x86-64 Instruction Format]]
- [[x86-64 Operand Types]]
- [[x86-64 Registers]]
- [[x86-64 Memory Operands]]
- [[Condition Codes]]
- [[Jump Instructions]]
- [[Labels]]
- [[CSE351/x86-64 Assembly/Conditionals]]
- [[CSE351/x86-64 Assembly/Loops]]
- [[Extension Instructions]]
- [[Switch Statements]]

## Procedures and Stack
- [[CSE351/Procedures and Stack/Memory Layout]]
- [[CSE351/Procedures and Stack/Stack Pointer]]
- [[Calling Conventions]]
- [[Stack Frames]]
- [[Register Saving Conventions]]
- [[Recursion]]
- [[CALL Process]]
- [[CSE351/Procedures and Stack/Program Counter]]

## Data Structures
- [[Arrays]]
- [[Structs]]
- [[Struct Alignment]]

## Security
- [[Buffer Overflow]]

## Memory Management
- [[Memory Allocation]]
- [[CSE351/Memory Management/Virtual Memory]]
- [[CSE351/Memory Management/Paging]]
- [[Page Tables]]
- [[Page Faults]]
- [[TLB]]

## System Programming
- [[CSE351/System Programming/Exceptions]]
- [[Processes]]
- [[Context Switching]]
- [[Fork-Exec Model]]
- [[Process Termination]]
- [[System Calls]]

---

## Quick Reference

### Data Type Sizes (64-bit)
| Type | Size |
|------|------|
| char | 1 byte |
| short | 2 bytes |
| int | 4 bytes |
| long | 8 bytes |
| pointer | 8 bytes |

### Argument Registers
1. `%rdi` 2. `%rsi` 3. `%rdx` 4. `%rcx` 5. `%r8` 6. `%r9`

**Mnemonic:** "Diane's Silk Dress Cost $8 9"

### Callee-Saved Registers
`%rbx`, `%rbp`, `%r12`-`%r15`

### Caller-Saved Registers
`%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`-`%r11`
