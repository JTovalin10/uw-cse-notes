# Virtual Memory

**Virtual memory** provides each process with the illusion of a private address space, hiding actual physical RAM.

**Related:** [[CSE484/Memory Exploits/Memory Layout]], [[Page Tables]], [[TLB]], [[Processes]]

---

## Key Address Spaces

### Virtual Address Space
- **Definition:** Bytes each process thinks it has
- **Size:** N = 2^n bytes (n-bit virtual addresses)
- **Characteristics:** Private to each process, can exceed physical memory

### Physical Address Space
- **Definition:** Bytes actually in physical memory
- **Size:** M = 2^m bytes (m-bit physical addresses)
- **Characteristics:** Shared across all processes

### Swap Space
- Region of disk for excess memory
- Allows virtual space to exceed physical
- Much slower than RAM

---

## Address Types

| Type | Width | Usage |
|------|-------|-------|
| Virtual | n bits | Program instructions |
| Physical | m bits | Actual hardware locations |

---

## The Indirection Layer

Virtual memory maps virtual addresses to physical addresses through **address translation**.

**Key insight:** Address width in programs = virtual addresses (determined by word size)

---

## Process Memory Reality

Most processes use small fraction of virtual space:
- 64-bit machine: 2^64 = 16 EiB virtual per process
- Typical usage: 2-4 physical pages (Stack, Heap, Code, Data)
- Unused virtual pages never get physical memory

---

## Physical Memory as Cache

Due to high disk access penalty:

| Parameter | Value | Reason |
|-----------|-------|--------|
| Page Size | Large (4KB-4MB) | Amortize disk cost |
| Associativity | Fully associative | Minimize [[Page Faults]] |
| Write Policy | Write-back | Reduce disk writes |

**Related:** [[Page Tables]], [[CSE351/Memory Management/Paging]]
