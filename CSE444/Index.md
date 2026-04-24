# CSE444 — Advanced Database Systems

Advanced database systems: internals, query processing, storage, and distributed data management.

---

## Topics

### Relational Model
- [[CSE444/Review of relational model/Relational Model|Relational Model]] — database/relation/tuple, schema, integrity constraints, key and foreign key constraints
- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — set vs. bag semantics, five basic operators, joins, SQL-to-RA conversion

### DBMS Architecture
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline (parse → rewrite → optimize → execute), iterator interface, storage manager, buffer manager

### Data Storage
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, LOB, heap file implementations, buffer pool eviction
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — heap file API, sorted files, clustered/unclustered indexes, dense/sparse indexes, overflow pages
- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree]] — balanced tree structure, degree/occupancy, insertion/deletion, practical performance, optimizations

### Query Evaluation
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — query processor pipeline, memory management, BP-tuples vs M-tuples
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — cost parameters, hash join, nested loop join, page-at-a-time refinement
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — two-phase external sort; generates sorted runs then merges them
- [[CSE444/Query Evaluation/Index-Based Algorithms|Index-Based Algorithms]] — using indexes to speed up selection and join
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simple O(B(R)·B(S)) join; page-at-a-time refinement reduces I/Os
- [[CSE444/Query Evaluation/Hash Join|Hash Join]] — one-pass hash-based join; requires smaller relation fits in memory
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — one-pass and two-pass (merge-join) sort-based join algorithms
- [[CSE444/Query Evaluation/Partitioned Hash Algorithms|Partitioned Hash Join]] — two-pass hash-based join (Grace join); partitions both relations into $M-1$ buckets

### Query Optimization
*(notes in progress)*

### Parallel Query Processing
*(notes in progress)*

### Transactions
*(notes in progress)*

### Replication and Distribution
*(notes in progress)*

### NoSQL and NewSQL
*(notes in progress)*

---

## Related Courses
- [[CSE344 Index|CSE344 — Introduction to Data Management]] — prerequisite; covers SQL, RA, transactions, normalization
- [[CSE452/Index|CSE452 — Distributed Systems]] — distributed database topics (replication, fault tolerance)
