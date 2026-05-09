# Storage Engine Fundamentals

## 1. Physical Layout

### Slotted Pages
A **Slotted Page** is the standard way to organize records within a page.
- **Header**: Contains a directory of (offset, length) pairs for every record.
- **Decoupling**: The record's physical position can change (e.g., during compaction) while its **Record ID (RID)**—which points to the slot index—stays constant. This prevents index pointers from breaking when data moves.

### Row vs. Column Stores
- **Row-Store (OLTP)**: Co-locates all attributes of a tuple. Ideal for point lookups and high-concurrency writes.
- **Column-Store (OLAP)**: Stores each attribute in a separate file. Ideal for scanning a few columns over millions of rows; enables high compression and SIMD optimizations.

---

## 2. Buffer Management

### Buffer Pool
A layer of memory that caches disk pages. It allows the DBMS to manage memory more intelligently than the OS by using domain-specific knowledge (e.g., sequential vs. random scans).

### LRU-K Replacement
Standard LRU suffers from **Sequential Flooding** (a single large scan evicts the entire "hot" cache).
- **LRU-K**: Tracks the time of the last $K$ references. A page read only once (during a scan) will have an extremely old $K$-th reference time and be evicted immediately, protecting hot data.

---

## 3. Indexing Internals

### B+ Tree Design
- **Disk Optimization**: All data is in leaf nodes, maximizing internal node fan-out and minimizing tree height (I/O).
- **Leaf Links**: Leaves are doubly-linked for fast range scans.
- **Page Splits**: When a page overflows, it splits into two. This is expensive due to new page allocation and potential parent updates.
- **Write Amplification**: Updating one record requires writing a full page ($4KB+$), multiplying the write load.

### Index Types & Rules
- **Clustered Index**: Determines the physical order of data on disk. Only one per table.
- **Covering Index**: An index that contains all columns needed for a query, allowing an **Index-Only Scan** (zero table lookups).
- **Leftmost Prefix Rule**: A composite index on $(A, B, C)$ can only be used if the query filters on $A$.
- **Index Bloat**: Disproportionate growth of index files due to fragmented splits or unreclaimed space from deleted MVCC tuples.

## Related
- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree Details]]
