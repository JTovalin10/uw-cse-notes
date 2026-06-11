# Database Internals: Storage Engine Fundamentals

A **storage engine** is the subsystem of a DBMS responsible for persisting data to disk, managing memory, and exposing data to the query execution layer. The three pillars it rests on are physical layout, buffer management, and indexing.

## Physical Layout

### Slotted Pages

A **Slotted Page** is the standard way to organize records within a page. The page is the unit of I/O between disk and memory — reading or writing a single record still causes a full page to be loaded.

- **Header**: Contains a directory of `(offset, length)` pairs for every record in the page body.
- **Decoupling**: The record's physical position can change (e.g., during compaction after deletions) while its **Record ID (RID)** — which points to the slot index, not the byte offset — stays constant. This prevents index pointers from breaking when data moves within a page.

See [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Page and Record Formats|Page and Record Formats]] for the full slotted-page layout diagram and alternative formats.

### Row vs. Column Stores

The choice of how to lay out attributes on disk determines which workloads are fast:

- **Row-Store (OLTP)**: Co-locates all attributes of a tuple on the same page. Ideal for point lookups and high-concurrency writes, where the access pattern is "fetch or update one complete record."
- **Column-Store (OLAP)**: Stores each attribute in a separate file. Ideal for scanning a few columns over millions of rows; enables high compression because homogeneous data compresses well, and enables SIMD vectorized execution because each column is a contiguous typed array.

See [[Database Internals/Data Storage, Indexing, and Buffer Management/Column-Store DBMSs|Column-Store DBMSs]] for the detailed trade-off analysis, including PAX (Partition Attributes Across) as a hybrid layout.

---

## Buffer Management

### Buffer Pool

The **buffer pool** is a layer of main memory that caches disk pages. It allows the DBMS to manage memory more intelligently than the OS by using domain-specific knowledge — for example, recognizing that a sequential scan should not pollute the cache with pages that will never be re-read, which the OS page cache cannot detect.

Each slot in the pool is called a **frame** and holds exactly one page. A **pin count** per frame prevents pages from being evicted while an operator is using them. A **dirty bit** marks frames that have been modified in memory but not yet written back to disk.

### LRU-K Replacement

Standard LRU suffers from **Sequential Flooding**: a single large scan evicts the entire "hot" working set because every page in the scan is freshly referenced and appears more recent than any repeatedly-used page.

**LRU-K** tracks the time of the last $K$ references per page. A page read only once (during a scan) has an extremely old $K$-th reference time (treated as $-\infty$ for missing references) and is therefore evicted first, protecting frequently accessed hot data from scan-driven eviction.

See [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]] for the full replacement policy comparison, including the clock algorithm.

---

## Indexing Internals

### B+ Tree Design

The [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] is the standard index structure in relational systems. Its design is shaped entirely by the cost of disk I/O:

- **Disk Optimization**: All data records (or pointers to records) live at the leaf level. Internal nodes store only separator keys to route searches, maximizing each node's **fan-out** and minimizing the tree's height (and thus the number of page reads per lookup).
- **Leaf Links**: Leaves are doubly-linked for efficient range scans — once the starting leaf is found, the scan proceeds along the chain without backtracking to internal nodes.
- **Page Splits**: When a node overflows during insertion, it splits into two nodes. This is expensive because it requires allocating a new page, distributing keys, and potentially propagating a separator key up to the parent recursively.
- **Write Amplification**: Updating a single byte of a record requires writing an entire page ($4$ KB or more), multiplying the actual write I/O relative to the logical data change.

### Index Types and Rules

- **Clustered Index**: Determines the physical order of data pages on disk. There can be only **one** clustered index per table, because data can only be sorted one way.
- **Covering Index**: An index that contains every column referenced by a query, enabling an **Index-Only Scan** — no page reads from the main table are needed at all.
- **Leftmost Prefix Rule**: A composite index on $(A, B, C)$ can only be leveraged if the query includes a filter on $A$. Queries filtering only on $B$ or only on $C$ cannot use the index because the B+ tree is ordered by $A$ first.
- **Index Bloat**: Disproportionate growth of index files caused by fragmented page splits (many nodes left half-full) or unreclaimed space from deleted MVCC tuples.

See [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Index Types|Index Types]] for the clustered vs. secondary index comparison, and [[Database Internals/Data Storage, Indexing, and Buffer Management/Advanced Indexing|Advanced Indexing]] for specialized structures such as Bitmap indexes, GIN, GiST, and R-Trees.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Buffer Pool | Page Cache / Buffer Cache |
| Frame | Page Frame / Slot |
| LRU-K | Extended LRU / Scan-Resistant Cache |
| Sequential Flooding | Cache thrashing / Scan pollution |
| Slotted Page | Heap Page / NSM Page |
| Write Amplification | Write amplification factor (WAF) |
| Clustered Index | Primary Index / IOT (Index-Organized Table) |
| Covering Index | Covering scan / Index-Only Scan |

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — hub linking all storage component files
- [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] — full B+ tree structure and operations
- [[Database Internals/Data Storage, Indexing, and Buffer Management/LSM Trees|LSM Trees]] — write-optimized alternative to B+ trees
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Column-Store DBMSs|Column-Store DBMSs]] — columnar layout, PAX, OLAP optimizations
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the storage engine fits into the full DBMS stack
