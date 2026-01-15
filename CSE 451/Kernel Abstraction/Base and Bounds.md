## what are they
- base
	- Starting physical address where a process's memory begins
- bound
	- Either the size of the allocated region OR the ending address
ex:
```c++
physical_addr = base + virtual_addr
if (virtual_addr >= bounds) { SEGFAULT; }
```
## problems with them
1. internal fragmentation
	1. process needs 7kb but os allcoates 8kb parition. 1kb is unused
2. external fragmentation
	1. free memory exists but is scattered in usuable chunks
```
	   Memory: [Process A: 4KB][FREE: 2KB][Process B: 4KB][FREE: 2KB]
New Process C needs 3KB → Can't fit despite 4KB total free
```
3. no sharing
	1. cannot share common code/libraries between processes
4. limited growth
```
	Process at base=1000, bounds=4KB
Stack wants to grow down, heap wants to grow up
→ Stuck with 4KB forever, can't expand
```
5. Relocation Nightmare
	1. to defragent or make space you need to (expensive and creates system pauses)
		1. pause the process
		2. copy entire memory region
		3. update base pointer
		4. resume process
These are fixed with [[Virtual Addresses]]