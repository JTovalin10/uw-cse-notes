# CSE 333: Memory Bugs and Valgrind

Manual memory management in C is error-prone and leads to several classes of bugs.

## Common Memory Bugs
- **Memory Leaks**: Occurs when code fails to deallocate memory that is no longer used. The process's memory footprint grows until it crashes or slows down the system.
- **Dangling Pointers**: Using a pointer to memory that has already been freed.
- **Double-Free**: Calling `free()` on the same address more than once.
- **Buffer Overflow**: Writing past the end of an allocated block (stack or heap).
- **Uninitialized Read**: Reading from memory before it has been assigned a value.

## Valgrind
**Valgrind** is a suite of tools for debugging and profiling. The most used tool is `memcheck`.
- **Usage**: `valgrind --leak-check=full ./my_program`
- It intercepts calls to `malloc` and `free` to track allocations and detect errors at runtime.
- **Output**: Reports "definitely lost" (true leaks) and "still reachable" (blocks not freed but pointers still exist at exit).

## NULL Pointers
- `NULL` is guaranteed to be an invalid address (usually `0x0`).
- Dereferencing `NULL` causes a **Segmentation Fault**.
- Useful as an indicator of an uninitialized pointer or an allocation failure.

Related: [[Malloc and Free]], [[Heap Management]], [[C Fundamentals/Arrays]]
