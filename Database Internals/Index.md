# Database Internals — Advanced Database Systems

Advanced database systems: internals, query processing, storage, and distributed data management.

---

## Topics

### Relational Model
- [[Database Internals/Review of Relational Model/Relational Model|Relational Model]] — database/relation/tuple, schema, integrity constraints, key and foreign key constraints
- [[Database Internals/Review of Relational Model/Relational Algebra|Relational Algebra]] — set vs. bag semantics, five basic operators ($\sigma$, $\pi$, $\times$, $\cup$, $-$), joins, SQL-to-RA conversion

### DBMS Architecture
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline (parse → rewrite → optimize → execute), iterator interface, storage manager, buffer manager
  - [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] — parser, rewrite, optimizer, physical plan
  - [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Executor|Query Executor]] — push vs. pull execution, iterator (Volcano) interface
  - [[Database Internals/DBMS Architecture and Deployments/Subsystems/Storage Manager|Storage Manager]] — catalog, access methods, page model
- [[Database Internals/DBMS Architecture and Deployments/Engine Internals|Engine Internals]] — PostgreSQL vs. InnoDB architectures, MVCC implementations, and memory management

### Data Storage
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Storage Engine Fundamentals|Storage Engine Fundamentals]] — overview of physical layout, buffer management, and indexing internals
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — hub linking all StorageComponents subtopics
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Disk and Layout|Disk and Layout]] — seek time, sequential reads, row-store vs. column-store layout
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Page and Record Formats|Page and Record Formats]] — slotted pages, fixed vs. variable-length records
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap File and LOBs|Heap File and LOBs]] — heap file implementations, BLOBs, CLOBs
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] — heap file API, sorted files, binary search
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]] — buffer pool frames, pin counts, dirty bits, eviction policies (LRU, Clock, LRU-K)
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Indexing|Indexes and File Organizations]] — hub linking index subtopics
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Index Types|Index Types]] — clustered vs. secondary, dense vs. sparse
  - [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] — hub: balanced tree structure overview
    - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Properties and Structure|B+ Tree - Properties and Structure]] — degree, fan-out, height, computing $d$
    - [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/B+ Tree - Operations|B+ Tree - Operations]] — lookup, insert, delete, bulk loading, prefix compression
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Advanced Indexing|Advanced Indexing]] — Bitmap, GIN, GiST, R-Tree, and index maintenance (VACUUM/ANALYZE, online index build, index bloat)
- [[Database Internals/Data Storage, Indexing, and Buffer Management/LSM Trees|LSM Trees]] — log-structured merge trees, memtables, SSTables, Bloom filters, leveled vs. tiered compaction, RUM conjecture
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Column-Store DBMSs|Column-Store DBMSs]] — vertical partitioning, row vs. column trade-offs, slotted pages, and PAX hybrid layout

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
- [[Database Internals/Parallel/Intro to Parallel DBMS|Intro to Parallel DBMS]] — OLTP vs. OLAP scaling, shared-memory/disk/nothing architectures
- [[Database Internals/Parallel/Data Partitioning Schemes|Data Partitioning Schemes]] — horizontal partitioning, block/range/hash partitioning, and data skew
- [[Database Internals/Parallel/Parallel Query Execution|Parallel Query Execution]] — hub for parallel operators, linking the components below
  - [[Database Internals/Parallel/ParallelExecutionComponents/Parallel Selection|Parallel Selection]] — local selection per node plus the implicit union of results
  - [[Database Internals/Parallel/ParallelExecutionComponents/The Shuffle Operator|The Shuffle Operator]] — the producer-consumer redistribution mechanism and evaluation pipeline
  - [[Database Internals/Parallel/ParallelExecutionComponents/Partitioned Aggregation|Partitioned Aggregation]] — partitioning cases, naive reshuffle, and combiners
  - [[Database Internals/Parallel/ParallelExecutionComponents/Partitioned Hash Join|Partitioned Hash Join]] — partitioned hash equijoin and the broadcast-join optimization
  - [[Database Internals/Parallel/ParallelExecutionComponents/Speedup and Scaleup|Speedup and Scaleup]] — strong vs. weak scaling of parallel queries

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
- [[Database Internals/Replication and Distribution/Distributed Databases|Distributed Databases]] — shared-nothing vs. shared-disk, MPP, sharding, distributed joins, distributed deadlock
- [[Database Internals/Distributed Systems/Two-Phase Commit|Two-Phase Commit (2PC)]] — consensus protocol for distributed transaction atomicity (Prepare/Commit phases), failure handling, state machines, Presumed Abort optimization
- [[Database Internals/Distributed Systems/Replication|Replication]] — hub: taxonomy of the four schemes (two timing × two topology axes)
- [[Database Internals/Distributed Systems/Master and Group Replication|Master and Group Replication]] — replication topology: single leader vs. leaderless architecture, scaling vs. bottlenecks
- [[Database Internals/Distributed Systems/Synchronous Replication|Synchronous Replication]] — eager timing mechanics, 2PC, master locks, and group quorum locking
- [[Database Internals/Distributed Systems/Asynchronous Replication|Asynchronous Replication]] — lazy timing mechanics, log shipping, stale reads, and group conflict reconciliation

### NoSQL and NewSQL
*(notes in progress)*

### Case Studies
- [[Database Internals/Replication and Distribution/MapReduce|MapReduce]] — programming model for large-scale parallel processing, GFS/HDFS storage, map/reduce phases, jobs vs. tasks, stragglers and backup tasks
- [[Database Internals/Replication and Distribution/Spark|Spark]] — RDD abstraction, in-memory iterative processing, lazy evaluation, lineage-based fault tolerance, narrow vs. wide dependencies

---

## Related Courses
- [[CSE344 Index|CSE344 — Introduction to Data Management]] — prerequisite; covers SQL, RA, transactions, normalization
- [[Distributed Systems/Index|CSE452 — Distributed Systems]] — distributed database topics (replication, fault tolerance)
