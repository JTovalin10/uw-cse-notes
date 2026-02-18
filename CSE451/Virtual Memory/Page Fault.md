A page fault is a hardware [[Exception]] that occurs when a running program tries to access a virtual page that is not currently present in physical RAM

## What triggers it
- the [[Page Table Entries|PTE]] has valid = 1 but present = 0 (page exists but is on disk)
- the hardware cannot complete the address translation and traps to the OS

## What happens
1. CPU traps to the kernel (page fault handler)
2. OS looks up the faulting virtual address to find where the page lives on disk
3. OS selects a free physical frame (or evicts one using a page replacement policy)
	- if the evicted page is dirty (modified bit set in the [[Page Table Entries|PTE]]), it must be written back to disk first
4. OS reads the needed page from disk into the free frame
5. OS updates the [[Page Table]] entry: sets PFN to the new frame, sets present = 1
6. OS restarts the faulting instruction — this time the translation succeeds

## Types
- **minor (soft) page fault** — the page is already in memory (e.g. shared by another process or in a buffer cache), no disk I/O needed
- **major (hard) page fault** — the page must be read from disk, much slower