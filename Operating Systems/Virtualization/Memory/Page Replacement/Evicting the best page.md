# CSE451: Evicting the Best Page

See **[[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|Page Replacement]]** for how a frame is freed in general. This file covers how the OS picks *which* page to evict once it's determined that eviction is necessary.

## Goal
1. The best page to evict is one that will never be touched again.
2. "Never" is a long time, so in practice replacement algorithms approximate this: **Belady's proof** shows that evicting the page that won't be used for the longest period of time in the future minimizes the page fault rate — this is the theoretical best case (see **[[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]]**).
3. Every algorithm below is, in some sense, an attempt to approximate that theoretical best case using only information available at eviction time.

## Algorithms
1. **[[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]]** — the optimal, unimplementable baseline.
2. **[[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|Page FIFO]]** — evicts by age alone.
3. **[[Operating Systems/Virtualization/Memory/Page Replacement/LRU|LRU]]** — evicts using recency of reference.
4. **[[Operating Systems/Virtualization/Memory/Page Replacement/LRU Clock|LRU Clock]]** — a cheap approximation of LRU.
5. **[[Operating Systems/Virtualization/Memory/Page Fault Frequency|Page Fault Frequency]]** — adjusts how much memory a process gets based on its fault rate, rather than picking a single victim page.

## Allocation of Frames Among Processes
**[[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|Page FIFO]]** and **[[Operating Systems/Virtualization/Memory/Page Replacement/LRU Clock|LRU Clock]]** can each be implemented as local or global replacement algorithms:
1. **Local**:
	1. Each process is given a limit on the number of pages it can use.
	2. It pages against itself — i.e. it evicts only its own pages, never another process's.
2. **Global**:
	1. The victim is chosen from among all page frames in the system, regardless of which process owns them.
	2. A process's page frame allocation can vary dynamically as a result.

We can also use hybrid algorithms that are both local and global, with an explicit mechanism for adding or removing page frames from a process — including changing the number of frames a process uses over time.

![[Pasted image 20260213202029.png]]

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Local replacement | Per-process (local) page replacement |
| Global replacement | System-wide (global) page replacement |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|Page Replacement]] — the general mechanism for freeing a page (free list vs. eviction)
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]] — the optimal replacement policy used as a comparison baseline
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Anomaly|Belady's Anomaly]] — a counterintuitive failure mode of some replacement algorithms (notably FIFO)
- [[Operating Systems/Virtualization/Memory/Working set of program behavior|Working Set]] — the set of pages a process needs resident to avoid heavy faulting under local allocation
- [[Operating Systems/Virtualization/Memory/Thrashing|Thrashing]] — what happens when frame allocation is too small for the working set
