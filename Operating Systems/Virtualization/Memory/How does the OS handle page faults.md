1. [[Page Fault]] causes system to be entered system saves state of running process, then vectors to the page fault handler routine
	1. find or create (through eviction) a page frame into which to load the needed page
		1. if I/O is required, run some other process while it's going on
		2. run page replacement algorothm
			1. free page frame
			2. assigned but clean page frame
			3. assigned and dirty page frame
		3. assigned but clean
			1. find PTE (may be differerent process)
			2. mark as invalid (disk address must be avaliable for subsequent reload)
		4. assigned and dirty
			1. find PTRE
			2. mark as invalid
			3. write it out
		5. OS may spectulatively maintain list of clean and dirty frames selected for replacement
			1. may also speculatively clean the dirty pages by writing them to disk
	2. find the needed page on disk and bring it onto the page frame
		1. run some other process while the I/O is going on
		2. 1. processor makes process ID and faulting virtual address avaliable to page fault handler
		3. process ID gets you to the base of the page table
		4. VPN portion of VA gets you to the PTE
		5. data structure analogous to page tavle contains disk address of page
		6. I/O
			1. we must be positive that the target page frame remains avaliable
	3. fix up the page table entry
		1. mark it as "valid" set "referenced" and "modified" bit to false, set protection bits appropriately, point to correct page frame
	4. put the process on the ready queue
2. find the needed page on disk and bring it into the page frame

## Issues
1. memory reference overhead of address translation
	1. 2 references per address lookup (page table then memory)
	2. solution: use hardware cache (TLB)
2. memory required to hold page tables can be huge