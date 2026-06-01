# What does Page Table do
Every process (application) believes it has a huge chunk of contiguous memory all to itself, usually starting at address 0
- virtual memory
	- the fake perfect view of memory the process sees
- physical memory
	- the messy scattered reality of where data actually lives in ram hardware

The OS chops memory into fixed-size blocks called **pages**
- virtual page
	- a block in the process's view
- physical frame
	- the corresponding block in actual ram
- the page table is the dictionary that says *virtual page 1 maps to physical frame 10*
