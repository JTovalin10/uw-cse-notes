# CSE 344 — Database Systems

Master navigation hub for CSE 344 notes. For a course overview see README (if available).

---

## SQL

- [[Basics|Basics]] — SQL fundamentals
- [[Create Table|Create Table]] — SQL CREATE TABLE syntax
- [[Joins|Joins]] — SQL join operations and types
- [[Outer Joins|Outer Joins]] — left, right, full outer joins
- [[Self Joins|Self Joins]] — joining a table to itself
- [[Aggregates|Aggregates]] — SQL GROUP BY and aggregate functions
- [[ORDER BY and DISTINCT|ORDER BY and DISTINCT]] — SQL result ordering and deduplication
- [[NULL|NULL]] — NULL value handling in SQL
- [[Sub-Queries|Sub-Queries]] — nested SELECT statements
- [[Set Operations|Set Operations]] — UNION, INTERSECT, EXCEPT in SQL
- [[Table Division|Table Division]] — relational division operation
- [[Witnessing Problem|Witnessing Problem]] — existential witness queries in SQL
- [[Physical Data Independence|Physical Data Independence]] — separating logical from physical schema
- [[Decorrelation and Unnesting|Decorrelation and Unnesting]] — query optimization subquery techniques
- [[Sparse Matrix Algebra|Sparse Matrix Algebra]] — sparse matrix operations in SQL
- [[Dynamic Pivots|Dynamic Pivots]] — dynamically unpivoting/pivoting tables

---

## Database Design

### Conceptual Design
- [[Entities, Relationships, and ER Diagrams|Entities, Relationships, and ER Diagrams]] — entity-relationship modeling
- [[Integrity Constraints|Integrity Constraints]] — rules enforcing data validity
- [[Database Applications|Database Applications]] — real-world database usage patterns

### Normalization
- [[Functional Dependencies (FDs)|Functional Dependencies (FDs)]] — attribute dependency relationships
- [[Closures and Keys|Closures and Keys]] — functional dependency closure and candidate keys
- [[Data Anomalies|Data Anomalies]] — insertion, update, deletion anomalies
- [[Normalization|Normalization]] — database normalization forms (1NF–BCNF)
- [[BCNF Decomposition|BCNF Decomposition]] — Boyce-Codd Normal Form normalization algorithm

### Physical Design
- [[Disk Storage|Disk Storage]] — physical disk storage mechanisms
- [[Database Indices|Database Indices]] — indexing structures for query optimization
- [[Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — primary and secondary index types
- [[Physical Design and Indices|Physical Design and Indices]] — choosing indices and storage structures
- [[Multi-tier Architecture|Multi-tier Architecture]] — typical 3-tier database architecture

### Security
- [[Password Handling|Password Handling]] — secure password storage in databases

---

## Query Execution

### Relational Algebra
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — formal query language with set operations
- [[RA Operators|RA Operators]] — relational algebra operations
- [[SQL to RA Translation|SQL to RA Translation]] — translating SQL to relational algebra
- [[RA Tree Transformations|RA Tree Transformations]] — query tree optimization

### Algorithms
- [[External Memory Algorithms|External Memory Algorithms]] — algorithms optimized for disk access
- [[Main Memory Join Algorithms|Main Memory Join Algorithms]] — in-memory join algorithms
- [[Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — query execution plan details
- [[Pipelined Execution|Pipelined Execution]] — pipeline-based query execution

### Optimization
- [[Cardinality Estimation|Cardinality Estimation]] — query optimizer estimating result set size
- [[CSE344/Query Execution/Parallel Query Execution|Parallel Query Execution]] — distributed query processing
- [[Parallel Join Algorithms|Parallel Join Algorithms]] — distributed join execution

---

## Transactions

- [[ACID Properties|ACID Properties]] — atomicity, consistency, isolation, durability
- [[Schedules and Serial Schedules|Schedules and Serial Schedules]] — transaction schedule theory
- [[Interleaving and Concurrency Control|Interleaving and Concurrency Control]] — handling concurrent transactions
- [[Precedence Graphs|Precedence Graphs]] — serialization graphs for transaction ordering
- [[Atomic Transactions in SQL|Atomic Transactions in SQL]] — all-or-nothing transaction execution
- [[CSE344/Transactions/Atomic and Isolated Transactions in SQL|Atomic and Isolated Transactions in SQL]] — ACID in SQL transactions
- [[Isolation Transactions in SQL|Isolation Transactions in SQL]] — isolation guarantees in SQL
- [[CSE344/Transactions/Isolation Levels|Isolation Levels]] — serializable, repeatable read, read committed, etc.
- [[Phantom Reads|Phantom Reads]] — phantom read anomaly in transactions
- [[Other Lock Modes and Lock Granularity|Other Lock Modes and Lock Granularity]] — locking strategies beyond basic locks

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
