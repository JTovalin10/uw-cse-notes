# CSE451: Thrashing

**Thrashing** occurs when the system spends most of its time servicing **[[Page Fault|page faults]]** rather than doing useful work — the CPU is busy paging pages in and out of memory instead of executing process instructions.

## Causes

Thrashing is not a single problem with a single cause; it can arise from either side of the memory-management equation:

- **A lousy replacement algorithm**: even if there is enough memory overall, a poor **[[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|page replacement algorithm]]** can repeatedly evict pages that are about to be referenced again, forcing the OS to keep re-faulting on the same pages it just threw out.
- **Too many active processes**: if too many processes are competing for a fixed amount of physical memory, each process's **[[Working set of program behavior|working set]]** cannot fully fit in RAM at the same time. As more processes are added, each one is squeezed into fewer frames than its working set needs, so it faults constantly trying to keep its working set resident.

## Why It Matters

Thrashing represents a collapse in system throughput: instead of the additional multiprogramming (more active processes) improving CPU utilization, the overhead of constant page faults (trap to kernel, evict a frame, do disk I/O, fix up the PTE, restart the instruction) dominates, and useful work grinds to a near-halt. This is the core tension that motivates the **[[Working set of program behavior|working set model]]** and demand-driven memory allocation schemes like **[[Page Fault Frequency]]** — both try to give each process enough frames to hold its working set, so it can run without constantly faulting, while not over-allocating frames that a process doesn't need.

## Related
- [[Page Fault]]
- [[Working set of program behavior]]
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|Page replacement]]
- [[Page Fault Frequency]]

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Thrashing | Thrashing (standard term) |
| Active processes | Degree of multiprogramming |
