# CSE451: External Fragmentation

**External fragmentation** is a problem in [[Base and Bounds]]-based memory allocation where free memory exists but is scattered across many small, non-contiguous chunks that are individually too small to satisfy a new allocation request.

Because base and bounds requires each process's memory to occupy a single contiguous physical region, the total amount of free memory can be large even while no single free chunk is big enough to fit a new process. This happens as processes are created and destroyed over time, leaving behind gaps of varying sizes interspersed between still-running processes.

```
Memory: [Process A: 4KB][FREE: 2KB][Process B: 4KB][FREE: 2KB]
New Process C needs 3KB → Can't fit despite 4KB total free
```

In this example, 4KB total is free (2KB + 2KB), but Process C needs a single contiguous 3KB region, and no individual free chunk is large enough — even though the sum of free memory would be sufficient.

## Related
- [[Base and Bounds]] — the parent mechanism where this problem arises
- [[Internal Fragmentation]] — the related problem of wasted space inside an allocated region
- [[Relocation Nightmare]] — the expensive fix (compaction) for external fragmentation
- [[No More Fragmentation]] — how virtual addressing eliminates this problem entirely

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| External Fragmentation | External fragmentation (standard OS terminology) |
