# CSE451: Variable Partitions

**Variable Partitions**: like **[[Operating Systems/Virtualization/Memory/Memory Models/Fixed Partitions|Fixed Partitions]]** but the partition sizes are variable rather than fixed in advance.

## Mechanism
- Physical memory is broken up into partitions dynamically, tailored to the size of the program being loaded.
- Hardware requirements: base register and limit register, i.e. **[[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]]**.
	- physical address = virtual address + base register

## Trade-offs

**Advantage**
- No internal fragmentation: simply allocate the partition size to be just big enough for the process (assuming we know what that size is in advance).

**Disadvantage**
- **External fragmentation**: as we load and unload jobs, holes are left scattered throughout physical memory. This is slightly different from the external fragmentation problem in fixed partition systems, because here the holes are a byproduct of jobs coming and going rather than a fixed, pre-determined partition layout.

![[Screenshot 2026-02-11 at 12.00.29 PM.png]]

## Dealing with Fragmentation
Compact memory by copying:
1. Swap a program out.
2. Re-load it, adjacent to another program already in memory.
3. Adjust its base register to reflect the new location.
4. Repeat for the remaining programs until the holes are consolidated into one contiguous free region.

![[Screenshot 2026-02-11 at 12.01.30 PM.png]]

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Variable Partitions | Dynamic memory partitioning |
| Compaction | Memory compaction / defragmentation |

## Related
- [[Operating Systems/Virtualization/Memory/Memory Models/Fixed Partitions|Fixed Partitions]] — the fixed-size predecessor to this scheme
- [[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]] — the hardware mechanism variable partitions rely on
- [[Operating Systems/Virtualization/Memory/Memory Models/Segmentation|Segmentation]] — extends variable partitions to multiple segments per process
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — solves external fragmentation by using fixed-size units instead
