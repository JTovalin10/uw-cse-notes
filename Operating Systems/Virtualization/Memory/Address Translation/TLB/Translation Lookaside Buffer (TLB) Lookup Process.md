# How TLB Works
- when your process tries to access a virtual address
	- check TLB: the hardware checks the TLB first
		- TLB hit
			- if translation is found, the hardware extracts the PFN instantly
		- TLB miss
			- if not found then it needs to go into ram, read the page table, find the PFN, and insert into TLB for next time
