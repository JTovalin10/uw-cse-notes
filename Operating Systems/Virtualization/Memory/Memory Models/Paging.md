# CSE451: Paging

**Paging** is a memory management scheme that eliminates the need for contiguous allocation of physical memory. It works by dividing virtual memory into **[[Operating Systems/Virtualization/Memory/What is a Page|Pages]]** and physical memory into **Frames**.

## Advantages
Easy to allocate physical memory
- physical memory is allocated from a free list of frames
	- to allocate a frame, just remove it from the free list
- external fragmentation is not a problem
	- managing variable sized allocations is hard
- naturally leads to virtual memory
## Disadvantages
- can still have internal fragmentation
	- processes may not use memory in exact multiples of pages
	- minor because small page sizes relative to address space size
- memory reference overhead
	- 2 references per address lookup (page table, then memory)
	- use TLB as a hardware cache
- memory required to hold page tables can be large
	- need one **[[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entry (PTE)]]** per page in the virtual address space
	- solution: page the page tables themselves

Overall, paging solves the external fragmentation problem by using fixed-sized units in both physical and virtual memory, and mitigates the internal fragmentation problem by making those units small.

![[Screenshot 2026-02-11 at 12.07.29 PM.png]]

## How do we use this
#### Programmer
- processes view memory as a contiguous address space from byte 0 through N - a virtual address space
- N is independent of the actual hardware
- in reality, virtual pages are scattered across physical memory frames - not contiguous
	- virtual-to-physical mapping
	- this mapping is invisible to the program

#### Memory manager
Efficient use of memory because little internal fragmentation
No external fragmentation at all

#### For the protection system
One process cannot "name" another process's memory - there is complete isolation

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Paging | Paging / paged virtual memory |
| Frame | Physical page frame |

## Related
- [[Operating Systems/Virtualization/Memory/What is a Page|What is a Page]] — defines pages, frames, VPN/PFN
- [[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entries]] — the per-page metadata paging relies on
- [[Operating Systems/Virtualization/Memory/Memory Models/Segmentation|Segmentation]] — the logical-unit scheme paging is often combined with
- [[Operating Systems/Virtualization/Memory/Memory Models/Segment and Paging|Segment and Paging]] — the combined scheme
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page replacement|Page Replacement]] — how the OS chooses which frame to reclaim when physical memory is full
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]] — the trap raised when a referenced page is not currently mapped to a frame