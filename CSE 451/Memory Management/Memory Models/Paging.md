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
	- need one PTE per page in virtual address space
	- page the page tables

- solves external fragmentation problem by using fixed sized units in both physical and virtual memory
- mitigates the internal fragmentation problem by making the units small
- ![[Screenshot 2026-02-11 at 12.07.29 PM.png]]

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