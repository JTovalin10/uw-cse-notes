# CSE451: Buddy Allocator

The **Buddy Allocator** is a binary tree-based memory allocation algorithm used by operating systems (most notably Linux) to manage physical memory pages and minimize **external fragmentation**.

## Core Concept
The allocator manages memory in blocks that are powers of two ($2^n$ pages). When a request for $2^k$ pages is made:
1. It looks for a free block of size $2^k$.
2. If none exist, it finds a larger block of size $2^{k+1}$ and splits it into two "buddies" of size $2^k$.
3. This process continues recursively until a block of the requested size is available.

## Deallocation and Coalescing
When a block is freed, the allocator checks if its **Buddy** (the other half of the block it was split from) is also free.
- If the buddy is free, the two blocks are **coalesced** back into a single block of size $2^{k+1}$.
- This process continues upward as long as buddies are free, helping to defragment memory and create larger contiguous chunks.

## Properties
- **Binary Splitting**: All block sizes are $2^n$ times the base page size.
- **Efficient Lookup**: The address of a block's buddy can be calculated using a simple XOR operation on the memory address: `buddy_addr = block_addr ^ block_size`.
- **Fast Allocation**: Most operations are $O(\log N)$.

## Trade-offs
- **External Fragmentation**: Highly reduced compared to variable partitions, as small blocks can be merged into large ones.
- **Internal Fragmentation**: Can be significant. If a process needs 65KB, the allocator must provide 128KB (the next power of two), wasting nearly 50% of the allocated block. This is the primary reason the [[Operating Systems/Virtualization/Memory/Concepts/Slab Allocation|Slab Allocation]] mechanism exists — to manage the space *within* the pages provided by the Buddy Allocator.

## Deep Dive
The Linux kernel's physical page allocator is a direct implementation of the Buddy Allocator, tracking free lists for each order (block size) from `0` to `MAX_ORDER`. It is the allocator that sits beneath [[Operating Systems/Memory/Allocation|kernel-space memory allocation]] more broadly — see that note for how the Buddy Allocator relates to `sbrk()`/`mmap()` at the userspace level and to internal vs. external fragmentation as failure modes.

## Formal Definition
Given a request for $s$ bytes and a base page size $P$, the Buddy Allocator rounds the allocation up to the smallest $2^k \cdot P$ such that $2^k \cdot P \geq s$. For two buddy blocks of size $2^k$ starting at addresses $A$ and $B$, they satisfy:
$$A \oplus B = 2^k$$
where $\oplus$ denotes bitwise XOR — this is what allows the buddy's address to be computed in constant time from a block's own address and size.

## Simplified Explanation
Think of a single large sheet of paper that you keep tearing in half whenever someone needs a smaller piece. If two half-sheets that came from the same original tear are both unused, you can tape them back together into the full sheet. The "tape-back-together" check is fast because the two halves' addresses differ by exactly one bit (their size), so a XOR reveals the buddy's address instantly.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Buddy Allocator | Binary buddy system allocator |
| Buddy | Sibling block (from the same split) |
| Coalescing | Merging / defragmentation |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Slab Allocation|Slab Allocation]]
- [[Operating Systems/Virtualization/Memory/Concepts/TLABs|Thread-Local Allocation Buffers (TLABs)]]
- [[Operating Systems/Memory/Allocation|Memory Allocation]]
- [[Variable Partitions|Variable Partitions]]
