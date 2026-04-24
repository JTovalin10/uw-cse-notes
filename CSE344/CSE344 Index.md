# CSE 344 — Database Systems

Master navigation hub for CSE 344 notes. For a course overview see README (if available).

---

## SQL

- [[CSE344/SQL/Basics|Basics]] — SQL fundamentals
- [[CSE344/SQL/Create Table|Create Table]] — SQL CREATE TABLE syntax
- [[CSE344/SQL/Joins|Joins]] — SQL join operations and types
- [[CSE344/SQL/Outer Joins|Outer Joins]] — left, right, full outer joins
- [[CSE344/SQL/Self Joins|Self Joins]] — joining a table to itself
- [[CSE344/SQL/Aggregates|Aggregates]] — SQL GROUP BY and aggregate functions
- [[CSE344/SQL/ORDER BY and DISTINCT|ORDER BY and DISTINCT]] — SQL result ordering and deduplication
- [[CSE344/SQL/NULL|NULL]] — NULL value handling in SQL
- [[CSE344/SQL/Sub-Queries|Sub-Queries]] — nested SELECT statements
- [[CSE344/SQL/Set Operations|Set Operations]] — UNION, INTERSECT, EXCEPT in SQL
- [[CSE344/SQL/Table Division|Table Division]] — relational division operation
- [[CSE344/SQL/Witnessing Problem|Witnessing Problem]] — existential witness queries in SQL
- [[CSE344/SQL/Physical Data Independence|Physical Data Independence]] — separating logical from physical schema
- [[CSE344/SQL/Decorrelation and Unnesting|Decorrelation and Unnesting]] — query optimization subquery techniques
- [[CSE344/SQL/Sparse Matrix Algebra|Sparse Matrix Algebra]] — sparse matrix operations in SQL
- [[CSE344/SQL/Dynamic Pivots|Dynamic Pivots]] — dynamically unpivoting/pivoting tables

---

## Database Design

### Conceptual Design
- [[CSE344/Database Design/Entities, Relationships, and ER Diagrams|Entities, Relationships, and ER Diagrams]] — entity-relationship modeling
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — rules enforcing data validity
- [[CSE344/Database Design/Database Applications|Database Applications]] — real-world database usage patterns

### Normalization
- [[CSE344/Database Design/Functional Dependencies (FDs)|Functional Dependencies (FDs)]] — attribute dependency relationships
- [[CSE344/Database Design/Closures and Keys|Closures and Keys]] — functional dependency closure and candidate keys
- [[CSE344/Database Design/Data Anomalies|Data Anomalies]] — insertion, update, deletion anomalies
- [[CSE344/Database Design/Normalization|Normalization]] — database normalization forms (1NF–BCNF)
- [[CSE344/Database Design/BCNF Decomposition|BCNF Decomposition]] — Boyce-Codd Normal Form normalization algorithm

### Physical Design
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — physical disk storage mechanisms
- [[CSE344/Database Design/Database Indices|Database Indices]] — indexing structures for query optimization
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — primary and secondary index types
- [[CSE344/Database Design/Physical Design and Indices|Physical Design and Indices]] — choosing indices and storage structures
- [[CSE344/Database Design/Multi-tier Architecture|Multi-tier Architecture]] — typical 3-tier database architecture

### Security
- [[CSE344/Database Design/Password Handling|Password Handling]] — secure password storage in databases

---

## Query Execution

### Relational Algebra
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — formal query language with set operations
- [[CSE344/Query Execution/RA Operators|RA Operators]] — relational algebra operations
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — translating SQL to relational algebra
- [[CSE344/Query Execution/RA Tree Transformations|RA Tree Transformations]] — query tree optimization

### Algorithms
- [[CSE344/Query Execution/External Memory Algorithms|External Memory Algorithms]] — algorithms optimized for disk access
- [[CSE344/Query Execution/Main Memory Join Algorithms|Main Memory Join Algorithms]] — in-memory join algorithms
- [[CSE344/Query Execution/Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — query execution plan details
- [[CSE344/Query Execution/Pipelined Execution|Pipelined Execution]] — pipeline-based query execution

### Optimization
- [[CSE344/Query Execution/Cardinality Estimation|Cardinality Estimation]] — query optimizer estimating result set size
- [[CSE344/Query Execution/Parallel Query Execution|Parallel Query Execution]] — distributed query processing
- [[CSE344/Query Execution/Parallel Join Algorithms|Parallel Join Algorithms]] — distributed join execution

---

## Transactions

- [[CSE344/Transactions/ACID Properties|ACID Properties]] — atomicity, consistency, isolation, durability
- [[CSE344/Transactions/Schedules and Serial Schedules|Schedules and Serial Schedules]] — transaction schedule theory
- [[CSE344/Transactions/Interleaving and Concurrency Control|Interleaving and Concurrency Control]] — handling concurrent transactions
- [[CSE344/Transactions/Precedence Graphs|Precedence Graphs]] — serialization graphs for transaction ordering
- [[CSE344/Transactions/Atomic Transactions in SQL|Atomic Transactions in SQL]] — all-or-nothing transaction execution
- [[CSE344/Transactions/Atomic and Isolated Transactions in SQL|Atomic and Isolated Transactions in SQL]] — ACID in SQL transactions
- [[CSE344/Transactions/Isolation Transactions in SQL|Isolation Transactions in SQL]] — isolation guarantees in SQL
- [[CSE344/Transactions/Isolation Levels|Isolation Levels]] — serializable, repeatable read, read committed, etc.
- [[CSE344/Transactions/Phantom Reads|Phantom Reads]] — phantom read anomaly in transactions
- [[CSE344/Transactions/Other Lock Modes and Lock Granularity|Other Lock Modes and Lock Granularity]] — locking strategies beyond basic locks

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
