We can combine [[Segmentation]] and [[CSE451/Memory Management/Memory Models/Paging]]
- use segments to manage logical units
	- segments vary in size but are typically large
- use pages to partition segments into fixed-size chunks
	- each segment has its own page table
		- there is a page table per segment
	- memory allocation becomes easy once again
		- no contiguous allocation, no external fragmentation
![[Pasted image 20260213135817.png]]
![[Pasted image 20260213135837.png]]