# CSE451: Virtual Memory

## What is it
The memory allocated for each process is "virtual," where each process thinks it has the entire memory space to itself

## What it provides
- efficient use of hardware (real memory)
	- VM enables programs to execute without requiring their entire address space to be in physical memory
	- many programs don't need all their code or data at once
	- no need to allocate memory for it, OS should adjust amount allocated based on run-time behavior
- program flexibility
	- programs can execute on machines with less RAM than they "need"
		- paging can be slow
- protection
	- virtual memory isolates processes from each other
	- one process cannot name addresses visible to others; each process has its own isolated address space

## How can we achieve this
- [[Memory Management Unit]]
- [[Translation Lookaside Buffer (TLB)]]
- [[Page Table]]
	- [[Page Fault]] handling
- sometimes accompanied by [[swap space]] (swapping) or limited segmentation

# Related
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory (351)]]
- [[CSE351/Memory Management/Paging|Paging (351)]]
- [[CSE451/Memory Management/Memory management|OS Memory Management (451)]]
- [[CSE451/Virtual Memory/Paged Virtual Memory|Paged Virtual Memory (451)]]