# CSE451: Limited Growth

**Limited growth** is a problem in [[Base and Bounds]]-based memory allocation where a process cannot dynamically expand its memory allocation once it has been assigned a fixed base and bounds region.

```
Process at base=1000, bounds=4KB
Stack wants to grow down, heap wants to grow up
→ Stuck with 4KB forever, can't expand
```

Because a process's entire address space must occupy one contiguous physical region under base and bounds, both the stack (which conventionally grows downward) and the heap (which conventionally grows upward) are permanently capped at whatever bounds were assigned at process creation. There is no way to safely extend the region without either overwriting adjacent memory (if it is in use by another process) or performing a full relocation — see [[Relocation Nightmare]].

## Related
- [[Base and Bounds]] — the parent mechanism where this problem arises
- [[Relocation Nightmare]] — the expensive process required to give a process more room
- [[Dynamic Growth]] — how virtual addressing solves this by adding pages on demand

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Limited Growth | Fixed-partition growth limitation |
