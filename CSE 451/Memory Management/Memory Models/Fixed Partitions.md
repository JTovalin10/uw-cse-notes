Physical memory is broken up into fixed partitions. It asks "are we within limits, yes? here you go" however if someone wants a partition that is larger than what we have then they don't get it
- have different sizes but never change
- hardware requirements: [[Base and Bounds]], base and limit register
	- physical address = virtual address + base register
	- base register loaded by OS when it switches to a process

**Advantage**
simple

**Disadvantage**
- internal fragmentation: the available partition is larger than what was requested
	- asked for 64 bytes and you got 128 bytes (waste)
- external fragmentation: two small partitions left, but one big job - what size should the partition be

![[Screenshot 2026-02-11 at 11.57.51 AM.png]]