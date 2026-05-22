# CSE 351: Hardware/Software Interface Index

Master navigation hub for CSE 351 notes. For a course overview and goals, see the [[CSE351/README|README]].

---

## Number Representation
- [[Binary and Hexadecimal|Binary and Hexadecimal]] — number base conversion
- [[Unsigned Integers|Unsigned Integers]] — unsigned integer representation
- [[Two's Complement|Two's Complement]] — signed integer representation
- [[Bitwise Operations|Bitwise Operations]] — AND, OR, XOR, NOT bit operations
- [[Bit Shifting|Bit Shifting]] — logical and arithmetic bit shifts
- [[Overflow|Overflow]] — arithmetic overflow detection

## Memory Fundamentals
- [[Words and Memory|Words and Memory (including Endianness)]] — word size and memory addressing
- [[CSE351/Memory Fundamentals/Pointers|Pointers (including Pointer Arithmetic)]] — pointer definition and dereferencing

## x86-64 Assembly
- [[x86-64 Instruction Format|Instruction Format]] — assembly instruction format
- [[x86-64 Operand Types|Operand Types]] — register, immediate, memory operand types
- [[x86-64 Registers|Registers]] — 16 general-purpose registers and conventions
- [[x86-64 Memory Operands|Memory Operands]] — memory addressing modes
- [[Condition Codes|Condition Codes]] — CPU flags (Zero, Sign, Overflow, Carry)
- [[Jump Instructions|Jump Instructions]] — conditional and unconditional jumps
- [[Labels|Labels]] — assembly labels for jumps and addressing
- [[CSE351/x86-64 Assembly/Conditionals|Conditionals]] — if-else assembly patterns
- [[CSE351/x86-64 Assembly/Loops|Loops]] — loop implementation in assembly
- [[Extension Instructions|Extension Instructions]] — sign/zero extension instructions
- [[Switch Statements|Switch Statements]] — switch statement assembly (jump tables)

## Procedures and Stack
- [[CSE351/Procedures and Stack/Memory Layout|Memory Layout]] — stack, heap, data, code segment arrangement
- [[Stack Pointer|Stack Pointer]] — stack pointer register (%rsp)
- [[Calling Conventions|Calling Conventions]] — System V AMD64 ABI (args, returns)
- [[Stack Frames|Stack Frames]] — activation record structure
- [[Register Saving Conventions|Register Saving Conventions]] — caller-saved vs callee-saved registers
- [[Recursion|Recursion]] — recursive function implementation in assembly
- [[CALL Process|CALL Process]] — x86 CALL instruction mechanism
- [[Program Counter|Program Counter]] — instruction pointer register (%rip)

## Data Structures
- [[CSE351/Data Structures/Arrays|Arrays]] — array storage and indexing in memory
- [[Structs|Structs (including Alignment)]] — struct layout in memory

## Cache
- [[Cache Locality|Locality]]
- [[Cache Organization|Cache Organization (Parameters, Placement, Miss Types)]]
- [[Cache Associativity|Cache Associativity]]
- [[Handling Writes|Handling Writes (Write Policies)]]
- [[Program Optimizations via Cache|Program Optimizations via Cache]]
- [[CSE351/Cache/Side Channel Attacks|Side Channel Attacks (Spectre, Flush+Reload)]]

## Security
- [[Buffer Overflow|Buffer Overflow]] — buffer overrun security vulnerability

## Memory Management
- [[Memory Allocation|Memory Allocation]] — malloc/free dynamic allocation
- [[Explicit Allocation Implementation|Explicit Allocation Implementation]]
- [[Segregated List Allocators|Segregated List Allocators]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory]] — virtual memory abstraction
- [[CSE351/Memory Management/Paging|Paging]] — virtual memory paging mechanism
- [[Page Tables|Page Tables]] — virtual-to-physical address translation tables
- [[Page Faults|Page Faults]] — accessing unmapped virtual memory
- [[Translation Lookaside Buffer (TLB 351)|Translation Lookaside Buffer (TLB)]] — TLB structure and operation

## System Programming
- [[Exceptions|Exceptions]] — CPU exceptions and handlers
- [[Processes|Processes]] — process abstraction
- [[Context Switching|Context Switching]] — process context save/restore
- [[Fork-Exec Model|Fork-Exec Model]] — process creation with fork and exec
- [[Process Termination|Process Termination]] — exit codes and process cleanup
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
