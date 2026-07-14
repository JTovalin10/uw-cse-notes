# CSE451: Dynamic Growth

**Dynamic growth** is one of the ways [[Virtual Addresses]] fix the [[Limited Growth]] problem of [[Base and Bounds]]: because pages are mapped individually rather than as one contiguous region, a process's heap or stack can grow simply by adding new page table entries, without needing to move any existing memory.

```
Heap needs more space?
→ Allocate new page, add entry to page table
→ No need to move existing pages
```

When a process's heap needs more space, the OS allocates a new physical frame, adds a new entry to the process's page table mapping the next virtual page to that frame, and the heap can continue to grow. Since each page is independently mapped, this new page does not need to be physically adjacent to the process's existing pages — the virtual address space appears contiguous to the process even though the underlying physical frames are scattered. This completely avoids the expensive [[Relocation Nightmare]] that base and bounds required whenever a process outgrew its fixed allocation.

## Related
- [[Virtual Addresses]] — the parent mechanism enabling dynamic growth
- [[Limited Growth]] — the base and bounds problem this solves
- [[Relocation Nightmare]] — the costly alternative this avoids
- [[Demand Paging]] — the related mechanism for lazily allocating frames

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Dynamic Growth | Dynamic memory allocation via paging |
