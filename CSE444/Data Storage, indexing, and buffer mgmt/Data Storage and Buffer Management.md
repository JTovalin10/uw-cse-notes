# CSE444: Data Storage and Buffer Management

This section covers how data is physically stored on disk and managed in memory.

## Table of Contents

1. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Disk and Layout|Working with Disk & Storage Layout]] (Seek time, Row vs Column store)
2. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Page and Record Formats|Page & Record Formats]] (Slotted pages, Fixed vs Variable records)
3. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Heap File and LOBs|Heap Files & LOBs]] (Heap file implementations, BLOBs, CLOBs)
4. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Buffer Manager - Eviction and Updates|Buffer Manager]] (Caching, Eviction policies, Dirty pages)

---

## Related
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — how the buffer manager and storage manager fit into the full DBMS architecture
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — heap file API, sorted files, and index structures built on top of heap files
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — CSE344 coverage of disk storage fundamentals
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures built on top of heap files
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — how indices relate to physical data layout
- [[CSE344/Query Execution/External Memory Algorithms|External Memory Algorithms]] — algorithms designed around disk page access patterns
