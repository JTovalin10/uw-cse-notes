# CSE451: No More Fragmentation

**No more fragmentation** is one of the ways [[Virtual Addresses]] fix the [[Internal Fragmentation]] and [[External Fragmentation]] problems of [[Base and Bounds]]: because memory is allocated in small, uniformly-sized pages instead of one large contiguous region per process, free physical frames can be handed out from anywhere in memory.

- The OS can allocate any free 4KB frame anywhere in physical memory to satisfy the next page a process needs — there is no requirement that a process's pages be physically adjacent to one another
- Virtual pages appear contiguous to the process, since the hardware transparently translates each virtual page to whatever physical frame it happens to be mapped to
- Physical frames can be scattered arbitrarily across RAM, since paging removes the need for one single contiguous physical block

Because allocation happens in fixed-size page units (typically 4KB) rather than variable-size regions, and because any free frame can satisfy any page request regardless of location, there is no way for free memory to become unusably fragmented — every free frame is equally usable for the next page request, which eliminates [[External Fragmentation]]. Fixed page sizes also nearly eliminate [[Internal Fragmentation]], since the only waste possible is the partial last page of a process's allocation (at most one page's worth), rather than an entire oversized partition.

## Related
- [[Virtual Addresses]] — the parent mechanism enabling fragmentation-free allocation
- [[Internal Fragmentation]] — the base and bounds problem largely solved by fixed page sizes
- [[External Fragmentation]] — the base and bounds problem solved by allowing scattered physical frames

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| No More Fragmentation | Paging-based fragmentation avoidance |
