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
1. [[Internal Fragmentation]]
2. [[External Fragmentation]]
3. [[No Sharing Problem]]
4. [[Limited Growth]]
5. [[Relocation Nightmare]]

These are fixed with [[Virtual Addresses]]
