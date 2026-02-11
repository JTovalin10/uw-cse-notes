## Goals
1. allocate memory among competing processes, maximizing memory utilization and system throughput
2. provide memory isolation between processes
3. provide a convenient abstraction of memory for programming (and compilers)
## Tools
- base and limit registers; [[Base and Bounds]]
- swapping [[swap space]]
- paging (page tables and [[Translation Lookside Buffer]])
- segmentation (segment tables)
- page faults => page fault handling => virtual memory