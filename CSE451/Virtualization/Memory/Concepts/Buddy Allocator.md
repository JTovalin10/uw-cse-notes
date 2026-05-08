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
- **Internal Fragmentation**: Can be significant. If a process needs 65KB, the allocator must provide 128KB (the next power of two), wasting nearly 50% of the allocated block. This is the primary reason the [[CSE451/Virtualization/Memory/Concepts/Slab Allocation|Slab Allocation]] mechanism exists—to manage the space *within* the pages provided by the Buddy Allocator.

---
**See Also**: [[CSE451/Virtualization/Memory/Concepts/Slab Allocation|Slab Allocation]], [[CSE451/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]]
