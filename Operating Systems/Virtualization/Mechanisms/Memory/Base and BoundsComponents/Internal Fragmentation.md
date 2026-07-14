# CSE451: Internal Fragmentation

**Internal fragmentation** is a problem in [[Base and Bounds]]-based memory allocation where the OS allocates a fixed-size partition larger than what a process actually needs, wasting the unused space inside that partition.

For example, if a process needs 7KB but the OS only allocates memory in fixed-size chunks (e.g., 8KB partitions), the process receives an 8KB region and 1KB goes unused. Because this wasted space is *inside* the boundary allocated to the process, it cannot be reclaimed or given to another process — it is simply wasted for as long as the process runs, even though no other process can use it.

Memory is wasted inside the allocated region itself, as opposed to [[External Fragmentation]] where the waste comes from unusable gaps *between* allocated regions.

## Related
- [[Base and Bounds]] — the parent mechanism where this problem arises
- [[External Fragmentation]] — the related problem of unusable gaps between allocations
- [[No More Fragmentation]] — how virtual addressing eliminates this problem via page-level allocation

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Internal Fragmentation | Internal fragmentation (standard OS terminology) |
