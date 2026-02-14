to go from virtual to physical we add a level of indirection: [[Page Table]] which translates virtual page to physical frame
## Translating virtual addresses
- a virtual address has two parts: virtual page number and offset
- virtual page number (VPN) is an index into a page table
- page table entry contains page frame number (PFN)
- physical address is PFN::offset (concatenated together)

## Page Tables
- managed by the OS
- one page table entry (PTE) per page in virtual address space
	- one PTE per VPN
- map virtual page number (VPN) to page frame number (PFN)
	- VPN is simply an index into the page table

![[Screenshot 2026-02-11 at 12.15.47 PM.png]]
![[Pasted image 20260213132600.png]]
![[Pasted image 20260213132621.png]]
