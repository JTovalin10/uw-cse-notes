# CSE444 — Advanced Database Systems

Advanced database systems: internals, query processing, storage, and distributed data management.

---

## Topics

### Relational Model
- [[CSE444/Review of relational model/Relational Model|Relational Model]] — database/relation/tuple, schema, integrity constraints, key and foreign key constraints
- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — set vs. bag semantics, five basic operators, joins, SQL-to-RA conversion

### DBMS Architecture
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline (parse → rewrite → optimize → execute), iterator interface, storage manager, buffer manager
- [[CSE444/DBMS architecture and deployments/Engine Internals|Engine Internals]] — PostgreSQL vs InnoDB architectures, MVCC implementations, and memory management

### Data Storage
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, LOB, heap file implementations, buffer pool eviction
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — heap file API, sorted files, clustered/unclustered indexes, dense/sparse indexes, overflow pages
- [[CSE444/Data Storage, indexing, and buffer mgmt/Advanced Indexing|Advanced Indexing]] — Bitmap, GIN, GiST, R-Tree, and index maintenance (VACUUM/ANALYZE)
- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree]] — balanced tree structure, degree/occupancy, insertion/deletion, practical performance, optimizations
- [[CSE444/Data Storage, indexing, and buffer mgmt/LSM Trees|LSM Trees]] — log-structured merge trees, memtables, SSTables, Bloom filters, and compaction strategies

### Query Evaluation
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — query processor pipeline, memory management, BP-tuples vs M-tuples
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — cost parameters, hash join, nested loop join, page-at-a-time refinement
- [[CSE444/Query Evaluation/External Merge-Sort|External Merge-Sort]] — two-phase external sort; generates sorted runs then merges them
- [[CSE444/Query Evaluation/Index-Based Algorithms|Index-Based Algorithms]] — using indexes to speed up selection and join
- [[CSE444/Query Evaluation/Nested Loop Join|Nested Loop Join]] — simple O(B(R)·B(S)) join; page-at-a-time refinement reduces I/Os
- [[CSE444/Query Evaluation/Single-Pass Hash Join|Single-Pass Hash Join]] — one-pass hash-based join; requires smaller relation fits in memory
- [[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]] — one-pass and two-pass (merge-join) sort-based join algorithms
- [[CSE444/Query Evaluation/Partitioned Hash Algorithms|Partitioned Hash Join (Grace Join)]] — two-pass and multi-pass hash-based join; handles relations larger than memory using partitioning

### Query Optimization
- [[CSE444/Query Optimization/Query Optimization|Query Optimization Hub]] — overview of the optimization process
- [[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]] — database statistics, histograms, and cardinality estimation
- [[CSE444/Query Optimization/OptimizationComponents/Search Space|Search Space]] — approaches to plan enumeration and pruning heuristics
- [[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]] — System R style join reordering algorithm
- [[CSE444/Query Optimization/OptimizationComponents/Selinger Algorithm|Selinger Algorithm]] — interesting orders, left-deep plans, and the orderJoins DP procedure
- [[CSE444/Query Optimization/OptimizationComponents/Join Trees|Join Trees]] — bushy, linear, and left-deep tree shapes

### Parallel Query Processing
- [[CSE444/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] — OLTP vs. OLAP scaling, shared-memory/disk/nothing architectures
- [[CSE444/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — horizontal partitioning, block/range/hash partitioning, and data skew
- [[CSE444/Parallel/Parallel Query Execution|Parallel Query Execution]] — parallel selection, partitioned aggregation, combiners, and partitioned hash join

### Transactions
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]] — ACID properties, rollback, and buffer management (steal/force)
- [[CSE444/Transactions/Recovery/Recovery and Logging|Recovery and Logging]] — WAL, buffer management policies, logging types, and ARIES
- [[CSE444/Transactions/Serializability/Schedules|Schedules]] — definition of serial, serializable, and recoverable schedules
- [[CSE444/Transactions/Concurrency Anomalies|Concurrency Anomalies]] — WR (Dirty Read), RW (Unrepeatable Read), WW (Lost Update) conflicts
- [[CSE444/Transactions/Serializability/Serializability|Serializability]] — correctness criteria and types of equivalence (Conflict vs. View)
- [[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]] — precedence graphs and conflict serializability
- [[CSE444/Transactions/Serializability/View Serializability|View Serializability]] — view equivalence and the limits of conflict serializability
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Pessimistic Scheduler]] — transaction agent vs. system agent roles and the lock table
- [[CSE444/Transactions/Pessimistic Components/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]] — 2PL, Strict 2PL, and ensuring conflict serializability
- [[CSE444/Transactions/Pessimistic Components/Lock Modes|Lock Modes and Granularity]] — shared (S) and exclusive (X) locks, fine vs. coarse granularity
- [[CSE444/Transactions/Pessimistic Components/Deadlocks|Deadlocks]] — detection via wait-for graphs, timeouts, and avoidance strategies
- [[CSE444/Transactions/Isolation Levels|Isolation Levels]] — SQL standard levels (Read Uncommitted to Serializable) and their trade-offs
- [[CSE444/Transactions/Phantom Problem|The Phantom Problem]] — inconsistencies due to insertions/deletions and predicate locking
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]] — timestamp-based concurrency control and MVCC
- [[CSE444/Transactions/Optimistic Components/Validation|Validation]] — optimistic validation phases (Read, Validate, Write)
- [[CSE444/Transactions/Optimistic Components/Snapshot Isolation|Snapshot Isolation]] — multiversion concurrency control and first-committer-wins rule

### Replication and Distribution
- [[CSE444/Replication and distribution/Distributed Databases|Distributed Databases]] — shared-nothing vs shared-disk, MPP, sharding, and distributed joins

### NoSQL and NewSQL
*(notes in progress)*

---

## Related Courses
- [[CSE344 Index|CSE344 — Introduction to Data Management]] — prerequisite; covers SQL, RA, transactions, normalization
- [[CSE452/Index|CSE452 — Distributed Systems]] — distributed database topics (replication, fault tolerance)
