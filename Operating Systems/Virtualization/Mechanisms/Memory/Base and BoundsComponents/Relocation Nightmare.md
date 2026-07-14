# CSE451: Relocation Nightmare

The **relocation nightmare** is the expensive procedure required to defragment memory or make space for a growing process under [[Base and Bounds]]. Because a process's memory is one contiguous physical region, relieving [[External Fragmentation]] or satisfying [[Limited Growth]] requires physically moving the process's entire memory contents — an operation that creates noticeable system pauses.

To relocate a process, the OS must:
1. **Pause the process** — the process cannot be allowed to run (or be interrupted mid-copy) while its memory is being moved
2. **Copy the entire memory region** — every byte of the process's memory must be copied to its new physical location, which is slow for large processes
3. **Update the base pointer** — the process's base register is updated to point at the new physical starting address
4. **Resume the process** — only once the copy and base-pointer update are complete can the process continue executing

This is fundamentally at odds with responsive, low-latency multitasking, since larger processes cause longer pauses exactly when the OS most needs to reclaim or consolidate memory.

## Related
- [[Base and Bounds]] — the parent mechanism that requires relocation
- [[External Fragmentation]] — the problem relocation (compaction) is meant to fix
- [[Limited Growth]] — the other problem relocation can address by moving a process to a larger free region
- [[No More Fragmentation]] — how virtual addressing avoids the need for relocation entirely

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Relocation Nightmare | Memory compaction / defragmentation |
