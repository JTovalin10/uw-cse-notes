# CSE451: Page Table Entries

A **[[Operating Systems/Virtualization/Memory/Memory Models/Paging|Page Table]]** is composed of individual entries, one per virtual page. We can add functionality to each entry beyond a bare virtual-to-physical mapping:

1. **Protection**
	1. A virtual page can be marked read-only, causing a fault if a store to it is attempted.
	2. A fault will also occur if a reference is made to a page that doesn't map to anything.
2. **Accounting information**
	1. Must be checkable fast, since address translation itself must be fast.
	2. Can keep track of whether or not a virtual page is being used.

## Format
![[Pasted image 20260213134716.png]]

**[[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entry (PTE)]]** control mapping:
- **V**: the valid bit checks if the PTE can be used.
	- Says whether or not a virtual address is valid.
	- It is checked each time a virtual address is used.
- **R**: reference bit checks whether the page has been accessed.
	- It is set when a page has been read from or written to.
- **M**: modified bit checks if the page is dirty.
	- It is set when a write to the page has occurred.
- **prot**: protection bits which check which operations are allowed.
	- Read, write, execute.
- **page frame number (PFN)**: determines the physical page.
	- physical page start address = PFN

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page Table Entry (PTE) | Page table entry (standard term) |
| V (valid bit) | Present/valid bit (terminology varies by architecture) |
| R (reference bit) | Accessed/reference bit |
| M (modified bit) | Dirty bit |

## Related
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — the scheme that populates and consults these entries
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]] — a deeper, formalized treatment of each status bit and why it exists
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]] — triggered when the valid or present bit indicates the page isn't usable
- [[Operating Systems/Virtualization/Memory/Page Replacement/LRU|LRU]] — uses the reference bit to approximate least-recently-used tracking
- [[Operating Systems/Virtualization/Memory/Page Replacement/LRU Clock|LRU Clock]] — sweeps and clears the reference bit as its core mechanism
