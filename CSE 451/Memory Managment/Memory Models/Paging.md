- solves external fragmentation problem by using fixed sized units in both physical and virtual memory
- mitigate the internal fragmentation problem by making the units small
- ![[Screenshot 2026-02-11 at 12.07.29 PM.png]]

## How do we use this
#### Programmer
- processes view memory as continuous address space from byte 0 through N - a virtual address space
- N is independent of the actual hardware
- in reality, virtual pages are scattered across physical memory frames - not continuous as earlier
	- virtual-to-physical mapping
	- this mapping is invisible to the program

#### memory manager
efficient use of memory because little interel fragmentation
no external fragmentation at all

#### For the protection system
one process cannot "name" another process's memory - there is complete isolation