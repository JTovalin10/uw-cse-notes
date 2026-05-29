# CSE444: B+ Tree

A **B+ tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs.

## Table of Contents

1. [[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Properties and Structure|Properties and Structure]] (Degree, Branching factor, Height)
2. [[CSE444/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Operations|Operations & Optimizations]] (Lookup, Insert, Delete, Bulk Loading)

---

## Related
- [[CSE444/Data Storage, Indexing, and Buffer Management/Indexing|Indexes and File Organizations]] — clustered/unclustered indexes, dense/sparse indexes
- [[CSE444/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats and buffer pool management
- [[CSE444/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager use index structures
- [[CSE332/README|CSE332]] (Balanced Trees)
- [[Database Indices|Database Indices]] — CSE344 overview of index structures
- [[Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — clustered vs. unclustered index design
