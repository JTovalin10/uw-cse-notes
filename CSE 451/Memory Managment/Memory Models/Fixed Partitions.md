physical memory is broken up into fixed partitions. it asks "are we within limits, yes? here you go" however if someone wants a partition that is larger than what we have then they dont get it
- hvae different sizes but never changes
- hardware requirements: [[Base and Bounds]], base and limit register
	- physical address = virtual address + base register
	- base register loaded by OS when it switches to a process

**Advantage**
simple

**Disadvantage**
- internal fragmentation: the available partition is large then what was requested
	- asked for 64 bytes and you got 128 bytes (waste)
- external fragmentation: two small partitions left, but one bug job - what size should the partition be

![[Screenshot 2026-02-11 at 11.57.51 AM.png]]