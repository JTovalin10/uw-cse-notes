# CSE 351: Hardware/Software Interface Index

Master navigation hub for CSE 351 notes. For a course overview and goals, see the [[CSE351/README|README]].

---

## Number Representation
- [[CSE351/Number Representation/Binary and Hexadecimal|Binary and Hexadecimal]]
- [[CSE351/Number Representation/Unsigned Integers|Unsigned Integers]]
- [[CSE351/Number Representation/Two's Complement|Two's Complement]]
- [[CSE351/Number Representation/Bitwise Operations|Bitwise Operations]]
- [[CSE351/Number Representation/Bit Shifting|Bit Shifting]]
- [[CSE351/Number Representation/Overflow|Overflow]]

## Memory Fundamentals
- [[CSE351/Memory Fundamentals/Words and Memory|Words and Memory (including Endianness)]]
- [[CSE351/Memory Fundamentals/Pointers|Pointers (including Pointer Arithmetic)]]

## x86-64 Assembly
- [[CSE351/x86-64 Assembly/x86-64 Instruction Format|Instruction Format]]
- [[CSE351/x86-64 Assembly/x86-64 Operand Types|Operand Types]]
- [[CSE351/x86-64 Assembly/x86-64 Registers|Registers]]
- [[CSE351/x86-64 Assembly/x86-64 Memory Operands|Memory Operands]]
- [[CSE351/x86-64 Assembly/Condition Codes|Condition Codes]]
- [[CSE351/x86-64 Assembly/Jump Instructions|Jump Instructions]]
- [[CSE351/x86-64 Assembly/Labels|Labels]]
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]]
- [[CSE351/x86-64 Assembly/Loops|Loops]]
- [[CSE351/x86-64 Assembly/Extension Instructions|Extension Instructions]]
- [[CSE351/x86-64 Assembly/Switch Statements|Switch Statements]]

## Procedures and Stack
- [[CSE351/Procedures and Stack/Memory Layout|Memory Layout]]
- [[CSE351/Procedures and Stack/Stack Pointer|Stack Pointer]]
- [[CSE351/Procedures and Stack/Calling Conventions|Calling Conventions]]
- [[CSE351/Procedures and Stack/Stack Frames|Stack Frames]]
- [[CSE351/Procedures and Stack/Register Saving Conventions|Register Saving Conventions]]
- [[CSE351/Procedures and Stack/Recursion|Recursion]]
- [[CSE351/Procedures and Stack/CALL Process|CALL Process]]
- [[CSE351/Procedures and Stack/Program Counter|Program Counter]]

## Data Structures
- [[CSE351/Data Structures/Arrays|Arrays]]
- [[CSE351/Data Structures/Structs|Structs (including Alignment)]]

## Cache
- [[CSE351/Cache/Locality|Locality]]
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]

## Memory Management
- [[CSE351/Memory Management/Memory Allocation|Memory Allocation]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]]
- [[CSE351/Memory Management/Paging|Paging]]
- [[CSE351/Memory Management/Page Tables|Page Tables]]
- [[CSE351/Memory Management/Page Faults|Page Faults]]
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|Translation Lookaside Buffer (TLB)]]

## Security
- [[CSE351/Security/Buffer Overflow|Buffer Overflow]]

## System Programming
- [[CSE351/System Programming/Exceptions|Exceptions]]
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE351/System Programming/Context Switching|Context Switching]]
- [[CSE351/System Programming/Fork-Exec Model|Fork-Exec Model]]
- [[CSE351/System Programming/Process Termination|Process Termination]]
- [[CSE351/System Programming/System Calls|System Calls]]

---

## Quick Reference

### Data Type Sizes (64-bit x86-64)
| Type | Size |
|:---|:---|
| `char` | 1 byte |
| `short` | 2 bytes |
| `int` | 4 bytes |
| `long` | 8 bytes |
| `pointer` | 8 bytes |

### Argument Registers (in order)
1. `%rdi`, 2. `%rsi`, 3. `%rdx`, 4. `%rcx`, 5. `%r8`, 6. `%r9`
*Mnemonic: "Diane's Silk Dress Cost $8.59"*

### Callee-Saved Registers
`%rbx`, `%rbp`, `%r12`-`%r15` (Must be restored by the called function)

### Caller-Saved Registers
`%rax`, `%rcx`, `%rdx`, `%rsi`, `%rdi`, `%r8`-`%r11` (May be overwritten by the called function)
