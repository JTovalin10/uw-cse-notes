## Goals
1. allocate memory among competing processes, maximizing memory utilization and system throughput
2. provide memory isolation between processes
3. provide a convenient abstraction of memory for programming (and compilers)

## Concepts
- [[CSE451/Virtual Memory/Virtual Memory]] - each process gets its own isolated address space
- [[CSE451/Memory Management/Concepts/Virtual Addresses]] - processes use virtual addresses independent of physical location
- [[Multiprogramming]] - multiple processes in memory at once
- [[Swapping]] - saving/restoring entire process state to disk
- [[Embedded Systems]] - single-program environments using physical addresses directly

## Address Translation
- [[Address Translation]] - mapping virtual page numbers to physical frame numbers via page tables
- [[Translation Lookaside Buffer (TLB)]] - hardware cache for fast virtual-to-physical lookups
- [[Base and Bounds]] - base and limit registers for address protection

## Memory Models
- [[Fixed Partitions]] - static, fixed-size memory regions
- [[Variable Partitions]] - dynamic, process-sized memory regions
- [[CSE451/Memory Management/Memory Models/Paging]] - fixed-size pages eliminating external fragmentation

## Tools
- base and limit registers; [[Base and Bounds]]
- swapping [[swap space]]
- paging (page tables and [[Translation Lookaside Buffer (TLB)]])
- segmentation (segment tables)
- page faults => page fault handling => virtual memory
