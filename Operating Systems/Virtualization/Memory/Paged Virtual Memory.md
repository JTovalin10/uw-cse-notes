# CSE451: Paged Virtual Memory

**Paged virtual memory** is built on the idea that not all pages of a process's address space need to reside in physical memory at the same time.

- The full (used) address space exists on secondary storage (disk) in page-sized blocks.
- The OS uses main memory as a cache of pages — analogous to how a hardware cache holds a subset of main memory, main memory itself holds only a subset of the address space's pages at any moment.
- A page that is needed is transferred from disk into a free page frame.
- If there are no free page frames, a page must be evicted to make room.
	- Evicted pages only need to be written back to disk if they are dirty — this is checked via the dirty/modified bit in the **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry (PTE)]]**. A clean page's disk copy is already up to date, so it can simply be discarded.
- All of this is transparent to the application, except for the performance impact of the extra disk I/O — it is managed entirely by the hardware ([[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|MMU]]) and the OS.

## How It Works

1. The process tries to access a virtual address.
2. The **[[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]**, or failing that the **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]**, is consulted for the translation.
3. The valid bit in the PTE is checked:
	- If valid = 1 and present = 1 → normal access, no fault.
	- If valid = 1 and present = 0 → the page exists in the address space but currently lives on disk → **[[Page Fault]]**.
	- If valid = 0 → the page doesn't exist in the address space at all → segmentation fault.
4. On a page fault, the OS handles it (see **[[How does the OS handle page faults]]** for the full mechanism):
	1. Trap to the kernel.
	2. Find the page on disk.
	3. Find a free frame (or evict one — only writing back if the PTE's dirty bit is set).
	4. Load the page into the frame.
	5. Update the PTE to point to the new frame and set present = 1.
	6. Restart the faulting instruction.

## Can a Single Instruction Cause Multiple Page Faults?

Yes. A single instruction can trigger more than one page fault:
- The instruction itself might span a page boundary (fetching it faults on the second page).
- The instruction may reference a memory operand on a different page (a data fault).
- Instructions like `mov` with both a source and destination in memory can fault on each operand.
- On x86, pushing to the stack during a `CALL` can fault if the stack page isn't present.

In the worst case a single instruction can cause 2+ page faults (instruction fetch + data access(es)), but the hardware restarts the instruction after each fault is resolved, so the sequence of faults resolves one at a time rather than all at once.

![[Pasted image 20260213142044.png]]

## Related
- [[Page Fault]]
- [[How does the OS handle page faults]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]]
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]]

## Industry Standard Terms
| Course Term | Industry Standard Equivalent |
|---|---|
| Paged Virtual Memory | Demand-paged virtual memory |
| Present bit | Present bit (x86) / valid bit (varies by architecture) |
