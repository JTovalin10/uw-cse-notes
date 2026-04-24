# CSE351: Virtual Memory

**Virtual memory** provides each process with the illusion of a private address space, hiding actual physical RAM.

---

## Key Address Spaces

### Virtual Address Space
- **Definition:** Bytes each process thinks it has
- **Size:** $N = 2^n$ bytes ($n$-bit virtual addresses)
- **Characteristics:** Private to each process; can exceed physical memory

### Physical Address Space
- **Definition:** Bytes actually in physical memory (RAM)
- **Size:** $M = 2^m$ bytes ($m$-bit physical addresses)
- **Characteristics:** Shared across all processes

### Swap Space
- Region of disk used for excess memory
- Allows the virtual address space to exceed physical RAM
- Much slower than RAM

---

## Address Types

| Type | Width | Usage |
|:---|:---|:---|
| Virtual | $n$ bits | Used in program instructions |
| Physical | $m$ bits | Actual hardware locations |

---

## The Indirection Layer

Virtual memory maps virtual addresses to physical addresses through **address translation**, performed by the **MMU (Memory Management Unit)**.

**Key insight:** The address width in programs equals the virtual address width, which is determined by the word size (e.g., 64-bit programs use 64-bit virtual addresses).

---

## Process Memory Reality

Most processes use only a small fraction of their virtual address space:
- 64-bit machine: $2^{64}$ = 16 EiB virtual space per process
- Typical usage: a few physical pages (Stack, Heap, Code, Data)
- Unused virtual pages are never assigned physical memory

---

## Physical Memory as Cache

Because disk access is massively slower than RAM, the OS manages physical memory like a cache of disk pages:

| Parameter | Value | Reason |
|:---|:---|:---|
| Page size | Large (4 KB–4 MB) | Amortize the cost of disk I/O |
| Associativity | Fully associative | Minimize [[CSE351/Memory Management/Page Faults|page faults]] |
| Write policy | Write-back | Reduce disk writes |

---

## Related
- [[CSE351/Memory Management/Paging|Paging]]
- [[CSE351/Memory Management/Page Tables|Page Tables]]
- [[CSE351/Memory Management/Page Faults|Page Faults]]
- [[CSE351/Memory Management/Translation Lookaside Buffer (TLB 351)|TLB]]
- [[CSE351/System Programming/Processes|Processes]]
- [[CSE451/Virtual Memory/Virtual Memory|Virtual Memory (CSE451)]]
- [[CSE451/Virtual Memory/Paged Virtual Memory|Paged Virtual Memory (CSE451)]]
- [[CSE451/Kernel Abstraction/Memory/Virtual Addresses|Virtual Addresses (CSE451)]]
- [[CSE484/Memory Exploits/Memory Layout|Memory Layout (CSE484)]]
