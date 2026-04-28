# Anatomy of Page Table Entry
The page table is an array of entries. Each entry (PTE) contains the physical frame number (PFN) plus several critical "status bits"
- valid bit
	- does this virtual page exist?
	- if a process tries to access an invalid page (valid=0), the OS raises a trap (segfault)
- protection bit
	- read/write/execute permissions
	- can this code write to this page, if not segfault
- present bit
	- is the page currently in RAM or has it been swapped out to the hard disk
	- if 0 it triggers page fault
- dirty bit
	- has this page been modified since it was brought into memory
	- important for saving changes back to disk
- accessed bit
	- has this page been read recently
	- used to decide which page to kick out when RAM is full
