# CSE333: Heap Management

The **Heap** is a large pool of memory used for data that needs to persist across multiple function calls or whose size is unknown at compile-time.

## Dynamic Allocation

Programmers explicitly request and release blocks of memory on the heap.

- **Manual Management**: Unlike Java, C has no garbage collector. The programmer is solely responsible for releasing memory when it is no longer needed.
- **Persistence**: Dynamically allocated memory lives until it is explicitly freed or the process exits.

## Why Use the Heap?

1. **Lifetime**: When data needs to outlive the function that created it — stack memory is reclaimed when the function returns.
2. **Size**: When the size of the data is determined at runtime (e.g., reading a file of unknown length).
3. **Capacity**: The heap is much larger than the stack, which is typically limited to a few megabytes.

## How it Works

The heap is managed by the C runtime library (e.g., `glibc`). When `malloc()` is called, the allocator searches its internal free list for a block large enough to satisfy the request. If none exists, it requests more memory from the OS via the `sbrk()` or `mmap()` system call. When `free()` is called, the block is returned to the free list for future reuse.

For the allocation and deallocation API, see [[Malloc and Free|Malloc and Free]].

## Related

- [[Malloc and Free|Malloc and Free]]
- [[Memory Bugs and Valgrind|Memory Bugs and Valgrind]]
- [[C Memory Model|C Memory Model]]
- [[Systems Programming/Memory Management/Stack|Stack]]

## Industry Standard Terms

- **Heap** — Also called the "free store" in C++ terminology
- **Memory allocator** — The library component that manages the heap; examples include `ptmalloc` (glibc), `jemalloc` (Firefox, FreeBSD), and `tcmalloc` (Google)
- **Dynamic memory** — Memory whose size and lifetime are determined at runtime, as opposed to static or stack-allocated memory
