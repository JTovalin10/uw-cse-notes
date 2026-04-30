# CSE444: B+ Tree

A **B+ tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs.

## Table of Contents

1. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/B+ Tree - Properties and Structure|Properties and Structure]] (Degree, Branching factor, Height)
2. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/B+ Tree - Operations|Operations & Optimizations]] (Lookup, Insert, Delete, Bulk Loading)

---

## Related
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — clustered/unclustered indexes, dense/sparse indexes
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats and buffer pool management
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager use index structures
- [[CSE332/README|CSE332]] (Balanced Trees)
- [[CSE344/Database Design/Database Indices|Database Indices]] — CSE344 overview of index structures
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — clustered vs. unclustered index design
