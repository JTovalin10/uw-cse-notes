# CSE444: Engine Internals

Different database engines implement storage and concurrency using distinct architectures. Understanding the internals of **PostgreSQL** and **InnoDB** (MySQL) is critical for performance tuning.

## PostgreSQL Internals

**PostgreSQL** uses a process-based architecture and relies on **Multiversion Concurrency Control (MVCC)** without an undo log.

### Tuple Visibility: xmin and xmax
Each row (tuple) in PostgreSQL contains hidden system columns in its header:
- **xmin**: The transaction ID that inserted this tuple.
- **xmax**: The transaction ID that deleted or updated this tuple. If it is 0, the tuple is not deleted.

### MVCC Mechanism
- **Updates**: PostgreSQL implements updates as a `DELETE` followed by an `INSERT`. The old tuple's `xmax` is set to the current transaction ID, and a new tuple is created with `xmin` set to the current transaction ID.
- **Visibility Rule**: A transaction $T$ can see a tuple if:
  1. `xmin` is a committed transaction and $xmin < T$.
  2. `xmax` is either 0 or an uncommitted transaction or $xmax > T$.

### TOAST (The Oversized-Attribute Storage Technique)
PostgreSQL pages are a fixed 8KB. When a field (like a large text or blob) exceeds this size, PostgreSQL uses **TOAST** to compress it and/or move it into a separate side table, leaving only a pointer in the original row.

### Memory Management
- **shared_buffers**: The main **Buffer Pool** for caching data pages.
- **work_mem**: Memory allocated for each sort or hash operation. If a query requires more than this, it will spill to disk.

## InnoDB (MySQL) Internals

**InnoDB** uses a thread-based architecture with a centralized buffer pool and a primary index-organized storage (**Clustered Index**).

### Buffer Pool and Change Buffer
- **Buffer Pool**: Caches both data and indexes.
- **Change Buffer**: A specialized structure that caches updates to secondary index pages that are not currently in the buffer pool. This reduces random I/O by merging changes later when the pages are loaded.

### Redo and Undo Logs
- **Redo Log**: Used for recovery via **Write-Ahead Logging (WAL)**. It is a circular buffer of physical changes.
- **Undo Log**: Used for MVCC and rollbacks. Unlike PostgreSQL, InnoDB stores old versions of rows in an **Undo Log** (within the **Rollback Segment**) rather than in the main table files.

## Performance Optimization Patterns

### Group Commit
**Group Commit** is an optimization where the engine waits for several transactions to finish and then flushes their log records to disk in a single I/O operation. This significantly increases transaction throughput by reducing the number of disk syncs (`fsync`).

### Prepared Statements
**Prepared Statements** allow the database to parse, validate, and optimize a query once and then execute it multiple times with different parameters. This reduces parsing overhead and prevents **SQL Injection**.

### N+1 Query Problem
The **N+1 Query Problem** occurs when an application executes one query to fetch a list of IDs and then $N$ subsequent queries to fetch details for each ID. This is extremely inefficient and should be resolved using **[[Joins|Joins]]** or batching.

---

## Industry Standard Terms
- **xmin / xmax** $\rightarrow$ Transaction Metadata / System Columns
- **TOAST** $\rightarrow$ Oversized Attribute Storage / LOB Storage
- **shared_buffers** $\rightarrow$ Buffer Pool
- **work_mem** $\rightarrow$ Sort/Hash Work Area
- **Change Buffer** $\rightarrow$ Deferred Write Buffer / Insert Buffer

## Related
- [[CSE444/Transactions/Isolation Levels|Isolation Levels]]
- [[CSE444/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage]]
- [[CSE351/Memory Fundamentals/Cache|CSE351 Cache Fundamentals]]
- [[CSE451/Processes/Architecture|CSE451 Process vs Thread Architectures]]
