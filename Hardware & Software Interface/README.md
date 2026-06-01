# CSE 351 - The Hardware/Software Interface

## Course Overview

CSE 351 explores the interface between hardware and software, covering how programs execute at the machine level. Topics include data representation, assembly programming, memory hierarchy, and the fundamentals of operating systems.

## Topics Covered

### Number Representation
- Binary and hexadecimal number systems
- Unsigned integers
- Two's complement (signed integers)
- Bitwise operations (AND, OR, XOR, NOT)
- Bit shifting (logical and arithmetic)
- Overflow detection and handling

### Memory Fundamentals
- Words and memory addressing
- Endianness (big-endian vs little-endian)
- Pointers and pointer arithmetic
- Memory layout

### x86-64 Assembly
- Instruction format and syntax
- Operand types: registers, immediates, memory
- Register conventions (16 general-purpose registers)
- Memory operands and addressing modes
- Condition codes (flags)
- Jump instructions and labels
- Conditionals and loops
- Extension instructions (sign/zero extend)
- Switch statements and jump tables

### Procedures and the Stack
- Memory layout (stack, heap, data, code)
- Stack pointer (%rsp) and frame pointer (%rbp)
- Calling conventions (System V AMD64 ABI)
- Stack frames
- Register saving conventions (caller-saved vs callee-saved)
- Recursion implementation
- CALL/RET process
- Program counter (%rip)

### Data Structures
- Arrays in memory
- Structs and struct alignment
- Padding and packing

### Memory Management
- Memory allocation (malloc/free)
- Virtual memory concepts
- Paging and page tables
- Page faults
- Translation Lookaside Buffer (TLB)

### System Programming
- Exceptions and interrupts
- Processes and context switching
- Fork-exec model
- Process termination
- System calls

### Security
- Buffer overflow vulnerabilities
