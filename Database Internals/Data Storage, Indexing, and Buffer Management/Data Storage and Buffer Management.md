# Database Internals: Data Storage and Buffer Management

This section covers how data is physically stored on disk and managed in memory. It serves as the navigation hub for the StorageComponents subtopics.

## Table of Contents

1. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Disk and Layout|Working with Disk & Storage Layout]] — seek time, row vs. column store
2. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Page and Record Formats|Page & Record Formats]] — slotted pages, fixed vs. variable-length records
3. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap File and LOBs|Heap Files & LOBs]] — heap file implementations, BLOBs, CLOBs
4. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] — heap file API, sorted files, binary search on indexed attributes
5. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]] — caching, eviction policies, dirty pages

---

## Related

- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture and Query Processing]] — how the buffer manager and storage manager fit into the full DBMS architecture
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Indexing|Indexes and File Organizations]] — heap file API, sorted files, and index structures built on top of heap files
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Storage Engine Fundamentals|Storage Engine Fundamentals]] — overview of the three storage pillars (layout, buffer management, indexing)
- [[External Memory Algorithms|External Memory Algorithms]] — algorithms designed around disk page access patterns
