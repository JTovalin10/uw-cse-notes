# CSE451: Virtual Address Downsides

While [[Virtual Addresses]] solve every major problem of [[Base and Bounds]], they introduce their own costs:

- **Memory overhead** — page tables themselves take up physical memory. A large address space with many pages requires a correspondingly large page table just to record all the virtual-to-physical mappings, which is pure overhead compared to the single base/bounds pair that base and bounds needed
- **TLB required for performance** — translating every memory access through a page table lookup in RAM would be prohibitively slow, so hardware needs a Translation Lookaside Buffer (TLB) to cache recent page table lookups. This adds another piece of specialized, power-hungry hardware, and a TLB miss still requires a full, slower page table walk
- **More complex hardware** — the CPU's memory management unit (MMU) must implement page table walking, TLB caching, and permission checking on every memory access, all of which is significantly more complex than the simple addition-and-comparison logic required by base and bounds

## Related
- [[Virtual Addresses]] — the parent mechanism these downsides apply to
- [[Base and Bounds]] — the simpler (but more limited) predecessor mechanism
- [[Demand Paging]] — one of the benefits that offsets these costs

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| TLB | Translation Lookaside Buffer (TLB) |
