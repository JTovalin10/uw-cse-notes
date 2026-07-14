# CSE451: Fixed Partitions

**Fixed Partitions**: a memory management scheme in which physical memory is broken up into fixed partitions ahead of time. When a process asks for memory, the OS asks: "Are we within limits? Yes? Here you go." However, if a process wants a partition larger than any partition available, it doesn't get it.

## Mechanism
- Partitions have different sizes but never change once physical memory is divided up.
- Hardware requirements: **[[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]]**, i.e. a base register and a limit register.
	- physical address = virtual address + base register
	- the base register is loaded by the OS when it switches to a process, so each process is transparently relocated into its assigned partition.

## Trade-offs

**Advantage**
- Simple: the check is just a bounds comparison plus an addition.

**Disadvantage**
- **Internal fragmentation**: the available partition is larger than what was requested, so the leftover space inside the partition is wasted.
	- Example: a process asks for 64 bytes and is granted a 128-byte partition (64 bytes wasted).
- **External fragmentation**: the pattern of partition sizes may not match the pattern of job sizes — e.g. two small partitions are free but one big job needs to run, and neither small partition (nor their sum, since they aren't contiguous in a usable way) can satisfy it. This raises the question of what size each partition should have been chosen to be.

![[Screenshot 2026-02-11 at 11.57.51 AM.png]]

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Fixed Partitions | Static memory partitioning |

## Related
- [[Operating Systems/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]] — the dynamic-sized alternative that solves internal fragmentation at the cost of a different external fragmentation problem
- [[Operating Systems/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]] — the hardware mechanism fixed partitions rely on
- [[Operating Systems/Virtualization/Memory/Memory Models/Segmentation|Segmentation]] — the next step in the progression, using many base-and-bounds pairs per process
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] — the fixed-size-unit scheme that eliminates external fragmentation entirely
