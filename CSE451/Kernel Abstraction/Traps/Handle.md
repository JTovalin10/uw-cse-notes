# what is it
## Core Idea
We never want to expose the kernel address to the user, unless you want trouble
# How do we avoid it
We use a handle to indicate a kernel object. It can be as simple as an assigned number or a seemingly arbitrary number.
- EX:
	- [[Process ID]]
- In the kernel a handle table binds each handle to its corresponding kernel data structure
![[Pasted image 20260116002710.png]]
