# Database Internals: B+ Tree

A **B+ tree** is a **balanced search tree** optimized for disk-page access. It is the default index structure in most relational DBMSs. Each node corresponds to exactly one disk page, so the design goal is to maximize **fan-out** (children per node) to minimize tree height and therefore minimize I/Os per lookup.

## Table of Contents

1. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Properties and Structure|Properties and Structure]] — degree, branching factor, height, computing $d$
2. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Operations|Operations & Optimizations]] — lookup, insert, delete, bulk loading, prefix compression

---

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/Indexing|Indexes and File Organizations]] — clustered/unclustered indexes, dense/sparse indexes
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Advanced Indexing|Advanced Indexing]] — specialized index types beyond B+ trees
- [[Database Internals/Data Storage, Indexing, and Buffer Management/LSM Trees|LSM Trees]] — write-optimized alternative to B+ trees
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats and buffer pool management
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager use index structures
