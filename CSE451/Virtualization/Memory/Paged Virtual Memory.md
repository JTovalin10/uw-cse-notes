Not all pages of an address space need to reside in memory
- the full (used) address space exists on secondary storage (disk) in page-sized blocks
- the OS uses main memory as a (page) cache
- a page that is needed is transferred to a free page frame
- if there are no free page frames, a page must be evicted
	- evicted pages go to disk (only need to write if they are dirty — checked via the dirty/modified bit in the [[Page Table Entries|PTE]])
- all of this is transparent to the application (except for performance)
	- managed by hardware and OS

## How it works
1. process tries to access a virtual address
2. the [[Translation Lookaside Buffer (TLB)|TLB]] / [[Page Table]] is consulted for the translation
3. the valid bit in the [[Page Table Entries|PTE]] is checked
	- if valid = 1 and present = 1 → normal access, no fault
	- if valid = 1 and present = 0 → the page exists but is on disk → [[Page Fault]]
	- if valid = 0 → the page doesn't exist → segmentation fault
4. on a [[Page Fault]], the OS handles it:
	1. trap to the kernel
	2. find the page on disk
	3. find a free frame (or evict one — only write back if the [[Page Table Entries|PTE]] dirty bit is set)
	4. load the page into the frame
	5. update the [[Page Table Entries|PTE]] to point to the new frame and set present = 1
	6. restart the faulting instruction

## Can a single instruction cause multiple page faults?
Yes. A single instruction can trigger more than one page fault:
- the instruction itself might span a page boundary (fetching it faults on the second page)
- the instruction may reference a memory operand on a different page (data fault)
- instructions like `mov` with both a source and destination in memory can fault on each
- on x86, pushing to the stack during a `CALL` can fault if the stack page isn't present

In the worst case a single instruction can cause 2+ page faults (instruction fetch + data access(es)), but the hardware restarts the instruction after each fault is resolved.

![[Pasted image 20260213142044.png]]
