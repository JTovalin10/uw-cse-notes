# CSE451: Page Table Entry Anatomy

## Structure
The page table is an array of entries. Each **Page Table Entry (PTE)** contains the **physical frame number (PFN)** plus several critical status bits that the **[[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit (MMU)]]** checks on every translation:

- **Valid bit**
	- Does this virtual page exist?
	- If a process tries to access an invalid page (valid = 0), the OS raises a trap, a **[[Operating Systems/Virtualization/Memory/Page Fault|segfault]]**.
- **Protection bit**
	- Read/write/execute permissions.
	- Can this code write to this page? If not, segfault.
- **Present bit**
	- Is the page currently in RAM, or has it been swapped out to the hard disk?
	- If 0, it triggers a **[[Operating Systems/Virtualization/Memory/Page Fault|page fault]]**.
- **Dirty bit**
	- Has this page been modified since it was brought into memory?
	- Important for saving changes back to disk before the frame is reused.
- **Accessed bit**
	- Has this page been read recently?
	- Used to decide which page to evict when RAM is full.

## Why Each Bit Exists
Each of these bits answers a distinct question the MMU must resolve before it can safely hand back a translated address, which is why they are packed together into a single entry rather than checked separately:
- The **valid bit** distinguishes "this virtual page was never mapped" from "this virtual page is mapped but currently elsewhere," which is the difference between a genuine programming error (segfault) and a normal, recoverable event (page fault).
- The **protection bit** enforces that even a validly-mapped page cannot be abused — for example, a read-only code page cannot be written to, even by the process that owns it, catching bugs like writing through a bad pointer into program text.
- The **present bit** is what makes demand paging possible: the OS can pretend a page is mapped (valid = 1) while its actual data lives on disk (present = 0), and only pull it into RAM when it's actually touched.
- The **dirty** and **accessed bits** exist purely to make eviction decisions cheap: without them, the OS would have no fast way to know which pages are safe to discard versus which need to be written back to disk first, or which pages are cold enough to be reclaimed.

## Visual Layout
See **[[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Structure Diagram|Page Table Structure Diagram]]** for a diagram showing these bits laid out as columns in the page table array, alongside worked examples of valid, invalid, and swapped-out entries.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page Table Entry (PTE) | Page table entry (standard term) |
| Valid bit | Present/valid bit (terminology varies by architecture) |
| Present bit | Present bit (x86 terminology) |
| Dirty bit | Dirty/modified bit |
| Accessed bit | Accessed/reference bit |

## Related
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Structure Diagram|Page Table Structure Diagram]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Translation Steps|Page Table Translation Steps]]
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Memory Management Unit|Memory Management Unit]]
