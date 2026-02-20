## Page the page tales
![[Screenshot 2026-02-20 at 11.45.31 AM.png]]
## Multi-level page tables![[Screenshot 2026-02-20 at 11.45.50 AM.png]]
with two level PT's, virtual addresses have 3 parts:
1. master page number, secondary page number, offset
2. master PT maps master PN to seconary PT
3. seconary PT maps secondary PN to page frame number
4. offset and PFN yeilds physical address
![[Screenshot 2026-02-20 at 11.46.42 AM.png]]![[Screenshot 2026-02-20 at 11.46.59 AM.png]]
## Alternatives
1. hashed page table (great for sparse address spaces)
	1. VPN is used as hash
	2. collision are resolved because the elements in the linked list at the hash index include the VPN as well as the PFN
2. inverted page table (greatly reduced space)
	1. one entry per page frame
	2. includes process id and VPN
	3. hard to search
	4. cant do copy-on-write