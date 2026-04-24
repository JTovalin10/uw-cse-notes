# CSE 344 — Database Systems

Master navigation hub for CSE 344 notes. For a course overview see README (if available).

---

## SQL

- [[CSE344/SQL/Basics|Basics]] — SELECT, FROM, WHERE, aliases
- [[CSE344/SQL/Create Table|Create Table]] — DDL, data types, constraints
- [[CSE344/SQL/Joins|Joins]] — INNER JOIN, natural joins, cross products
- [[CSE344/SQL/Outer Joins|Outer Joins]] — LEFT/RIGHT/FULL OUTER JOIN
- [[CSE344/SQL/Self Joins|Self Joins]] — comparing rows within the same table
- [[CSE344/SQL/Aggregates|Aggregates]] — COUNT, SUM, AVG, GROUP BY, HAVING
- [[CSE344/SQL/ORDER BY and DISTINCT|ORDER BY and DISTINCT]] — sorting and deduplication
- [[CSE344/SQL/NULL|NULL]] — three-valued logic, IS NULL, COALESCE
- [[CSE344/SQL/Sub-Queries|Sub-Queries]] — correlated and uncorrelated subqueries
- [[CSE344/SQL/Set Operations|Set Operations]] — UNION, INTERSECT, EXCEPT
- [[CSE344/SQL/Table Division|Table Division]] — "for all" queries with double negation
- [[CSE344/SQL/Witnessing Problem|Witnessing Problem]] — anti-join and existence patterns
- [[CSE344/SQL/Physical Data Independence|Physical Data Independence]] — logical vs. physical schema separation
- [[CSE344/SQL/Decorrelation and Unnesting|Decorrelation and Unnesting]] — flattening correlated subqueries
- [[CSE344/SQL/Sparse Matrix Algebra|Sparse Matrix Algebra]] — SQL for matrix operations
- [[CSE344/SQL/Dynamic Pivots|Dynamic Pivots]] — dynamic cross-tabulation

---

## Database Design

### Conceptual Design
- [[CSE344/Database Design/Entities, Relationships, and ER Diagrams|Entities, Relationships, and ER Diagrams]] — entity sets, attributes, relationships, ER notation
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — keys, foreign keys, CHECK, NOT NULL
- [[CSE344/Database Design/Database Applications|Database Applications]] — multi-tier architectures and real-world use

### Normalization
- [[CSE344/Database Design/Functional Dependencies (FDs)|Functional Dependencies (FDs)]] — FD definition, Armstrong's axioms
- [[CSE344/Database Design/Closures and Keys|Closures and Keys]] — attribute closure, candidate keys
- [[CSE344/Database Design/Data Anomalies|Data Anomalies]] — insertion, deletion, update anomalies
- [[CSE344/Database Design/Normalization|Normalization]] — 1NF, 2NF, 3NF, BCNF overview
- [[CSE344/Database Design/BCNF Decomposition|BCNF Decomposition]] — BCNF algorithm, lossless joins, dependency preservation

### Physical Design
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — pages, disk I/O, buffer pool
- [[CSE344/Database Design/Database Indices|Database Indices]] — B+ trees, hash indices, index selection
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — storage order and query cost implications
- [[CSE344/Database Design/Physical Design and Indices|Physical Design and Indices]] — index tuning, covering indices
- [[CSE344/Database Design/Multi-tier Architecture|Multi-tier Architecture]] — presentation, logic, and data tiers

### Security
- [[CSE344/Database Design/Password Handling|Password Handling]] — hashing, salting, SQL injection — see also CSE484/SQL Injection

---

## Query Execution

### Relational Algebra
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — σ, π, ⋈, ρ, set operations
- [[CSE344/Query Execution/RA Operators|RA Operators]] — operator semantics and cost
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — mapping SQL clauses to RA trees
- [[CSE344/Query Execution/RA Tree Transformations|RA Tree Transformations]] — equivalence rules, predicate pushdown

### Algorithms
- [[CSE344/Query Execution/External Memory Algorithms|External Memory Algorithms]] — sorting and hashing with limited RAM
- [[CSE344/Query Execution/Main Memory Join Algorithms|Main Memory Join Algorithms]] — nested loops, hash join, sort-merge join
- [[CSE344/Query Execution/Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — iterators, operator trees
- [[CSE344/Query Execution/Pipelined Execution|Pipelined Execution]] — tuple-at-a-time vs. block-at-a-time

### Optimization
- [[CSE344/Query Execution/Cardinality Estimation|Cardinality Estimation]] — selectivity, histograms, statistics
- [[CSE344/Query Execution/Parallel Query Execution|Parallel Query Execution]] — partitioning strategies, data parallelism
- [[CSE344/Query Execution/Parallel Join Algorithms|Parallel Join Algorithms]] — broadcast join, repartition join

---

## Transactions

- [[CSE344/Transactions/ACID Properties|ACID Properties]] — Atomicity, Consistency, Isolation, Durability
- [[CSE344/Transactions/Schedules and Serial Schedules|Schedules and Serial Schedules]] — serial, serializable, conflict-serializable
- [[CSE344/Transactions/Interleaving and Concurrency Control|Interleaving and Concurrency Control]] — conflicts, read/write anomalies
- [[CSE344/Transactions/Precedence Graphs|Precedence Graphs]] — conflict-serializability testing
- [[CSE344/Transactions/Atomic Transactions in SQL|Atomic Transactions in SQL]] — locking, lock protocols
- [[CSE344/Transactions/Atomic and Isolated Transactions in SQL|Atomic and Isolated Transactions in SQL]] — Two-Phase Locking (2PL)
- [[CSE344/Transactions/Isolation Transactions in SQL|Isolation Transactions in SQL]] — enforcing isolation in practice
- [[CSE344/Transactions/Isolation Levels|Isolation Levels]] — READ UNCOMMITTED → SERIALIZABLE, tradeoffs
- [[CSE344/Transactions/Phantom Reads|Phantom Reads]] — predicate locking, why range locks matter
- [[CSE344/Transactions/Other Lock Modes and Lock Granularity|Other Lock Modes and Lock Granularity]] — shared/exclusive, intention locks, row vs. table

---

## Suggested Reading Order

**SQL fundamentals:**
Basics → Create Table → Joins → Outer Joins → Aggregates → ORDER BY and DISTINCT → NULL → Sub-Queries → Set Operations → Table Division → Witnessing Problem → Self Joins → Physical Data Independence → Decorrelation and Unnesting.

**Database design:**
Entities, Relationships, and ER Diagrams → Integrity Constraints → Functional Dependencies (FDs) → Closures and Keys → Data Anomalies → Normalization → BCNF Decomposition → Disk Storage → Database Indices → Clustered and Unclustered Indices → Physical Design and Indices.

**Query execution:**
Relational Algebra → RA Operators → SQL to RA Translation → RA Tree Transformations → External Memory Algorithms → Main Memory Join Algorithms → Physical Algorithms and Pipelining → Pipelined Execution → Cardinality Estimation → Parallel Query Execution → Parallel Join Algorithms.

**Transactions:**
ACID Properties → Schedules and Serial Schedules → Interleaving and Concurrency Control → Precedence Graphs → Atomic Transactions in SQL → Atomic and Isolated Transactions in SQL → Isolation Transactions in SQL → Isolation Levels → Phantom Reads → Other Lock Modes and Lock Granularity.
