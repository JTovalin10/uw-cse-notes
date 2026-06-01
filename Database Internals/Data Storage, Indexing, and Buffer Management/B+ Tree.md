# CSE444: B+ Tree

A **B+ tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs.

## Table of Contents

1. [[B+ Tree - Properties and Structure|Properties and Structure]] (Degree, Branching factor, Height)
2. [[B+ Tree - Operations|Operations & Optimizations]] (Lookup, Insert, Delete, Bulk Loading)

---

## Related
- [[Indexing|Indexes and File Organizations]] — clustered/unclustered indexes, dense/sparse indexes
- [[Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats and buffer pool management
- [[Architecture|DBMS Architecture]] — how the storage manager and buffer manager use index structures
- [[Data Structures and Parallelism/README|CSE332]] (Balanced Trees)
- [[Database Indices|Database Indices]] — CSE344 overview of index structures
- [[Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — clustered vs. unclustered index design
