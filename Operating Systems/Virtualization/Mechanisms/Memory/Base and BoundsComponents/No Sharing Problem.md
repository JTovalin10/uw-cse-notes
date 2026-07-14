# CSE451: No Sharing Problem

The **no sharing problem** is a limitation of [[Base and Bounds]]-based memory allocation: because each process occupies one single contiguous physical region with no finer-grained mapping, there is no way to let two processes share the same physical memory for common code or libraries.

Each process must have its own private copy of any shared library or common code it uses, since base and bounds offers no mechanism to map two different processes' address spaces onto the same underlying physical memory. This wastes physical memory proportionally to the number of processes using the same library — if 20 processes link against the same C standard library, base and bounds requires 20 separate physical copies.

## Related
- [[Base and Bounds]] — the parent mechanism where this problem arises
- [[Easy Sharing]] — how virtual addressing solves this by mapping multiple virtual pages to one physical frame

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| No Sharing Problem | Lack of memory sharing in contiguous allocation schemes |
