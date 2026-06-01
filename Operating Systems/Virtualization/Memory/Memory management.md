# CSE451: Memory Management

## Goals
1. allocate memory among competing processes, maximizing memory utilization and system throughput
2. provide memory isolation between processes
3. provide a convenient abstraction of memory for programming (and compilers)

## Concepts
- [[Operating Systems/Virtualization/Memory/Virtual Memory|Virtual Memory]] - each process gets its own isolated address space
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] - processes use virtual addresses independent of physical location
- [[Multiprogramming|Multiprogramming]] - multiple processes in memory at once
- [[Swapping|Swapping]] - saving/restoring entire process state to disk
- [[Embedded Systems|Embedded Systems]] - single-program environments using physical addresses directly

## Address Translation
- [[Address Translation|Address Translation]] - mapping virtual page numbers to physical frame numbers via page tables
- [[Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]] - hardware cache for fast virtual-to-physical lookups
- [[Base and Bounds|Base and Bounds]] - base and limit registers for address protection

## Memory Models
- [[Fixed Partitions|Fixed Partitions]] - static, fixed-size memory regions
- [[Variable Partitions|Variable Partitions]] - dynamic, process-sized memory regions
- [[Operating Systems/Virtualization/Memory/Memory Models/Paging|Paging]] - fixed-size pages eliminating external fragmentation

## Tools
- base and limit registers; [[Base and Bounds|Base and Bounds]]
- swapping [[swap space|swap space]]
- paging (page tables and [[Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]])
- segmentation (segment tables)
- page faults => page fault handling => virtual memory

# Related
- [[Malloc and Free|Malloc and Free (333)]]
- [[Systems Programming/Memory Management/Heap Management|Heap Management (333)]]
- [[Memory Allocation|Memory Allocation (351)]]
- [[Hardware & Software Interface/Memory Management/Virtual Memory|Virtual Memory (351)]]
