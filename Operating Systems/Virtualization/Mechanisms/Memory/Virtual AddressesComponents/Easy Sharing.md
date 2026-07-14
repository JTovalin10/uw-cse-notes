# CSE451: Easy Sharing

**Easy sharing** is one of the ways [[Virtual Addresses]] fix the [[No Sharing Problem]] of [[Base and Bounds]]: because each virtual page maps independently to a physical frame, two different processes' page tables can point different virtual pages at the exact same physical frame.

```
Process A's page 5 → Frame 100 (shared library code)
Process B's page 3 → Frame 100 (same shared library)
```

Multiple virtual addresses (from different processes, or even different virtual pages within the same process) can map to the same physical frame. This allows processes to share common code and libraries — for example, a shared C standard library only needs to exist once in physical RAM, no matter how many processes are linked against it, since each process's page table simply points its own virtual pages at that one shared physical frame. This was impossible under [[Base and Bounds]], which only permitted a single, private contiguous physical region per process with no mechanism for overlap.

## Related
- [[Virtual Addresses]] — the parent mechanism enabling easy sharing
- [[No Sharing Problem]] — the base and bounds problem this solves
- [[Page Protection]] — shared pages typically use read-only permissions to protect against one process corrupting shared code for others

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Easy Sharing | Shared memory mapping / copy-on-write sharing |
