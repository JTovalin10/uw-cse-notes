# CSE451: Base and Bounds

**Base and bounds** (also called base and limit registers) is the earliest hardware mechanism for memory protection and isolation.

- **Base**: the starting physical address where a process's memory begins
- **Bound (limit)**: either the size of the allocated region or the ending address

```c
physical_addr = base + virtual_addr;
if (virtual_addr >= bounds) { SEGFAULT; }
```

## Problems with Base and Bounds
1. [[Internal Fragmentation]] — process gets more memory than needed
2. [[External Fragmentation]] — free memory exists but is too scattered to use
3. [[No Sharing Problem]] — cannot share common code/libraries between processes
4. [[Limited Growth]] — processes cannot dynamically expand their allocation
5. [[Relocation Nightmare]] — defragmenting memory requires copying and pausing processes

These problems are solved by [[CSE451/Kernel Abstraction/Memory/Virtual Addresses]].

## Related
- [[Simple Memory Protection]] — base and bounds is the primary mechanism
- [[CSE451/Kernel Abstraction/Memory/Virtual Addresses]] — the modern replacement
- [[Fixed Partitions]] — uses base and bounds registers per partition
- [[Variable Partitions]] — also uses base and bounds
- [[Segmentation]] — extends base and bounds with multiple segments per process
