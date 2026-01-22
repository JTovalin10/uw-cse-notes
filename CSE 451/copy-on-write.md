retain the original semantics, but copies only what is necessary rather than the entire address state
- on fork
	- create a new address space
	- initialize page tables with same mappings as the parents
		- they both point to the same physical memory
			- no copying of address space contents have occurred at this point - with the sole exception of the top page of the stack
	- set both parent and child page tables to make all pages read-only
	- if either parent or child writes to memory, an exception occurs
	- if an exception occurs, OS copies the page and adjusts