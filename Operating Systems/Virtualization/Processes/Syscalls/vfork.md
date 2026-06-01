
Instead of "child address space is a copy of the parent's", the semantics are "child's address space is the parent's"
- with a promise that the child won't modify the address space before doing an execve()
	- however this is unenforced
- when execve() is called, a new address space is created and it's loaded with the new executable
- parent is blocked until execve() is executed by child
- saves wasted effort of duplicating parent's address space, just to throw it away
# Issues
if multithreading is the goal then we have to deal with
- two instruction and stack pointers
- two handle tables
- two page tables
## COW
instead of copying memory the OS shares but sets a trap
- shared mapping
	- the OS gives the child a new page table, but it points at the exact same physical memory as the parent
- READ ONLY PROTECTION
	- the OS marks those pages as read-only in both the parent and child's page table — even if that part is usually writable (stack or heap)
- trigger
	- as long as both processes only read the data, nothing happens. they share the same physical ram
- the write exception
	- the moment either process tries to write to a page, the hardware triggers a [[Page Fault]]
- the copy
	- the kernel sees the fault, realizes its a COW page, and only then does it make a private copy of that specific 4KB page for the process that tried to write
### Gotchas
1. Isolation vs shared
	1. COW provides the illusion of isolation
	2. to the programmer it feels like the child has its own memory but under the hood the OS keeps it shared as long as possible to save resources
	3. with COW, the OS must create a second set of page tables which while the RAM isnt copied the metadata is. if a process has a massive address space, copying the page table can be slow
![[Pasted image 20260116012004.png]]
