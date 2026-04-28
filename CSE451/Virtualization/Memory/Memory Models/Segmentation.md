With segmentation we can partition an address space into logical units
- stack, code, heap, subroutines
A virtual address is a segment # and offset

## What's the point
Segmentation is more logical as a linker takes a bunch of independent modules that call each other and linearizes them. If they are really independent then segmentation treats them as such

- facilitates sharing and reuse
	- a segment is a natural unit of sharing
- natural extension of variable sized partitions
	- variable-sized partition = 1 segment/process
	- segmentation = many segments/process

## Hardware support
The hardware provides a segment table which has:
1. multiple [[Base and Bounds]], one per segment
2. segment named by segment #, used as index into table
	1. virtual address is <segment #, offset>
3. offset of virtual address added to base address of segment to yield physical address

## Segment lookups
![[Pasted image 20260213135626.png]]