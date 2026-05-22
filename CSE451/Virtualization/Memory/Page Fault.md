# CSE451: Page Fault

A **Page Fault** is a hardware [[Exceptions|Exception]] that occurs when a running program tries to access a virtual page that is not currently present in physical RAM.

## Triggering Mechanism
- The [[CSE451/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry (PTE)]] has `valid = 1` but `present = 0` (the page exists in the address space but is currently on disk).
- The hardware cannot complete the address translation and traps to the OS.

## Handling Workflow
1. **Trap**: The CPU traps to the kernel (page fault handler).
2. **Disk Lookup**: The OS looks up the faulting virtual address to find where the page lives on disk.
3. **Frame Selection**: The OS selects a free physical frame (or evicts one using a [[CSE451/Virtualization/Memory/Page Replacement/Page replacement|Page Replacement Policy]]).
	- If the evicted page is **Dirty** (modified bit set in the PTE), it must be written back to disk first.
4. **I/O**: The OS reads the needed page from disk into the free frame.
5. **Update**: The OS updates the [[CSE451/Virtualization/Memory/Address Translation/Page Table|Page Table]] entry: sets PFN to the new frame, and sets `present = 1`.
6. **Restart**: The OS restarts the faulting instruction — this time the translation succeeds.

## Types of Page Faults
- **Minor (Soft) Page Fault**: The page is already in memory (e.g., shared by another process or in a buffer cache), so no disk I/O is needed.
- **Major (Hard) Page Fault**: The page must be read from disk, which is significantly slower.

## Related
- [[Page Tables|Page Tables (CSE351)]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory (CSE351)]]
- [[Translation Lookaside Buffer (TLB 351)|TLB (351)]]
- [[Exceptions|Exceptions (351)]]
- [[Context Switching|Context Switching (351)]]
- [[CSE451/Virtualization/Memory/How does the OS handle page faults|How the OS Handles Page Faults]]
- [[CSE451/Virtualization/Memory/Page Replacement/Page replacement|Page Replacement]]
- [[CSE451/Virtualization/Memory/Virtual Memory|Virtual Memory (CSE451)]]