# CSE451: Demand Paging (Memory Overcommitment)

**Demand paging** is one of the ways [[Virtual Addresses]] fix the shortcomings of [[Base and Bounds]]: the OS can promise a process more memory than is physically available, only allocating physical frames when a page is actually accessed for the first time.

```
Process "needs" 1GB
→ Page table has 1GB of entries
→ Only allocate physical frames when pages are accessed
→ Actually using 50MB of RAM
```

A process's page table can contain entries for its entire requested address space (1GB in the example above) without any of those pages being backed by real physical memory yet. Each page table entry is initially marked invalid or not-present. The corresponding physical frame is only allocated the first time the process actually touches that page — at which point the hardware raises a page fault, and the OS handles it by allocating a frame and updating the page table entry. If the process only ever touches 50MB worth of pages, only 50MB of physical RAM is ever consumed, even though 1GB was "promised."

## Related
- [[Virtual Addresses]] — the parent mechanism enabling demand paging
- [[Base and Bounds]] — the earlier mechanism that could not overcommit memory
- [[Dynamic Growth]] — the related mechanism for adding new pages to a process's page table
- [[Page Protection]] — the present bit in a page table entry that governs whether a frame is currently backed by RAM

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Demand Paging | Demand paging / lazy allocation |
| Memory Overcommitment | Memory overcommitment |
