# What is a Page?

In a virtual memory system, the address space is divided into fixed-size contiguous blocks called **Pages**.

## Key Definitions
- **Page (Virtual Page)**: A fixed-size block of **virtual memory**. It is the unit of mapping in the virtual address space.
- **Frame (Physical Page Frame)**: A fixed-size block of **physical memory (RAM)**.
- **Page Size**: The size of a page, typically **4 KB** on most modern architectures (like x86). All pages and frames must be the same size.

## Why use Pages?
1. **Simplified Allocation**: The OS doesn't need to find a single contiguous block of RAM for a process. Any virtual page can map to any available physical frame.
2. **Elimination of External Fragmentation**: Since all blocks are the same size, any free frame can satisfy any page request. (Internal fragmentation may still occur if a process doesn't use the full last page).
3. **Fine-grained Protection**: Permissions (Read, Write, Execute) can be set on a per-page basis in the [[Page Table]].

## The Mapping
The [[Page Table]] maintains the mapping between **Virtual Page Numbers (VPN)** and **Physical Frame Numbers (PFN)**.

- **Virtual Address** = [ Virtual Page Number | Offset ]
- **Physical Address** = [ Physical Frame Number | Offset ]

The **Offset** remains the same during translation because the position *within* the page is identical to the position *within* the frame.

---
**See Also**:
- [[Paged Virtual Memory]]
- [[Page Table]]
- [[Virtual Memory]]
- [[Memory management]]
