# CSE451: Memory Management

## Goals
1. allocate memory among competing processes, maximizing memory utilization and system throughput
2. provide memory isolation between processes
3. provide a convenient abstraction of memory for programming (and compilers)

## Concepts
- [[CSE451/Virtualization/Memory/Virtual Memory|Virtual Memory]] - each process gets its own isolated address space
- [[CSE451/Virtualization/Memory/Concepts/Virtual Addresses|Virtual Addresses]] - processes use virtual addresses independent of physical location
- [[CSE451/Virtualization/Memory/Concepts/Multiprogramming|Multiprogramming]] - multiple processes in memory at once
- [[CSE451/Virtualization/Memory/Concepts/Swapping|Swapping]] - saving/restoring entire process state to disk
- [[CSE451/Virtualization/Memory/Concepts/Embedded Systems|Embedded Systems]] - single-program environments using physical addresses directly

## Address Translation
- [[CSE451/Virtualization/Memory/Address Translation/Address Translation|Address Translation]] - mapping virtual page numbers to physical frame numbers via page tables
- [[CSE451/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]] - hardware cache for fast virtual-to-physical lookups
- [[CSE451/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]] - base and limit registers for address protection

## Memory Models
- [[CSE451/Virtualization/Memory/Memory Models/Fixed Partitions|Fixed Partitions]] - static, fixed-size memory regions
- [[CSE451/Virtualization/Memory/Memory Models/Variable Partitions|Variable Partitions]] - dynamic, process-sized memory regions
- [[CSE451/Virtualization/Memory/Memory Models/Paging|Paging]] - fixed-size pages eliminating external fragmentation

## Tools
- base and limit registers; [[CSE451/Virtualization/Mechanisms/Memory/Base and Bounds|Base and Bounds]]
- swapping [[CSE451/Virtualization/Processes/Memory/swap space|swap space]]
- paging (page tables and [[CSE451/Virtualization/Memory/Address Translation/Translation Lookaside Buffer (TLB)|Translation Lookaside Buffer (TLB)]])
- segmentation (segment tables)
- page faults => page fault handling => virtual memory

# Related
- [[CSE333/Memory Management/Malloc and Free|Malloc and Free (333)]]
- [[CSE333/Memory Management/Heap Management|Heap Management (333)]]
- [[Memory Allocation|Memory Allocation (351)]]
- [[CSE351/Memory Management/Virtual Memory|Virtual Memory (351)]]
