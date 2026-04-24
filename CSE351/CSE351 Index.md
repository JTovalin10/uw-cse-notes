# CSE 351: Hardware/Software Interface Index

Master navigation hub for CSE 351 notes. For a course overview and goals, see the [[CSE351/README|README]].

---

## Number Representation
- [[CSE351/Number Representation/Binary and Hexadecimal|Binary and Hexadecimal]] — number base conversion
- [[CSE351/Number Representation/Unsigned Integers|Unsigned Integers]] — unsigned integer representation
- [[CSE351/Number Representation/Two's Complement|Two's Complement]] — signed integer representation
- [[CSE351/Number Representation/Bitwise Operations|Bitwise Operations]] — AND, OR, XOR, NOT bit operations
- [[CSE351/Number Representation/Bit Shifting|Bit Shifting]] — logical and arithmetic bit shifts
- [[CSE351/Number Representation/Overflow|Overflow]] — arithmetic overflow detection

## Memory Fundamentals
- [[CSE351/Memory Fundamentals/Words and Memory|Words and Memory (including Endianness)]] — word size and memory addressing
- [[CSE351/Memory Fundamentals/Pointers|Pointers (including Pointer Arithmetic)]] — pointer definition and dereferencing

## x86-64 Assembly
- [[CSE351/x86-64 Assembly/x86-64 Instruction Format|Instruction Format]] — assembly instruction format
- [[CSE351/x86-64 Assembly/x86-64 Operand Types|Operand Types]] — register, immediate, memory operand types
- [[CSE351/x86-64 Assembly/x86-64 Registers|Registers]] — 16 general-purpose registers and conventions
- [[CSE351/x86-64 Assembly/x86-64 Memory Operands|Memory Operands]] — memory addressing modes
- [[CSE351/x86-64 Assembly/Condition Codes|Condition Codes]] — CPU flags (Zero, Sign, Overflow, Carry)
- [[CSE351/x86-64 Assembly/Jump Instructions|Jump Instructions]] — conditional and unconditional jumps
- [[CSE351/x86-64 Assembly/Labels|Labels]] — assembly labels for jumps and addressing
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]] — if-else assembly patterns
- [[CSE351/x86-64 Assembly/Loops|Loops]] — loop implementation in assembly
- [[CSE351/x86-64 Assembly/Extension Instructions|Extension Instructions]] — sign/zero extension instructions
- [[CSE351/x86-64 Assembly/Switch Statements|Switch Statements]] — switch statement assembly (jump tables)

## Procedures and Stack
- [[CSE351/Procedures and Stack/Memory Layout|Memory Layout]] — stack, heap, data, code segment arrangement
- [[CSE351/Procedures and Stack/Stack Pointer|Stack Pointer]] — stack pointer register (%rsp)
- [[CSE351/Procedures and Stack/Calling Conventions|Calling Conventions]] — System V AMD64 ABI (args, returns)
- [[CSE351/Procedures and Stack/Stack Frames|Stack Frames]] — activation record structure
- [[CSE351/Procedures and Stack/Register Saving Conventions|Register Saving Conventions]] — caller-saved vs callee-saved registers
- [[CSE351/Procedures and Stack/Recursion|Recursion]] — recursive function implementation in assembly
- [[CSE351/Procedures and Stack/CALL Process|CALL Process]] — x86 CALL instruction mechanism
- [[CSE351/Procedures and Stack/Program Counter|Program Counter]] — instruction pointer register (%rip)

## Data Structures
- [[CSE351/Data Structures/Arrays|Arrays]] — array storage and indexing in memory
- [[CSE351/Data Structures/Structs|Structs (including Alignment)]] — struct layout in memory

## Cache
- [[CSE351/Cache/Cache Locality|Locality]]
- [[CSE351/Cache/Cache Organization|Cache Organization (Parameters, Placement, Miss Types)]]
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]
- [[CSE351/Cache/Handling Writes|Handling Writes (Write Policies)]]
- [[CSE351/Cache/Program Optimizations via Cache|Program Optimizations via Cache]]
- [[CSE351/Cache/Side Channel Attacks|Side Channel Attacks (Spectre, Flush+Reload)]]

## Security
- [[CSE351/Security/Buffer Overflow|Buffer Overflow]] — buffer overrun security vulnerability

## Memory Management
- [[CSE351/Memory Management/Memory Allocation|Memory Allocation]] — malloc/free dynamic allocation
- [[CSE351/Memory Management/Explicit Allocation Implementation|Explicit Allocation Implementation]]
- [[CSE351/Memory Management/Segregated List Allocators|Segregated List Allocators]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]] — virtual memory abstraction
- [[CSE351/Memory Management/Paging|Paging]] — virtual memory paging mechanism
- [[CSE351/Memory Management/Page Tables|Page Tables]] — virtual-to-physical address translation tables
- [[CSE351/Memory Management/Page Faults|Page Faults]] — accessing unmapped virtual memory
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|Translation Lookaside Buffer (TLB)]] — TLB structure and operation

## System Programming
- [[CSE351/System Programming/Exceptions|Exceptions]] — CPU exceptions and handlers
- [[CSE351/System Programming/Processes|Processes]] — process abstraction
- [[CSE351/System Programming/Context Switching|Context Switching]] — process context save/restore
- [[CSE351/System Programming/Fork-Exec Model|Fork-Exec Model]] — process creation with fork and exec
- [[CSE351/System Programming/Process Termination|Process Termination]] — exit codes and process cleanup
- [[CSE351/System Programming/System Calls|System Calls]] — kernel service requests

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
