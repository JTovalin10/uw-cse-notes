Like [[Fixed Partitions]] but variable
- physical memory is broken up into partitions dynamically - tailored to the program
	- requirements: base register, limit register [[Base and Bounds]]
	- physical address = virtual address + base register

## Advantage
- no internal fragmentation
	- simply allocate partition size to be just big enough for the process (assuming we know what that is!)

## Disadvantage
- external fragmentation
	- as we load and unload jobs, holes are left scattered throughout physical memory
	- slightly different than the external fragmentation for fixed partition systems
![[Screenshot 2026-02-11 at 12.00.29 PM.png]]
## Dealing with fragmentation
Compact memory by copying
1. swap a program out
2. re-load it, adjacent to another
3. adjust its base register
4. repeat
![[Screenshot 2026-02-11 at 12.01.30 PM.png]]