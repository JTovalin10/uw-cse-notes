# CSE451: Memory Allocation

Memory allocation in Operating Systems occurs at two primary levels: the **[[User Space Allocation]]** (via standard libraries) and the **[[Kernel Space Allocation]]** (managed by the kernel for its own data structures).

### User Space Allocation
Userspace programs manage memory using the `malloc()` and `free()` family of functions, which are implemented by a library like `glibc`.

#### Mechanism: sbrk vs mmap
- **[[sbrk()]]**: A system call that moves the "program break" (the end of the heap). It is fast but only works for contiguous memory and doesn't easily return memory to the OS.
- **[[mmap()]]**: A system call that maps a new region of the virtual address space. It is used for large allocations (>128KB) and allows for more flexible memory management (e.g., shared memory, anonymous mappings).

### Kernel Space Allocation
The kernel needs to allocate memory for objects of vastly different sizes, from small network buffers to large process structures.

#### Slab Allocator
The **[[Slab Allocator]]** (and its variants SLUB/SLOB) is designed to minimize fragmentation and initialization time.

- **[[Slab]]**: A contiguous set of physical pages.
- **[[Cache]]**: A collection of slabs for a specific type of object (e.g., `task_struct`, `inode`).
- **Mechanism**: Instead of freeing memory back to the global pool, objects are kept "constructed" in the slab. When a new object is needed, an existing free one is reused immediately.

#### Internal vs External Fragmentation
- **[[Internal Fragmentation]]**: Wasted space inside an allocated block (e.g., allocating a 4KB page for a 10-byte string).
- **[[External Fragmentation]]**: Wasted space between allocated blocks, where no single block is large enough to satisfy a request despite having enough total free memory.

### Memory Debugging
- **[[Valgrind]]**: A dynamic analysis tool that uses a virtual machine to track every memory access, identifying **[[Memory Leaks]]** and "use-after-free" bugs.
- **[[AddressSanitizer (ASan)]]**: A compiler-based instrumentation tool that detects memory errors with much lower overhead than Valgrind.

### Linux Memory Metrics
- **[[Virtual Size (VSZ)]]**: The total virtual memory a process has access to, including shared libraries and swapped-out pages.
- **[[Resident Set Size (RSS)]]**: The portion of a process's memory that is actually held in physical RAM.
- **[[Out-of-Memory (OOM) Killer]]**: A kernel task that monitors memory pressure. If the system runs out of RAM+Swap, it assigns an `oom_score` to processes and kills the one with the highest score to save the system.

### Related
- [[CSE451/Memory/Virtual Memory]]
- [[CSE333/Memory Management/C++ Allocation]]
