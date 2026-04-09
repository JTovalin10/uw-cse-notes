# CSE444 — Advanced Database Systems

Advanced database systems: internals, query processing, storage, and distributed data management.

---

## Topics

### Relational Model
- [[CSE444/Review of relational model/Relational Model|Relational Model and Relational Algebra]] — database/relation/tuple, schema, integrity constraints, RA operators, SQL-to-RA

### DBMS Architecture
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline (parse → rewrite → optimize → execute), iterator interface, storage manager, buffer manager

### Data Storage
- [[Data Storage and Buffer Management]] — page formats, record formats, LOB, heap file implementations, buffer pool eviction
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — heap file API, sorted files, clustered/unclustered indexes, dense/sparse indexes, overflow pages, B+ trees

### Query Evaluation
*(notes in progress)*

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
- [[CSE344/Index|CSE344 — Introduction to Data Management]] — prerequisite; covers SQL, RA, transactions, normalization
- [[CSE452/Index|CSE452 — Distributed Systems]] — distributed database topics (replication, fault tolerance)
