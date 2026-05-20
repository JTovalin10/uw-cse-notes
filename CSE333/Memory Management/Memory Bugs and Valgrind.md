# CSE333: Memory Bugs and Valgrind

Manual memory management in C is error-prone and leads to several classes of bugs. These bugs are often silent — the program may appear to work correctly in testing but fail unpredictably in production.

## Common Memory Bugs

- **Memory Leaks**: Occurs when code fails to deallocate memory that is no longer used. The process's memory footprint grows continuously until it crashes or slows down the system.
- **Dangling Pointers**: Using a pointer to memory that has already been freed. The memory may have been reallocated for another purpose, causing unpredictable behavior.
- **Double-Free**: Calling `free()` on the same address more than once. This corrupts the allocator's internal free list and can be exploited as a security vulnerability.
- **Buffer Overflow**: Writing past the end of an allocated block (on the stack or heap). This corrupts adjacent memory and is one of the most common sources of security exploits.
- **Uninitialized Read**: Reading from memory before it has been assigned a value. The value is garbage from whatever was stored there previously.

## Valgrind

**Valgrind** is a suite of tools for debugging and profiling. The most commonly used tool is `memcheck`.

- **Usage**: `valgrind --leak-check=full ./my_program`
- It intercepts calls to `malloc` and `free` to track every allocation and detect errors at runtime. Because it instruments every memory access, programs run significantly slower under Valgrind (typically 10–30x).
- **Output**: Reports "definitely lost" (true leaks — memory with no remaining reachable pointers) and "still reachable" (blocks not freed but pointers still exist at exit, often intentional).

## NULL Pointers

- `NULL` is guaranteed to be an invalid address (usually `0x0`).
- Dereferencing `NULL` causes a **Segmentation Fault**, which is the "good" failure mode because it crashes immediately rather than silently corrupting data.
- Useful as a sentinel value to indicate an uninitialized pointer or an allocation failure.

## Related

- [[CSE333/Memory Management/Malloc and Free|Malloc and Free]]
- [[CSE333/Memory Management/Heap Management|Heap Management]]
- [[CSE333/C Fundamentals/Arrays|Arrays]]
- [[CSE333/Memory Management/C Memory Model|C Memory Model]]

## Industry Standard Terms

- **Valgrind** — The industry standard dynamic analysis tool for C/C++ memory errors; alternatives include AddressSanitizer (`-fsanitize=address`), MemorySanitizer, and UndefinedBehaviorSanitizer, which are faster and built into modern compilers
- **Memory leak** — A resource leak where heap memory is allocated but never freed; in long-running servers this causes gradual memory exhaustion
- **Buffer overflow** — Also called "buffer overrun"; the classic exploitation vector for stack-smashing attacks (see: Stack Canaries, ASLR, DEP/NX as mitigations)
