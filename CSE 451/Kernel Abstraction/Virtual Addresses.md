# What is virtual addresses
- translation done in hardware, using a table
- table set up by os kernel
- memory is broken into pages (typically 4KB chunks)
![[Screenshot 2026-01-07 at 12.41.04 PM.png]]
# How this fixes base and bounds
**1. No More Fragmentation**

- Allocate any free 4KB frame anywhere in physical memory
- Virtual pages appear contiguous to the process
- Physical frames can be scattered

**2. Easy Sharing**

```
Process A's page 5 → Frame 100 (shared library code)
Process B's page 3 → Frame 100 (same shared library)
```

Multiple virtual addresses → same physical frame

**3. Dynamic Growth**

```
Heap needs more space?
→ Allocate new page, add entry to page table
→ No need to move existing pages
```
**4. Memory Overcommitment (Demand Paging)**

```
Process "needs" 1GB
→ Page table has 1GB of entries
→ Only allocate physical frames when pages are accessed
→ Actually using 50MB of RAM
```

**5. Protection at Page Granularity** Each page table entry includes:

- Valid bit (is this page allocated?)
- Read/Write/Execute permissions
- Present bit (in RAM or swapped to disk?)
# Downside
- memory overhead as page tables take space
- TLB required for performance (caching page table lookups)
- More complex hardware