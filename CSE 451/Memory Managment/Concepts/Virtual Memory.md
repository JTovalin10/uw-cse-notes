## what is it
the memory allocated for each process is "virtual" where each process thinks they have the entire memory space to itself

## What it provides
- efficient use of hardware (real memory)
	- VM enables programs to execute without requires their entire address space to be in physical memory
	- many programs don't need all their code or data at once
	- no need to allocate memory for it, OS should adjust amount alloced based on run-time behavior
- program flexibility
	- programs can execute on machines with less RAM than they "need"
		- paging can be slow
- protection
	- virtual memory isolate from each other
	- One process cannot name addresses visible to others; each process has its own isolated address space
## How can we achieve this
- [[Memory Management Unit]]
- [[Translation Lookside Buffer]]
- [[Page Table]]
	- [[Page Fault]] handling
- sometimes accompanied by [[swap space]] (swapping) or limited segmenrtation