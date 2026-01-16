# Page Table Translation Steps
When a process tries to access a variable the cpu cannot use that address directly, it must translate it

1. extract VPN
	1. the hardware (memory management unit) takes the top bits of the virtual address to get the VPN
2. look up
	1. it uses the VPN as an index to look inside the Page Table
3. find PFN
	1. inside the page table, it finds the PFN (physical frame number)
4. calculate
	1. it combines the PFN + original offset to create the final physical address
