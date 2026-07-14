# CSE451: Segmentation

**Segmentation**: a memory management scheme that partitions an address space into logical units — stack, code, heap, subroutines — rather than a single contiguous block. A virtual address under segmentation is a pair: a segment number and an offset within that segment.

## Motivation
Segmentation is more logical than a single partition per process because a linker takes a bunch of independent modules that call each other and linearizes them into one address space. If the modules are really independent, segmentation treats them as such by giving each one its own segment, rather than forcing them into one flat region.

- Facilitates sharing and reuse: a segment is a natural unit of sharing (e.g. a shared code segment can be mapped into multiple processes).
- Natural extension of **[[Operating Systems/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]]**:
	- variable-sized partition = 1 segment per process
	- segmentation = many segments per process

## Hardware Support
The hardware provides a segment table which has:
1. Multiple **[[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]]** pairs, one per segment.
2. Each segment is named by a segment number, used as an index into the segment table.
	- the virtual address is `<segment #, offset>`
3. The offset portion of the virtual address is added to the base address of the indexed segment to yield the physical address.

## Segment Lookup Example
![[Pasted image 20260213135626.png]]

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Segmentation | Segmentation (still standard); related to logical addressing |
| Segment table | Segment descriptor table |

## Related
- [[Operating Systems/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]] — the one-segment-per-process predecessor to segmentation
- [[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]] — the hardware primitive segmentation multiplies, one pair per segment
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — the fixed-size-unit alternative that eliminates external fragmentation
- [[Operating Systems/Virtualization/Memory/Memory Models/Segment and Paging|Segment and Paging]] — combines segmentation's logical units with paging's fixed-size chunks
