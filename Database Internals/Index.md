# CSE444 — Advanced Database Systems

Advanced database systems: internals, query processing, storage, and distributed data management.

---

## Topics

### Relational Model
- [[Relational Model|Relational Model]] — database/relation/tuple, schema, integrity constraints, key and foreign key constraints
- [[Database Internals/Review of Relational Model/Relational Algebra|Relational Algebra]] — set vs. bag semantics, five basic operators, joins, SQL-to-RA conversion

### DBMS Architecture
- [[Architecture|DBMS Architecture and Query Processing]] — query pipeline (parse → rewrite → optimize → execute), iterator interface, storage manager, [[Buffer Manager|buffer manager]]
- [[Engine Internals|Engine Internals]] — PostgreSQL vs InnoDB architectures, MVCC implementations, and memory management

### Data Storage
- [[Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, LOB, heap file implementations, [[Buffer Manager|buffer pool eviction]]
- [[Indexing|Indexes and File Organizations]] — heap file API, sorted files, clustered/unclustered indexes, dense/sparse indexes, overflow pages
- [[Advanced Indexing|Advanced Indexing]] — Bitmap, GIN, GiST, R-Tree, and index maintenance (VACUUM/ANALYZE)
- [[B+ Tree|B+ Tree]] — balanced tree structure, degree/occupancy, insertion/deletion, practical performance, optimizations
- [[LSM Trees|LSM Trees]] — log-structured merge trees, memtables, SSTables, Bloom filters, and compaction strategies
- [[Column-Store DBMSs|Column-Store DBMSs]] — vertical partitioning, row vs. column trade-offs, slotted pages, and PAX hybrid layout

### Query Evaluation
- [[Query Execution & Algorithms|Query Execution]] — query processor pipeline, memory management, BP-tuples vs M-tuples
- [[Operator Algorithms|Operator Algorithms]] — cost parameters, hash join, nested loop join, page-at-a-time refinement
- [[External Merge-Sort|External Merge-Sort]] — two-phase external sort; generates sorted runs then merges them
- [[Index-Based Algorithms|Index-Based Algorithms]] — using indexes to speed up selection and join
- [[Nested Loop Join|Nested Loop Join]] — simple O(B(R)·B(S)) join; page-at-a-time refinement reduces I/Os
- [[Single-Pass Hash Join|Single-Pass Hash Join]] — one-pass hash-based join; requires smaller relation fits in memory
- [[Sort-Merge Join|Sort-Merge Join]] — one-pass and two-pass (merge-join) sort-based join algorithms
- [[Partitioned Hash Algorithms|Partitioned Hash Join (Grace Join)]] — two-pass and multi-pass hash-based join; handles relations larger than memory using partitioning

### Query Optimization
- [[Query Optimization|Query Optimization Hub]] — overview of the optimization process
- [[Cost Estimation|Cost Estimation]] — database statistics, histograms, and cardinality estimation
- [[Search Space|Search Space]] — approaches to plan enumeration and pruning heuristics
- [[Dynamic Programming|Dynamic Programming]] — System R style join reordering algorithm
- [[Selinger Algorithm|Selinger Algorithm]] — interesting orders, left-deep plans, and the orderJoins DP procedure
- [[Join Trees|Join Trees]] — bushy, linear, and left-deep tree shapes

### Parallel Query Processing
- [[Intro to Parallel DBMS|Intro to Parallel DBMS]] — OLTP vs. OLAP scaling, shared-memory/disk/nothing architectures
- [[Data Partitioning Schemes|Data Partitioning Schemes]] — horizontal partitioning, block/range/hash partitioning, and data skew
- [[Database Internals/Parallel/Parallel Query Execution|Parallel Query Execution]] — hub for parallel operators, linking the components below
  - [[Parallel Selection|Parallel Selection]] — local selection per node plus the implicit union of results
  - [[The Shuffle Operator|The Shuffle Operator]] — the producer-consumer redistribution mechanism and evaluation pipeline
  - [[Partitioned Aggregation|Partitioned Aggregation]] — partitioning cases, naive reshuffle, and combiners
  - [[Partitioned Hash Join|Partitioned Hash Join]] — partitioned hash equijoin and the broadcast-join optimization
  - [[Speedup and Scaleup|Speedup and Scaleup]] — strong vs. weak scaling of parallel queries

### Transactions
- [[Transaction Fundamentals|Transaction Fundamentals]] — ACID properties, rollback, and buffer management (steal/force)
- [[Recovery|Recovery]] — ensure database consistency via recovery protocols; covers WAL, buffer management policies, logging types, and ARIES
  - [[Undo Logging|Undo Logging]] — steal policy; records "before images" to revert uncommitted changes
  - [[Redo Logging|Redo Logging]] — no-force policy; records "after images" to replay lost committed changes
  - [[Undo-Redo Logging|Undo-Redo Logging]] — steal/no-force policy; industry standard combining both
  - [[Checkpointing|Checkpointing]] — bounding recovery time; quiescent vs non-quiescent
  - [[Log Abstraction Levels|Log Abstraction Levels]] — physical, logical, and physiological logging trade-offs
- [[Schedules|Schedules]] — definition of serial, serializable, and recoverable schedules
- [[Concurrency Anomalies|Concurrency Anomalies]] — WR (Dirty Read), RW (Unrepeatable Read), WW (Lost Update) conflicts
- [[Serializability|Serializability]] — correctness criteria and types of equivalence (Conflict vs. View)
- [[Conflict Serializability|Conflict Serializability]] — precedence graphs and conflict serializability
- [[View Serializability|View Serializability]] — view equivalence and the limits of conflict serializability
- [[Pessimistic Scheduler|Pessimistic Scheduler]] — transaction agent vs. system agent roles and the lock table
- [[Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]] — 2PL, Strict 2PL, and ensuring conflict serializability
- [[Lock Modes|Lock Modes and Granularity]] — shared (S) and exclusive (X) locks, fine vs. coarse granularity
- [[Database Internals/Transactions/PessimisticComponents/Deadlocks|Deadlocks]] — detection via wait-for graphs, timeouts, and avoidance strategies
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]] — SQL standard levels (Read Uncommitted to Serializable) and their trade-offs
- [[Phantom Problem|The Phantom Problem]] — inconsistencies due to insertions/deletions and predicate locking
- [[Timestamps|Timestamps]] — timestamp-based concurrency control and MVCC
- [[Validation|Validation]] — optimistic validation phases (Read, Validate, Write)
- [[Snapshot Isolation|Snapshot Isolation]] — multiversion concurrency control and first-committer-wins rule

### Replication and Distribution
- [[Distributed Databases|Distributed Databases]] — shared-nothing vs shared-disk, MPP, sharding, and distributed joins
- [[Database Internals/Distributed Systems/Two-Phase Commit|Two-Phase Commit (2PC)]] — consensus protocol for distributed transaction atomicity (Prepare/Commit phases)
- [[Database Internals/Distributed Systems/Replication|Replication]] — synchronous vs asynchronous, master vs group, quorums, and conflict reconciliation

### NoSQL and NewSQL
*(notes in progress)*

### Case Studies
- [[Database Internals/Replication and Distribution/MapReduce|MapReduce]] — programming model for large-scale parallel processing, GFS/HDFS storage, map/reduce phases, jobs vs. tasks, stragglers and backup tasks
- [[Spark|Spark]] — RDD abstraction, in-memory iterative processing, lazy evaluation, lineage-based fault tolerance, narrow vs. wide dependencies

---

## Related Courses
- [[CSE344 Index|CSE344 — Introduction to Data Management]] — prerequisite; covers SQL, RA, transactions, normalization
- [[Distributed Systems/Index|CSE452 — Distributed Systems]] — distributed database topics (replication, fault tolerance)
