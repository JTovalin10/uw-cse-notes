[[Page Table]]
We can add functionality to each entry
1. we can add protection
	1. a virtual page can be read-only and as a result cause a fault if a store to it is attempted
	2. a fault will occur if a reference to a page that doesn't map to anything is attempted
2. accounting information
	1. must be fast as address translation must be fast
	2. can keep track of whether or not a virtual page is being used
## Format
![[Pasted image 20260213134716.png]]
PTE control mapping
- V: the valid bit that checks if the PTE can be used
	- says whether or not a virtual address is valid
	- it is checked each time a virtual address is used
- R: reference bit checks whether the page has been accessed
	- it is set when a page has been read or written to
- M: modified bit checks if the page is dirty
	- is set when a write to the page has occurred
- prot: protection bits which check which operations are allowed
	- read, write, execute
- page frame number determines the physical page
	- physical page start address = PFN