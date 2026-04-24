# Super Pages

**Super Pages** (also known as "Huge Pages") are a technique to use page sizes much larger than the standard 4KB (e.g., 2MB or 1GB).

## Motivation
The size of the [[Translation Lookaside Buffer (TLB)]] is limited. As memory sizes and working sets grow, a TLB with 4KB entries can only "cover" a small portion of memory, leading to frequent TLB misses.

## How it works
By using a larger page size, each TLB entry covers a much larger range of contiguous physical memory. 
- A 4KB page size with 512 TLB entries covers 2MB of memory.
- A 2MB page size with 512 TLB entries covers **1GB** of memory.

## Benefits
- **Reduced TLB misses**: Significant performance improvement for memory-intensive applications (like databases or scientific computing).
- **Smaller Page Tables**: Fewer entries are needed to map the same amount of memory.

## Challenges
- **Internal Fragmentation**: If a process only needs a small amount of memory but is allocated a 2MB super page, much of it is wasted.
- **Physical Memory Contiguity**: Finding a large, contiguous block of physical memory (e.g., 2MB) can be difficult if memory is fragmented.

## Related
- [[Translation Lookaside Buffer (TLB)]]
- [[CSE451/Memory Management/Memory Models/Paging|Paging]]
