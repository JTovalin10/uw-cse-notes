# CSE 333: C Memory Model

A C program's **virtual address space** is organized into several segments.

## Memory Segments
- **Stack**: Stores local variables and function call frames. Managed automatically by the compiler. Grows **downward** from high addresses.
- **Shared Libraries**: Mapped regions for shared code (e.g., `libc.so`).
- **Heap**: Used for dynamically allocated memory (via `malloc`). Managed manually by the programmer. Grows **upward** from low addresses.
- **Read/Write Data (`.data`, `.bss`)**: Stores global and static variables.
- **Read-Only Data (`.rodata`, `.text`)**: Stores string literals and the program's machine instructions.

## Address Space Layout Randomization (ASLR)
Modern OSs like Linux randomize the base addresses of the stack, heap, and shared libraries on each run. This is a security feature to make buffer overflow attacks harder to execute.

# Related
- [[Stack]]
- [[Heap Management]]
- C Fundamentals/Pointers
- [[CSE351/Memory Fundamentals/Words and Memory|CSE351: Words and Memory]]
- [[CSE351/Memory Management/Memory Allocation|CSE351: Memory Allocation]]
