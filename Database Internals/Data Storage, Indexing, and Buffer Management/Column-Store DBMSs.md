# CSE444: Column-Store DBMSs

Storage layout determines which columns must be read from disk on every query. Row-stores minimize per-row I/O; column-stores minimize per-column I/O. Understanding the trade-offs requires first understanding how the disk/memory hierarchy shapes every layout decision.

## Working with Pages

Reading data from disk is dominated by **seek time** — the mechanical delay to position the read head. Once the head is positioned, sequential reads are fast. To amortize seek cost, the [[Data Storage and Buffer Management|buffer manager]] reads and writes in fixed-size units called **pages**, where one page corresponds to one disk block. Caching a collection of same-sized objects also simplifies the buffer manager: every slot in the buffer pool can hold any page.

## Column-Oriented Databases

The main idea of a **column-oriented (columnar) database** is to change physical storage while leaving the logical schema untouched:

- **Physical storage**: complete **vertical partition** — each column is stored separately on disk.
- **Logical schema**: remains identical to a traditional row-store; queries are written in standard SQL.

The central advantage is improved **transfer efficiency** at every layer of the memory hierarchy: disk → memory, memory → CPU cache. Because a single-column scan reads only the bytes it needs, cache lines are filled with useful data rather than irrelevant fields.

### From Row-Store to Column-Store

Each attribute type gets its own contiguous storage region. A row-store page holds all fields of a tuple together; a column-store file holds one field across all tuples.

![[Screenshots/From Row-Store to Column-Store.png]]

```
Row-store (NSM):
Page 1: [id=1, name="Alice", age=30, salary=90k] [id=2, name="Bob", age=25, salary=70k] ...

Column-store:
id file:     [1] [2] [3] [4] ...
name file:   ["Alice"] ["Bob"] ["Carol"] ...
age file:    [30] [25] [28] ...
salary file: [90k] [70k] [85k] ...
```

A query like `SELECT AVG(salary) FROM employees` on a row-store must load every full tuple — name, age, id, and all — even though only `salary` is needed. On a column-store, only the `salary` file is touched. For a table with 100 columns and a billion rows, this is the difference between reading 100× more data than necessary versus reading exactly what is needed.

## Row vs. Column Trade-offs in Depth

The performance gap between the two layouts is rooted in how the memory hierarchy works: a cache line is 64 bytes, a disk page is 4–16 KB, and both are fetched as atomic units. Every byte loaded that is not used is wasted bandwidth.

### Why Row-Stores Win for OLTP

In **OLTP** (Online Transaction Processing) workloads, the common access pattern is fetching or mutating one complete record: look up a user, update an order, insert a transaction. For these patterns:

- **Single-tuple read**: one page I/O returns all fields of the target record immediately. A column-store would need one I/O per column to reconstruct the full tuple, multiplying latency by the number of attributes.
- **Update**: modifying all fields of a row requires writing one page. In a column-store, each column file must be updated independently — $n$ writes for $n$ modified columns, plus the overhead of maintaining consistent positions across files.
- **Insert**: a new row appends to one location in a row-store. A column-store must append to every column file and maintain position alignment.

Row-stores use **slotted pages** precisely because OLTP records are variable-length and need stable addresses. The (page\_id, slot\_id) record ID remains valid after internal page compaction, supporting fast in-place updates.

### Why Column-Stores Win for OLAP

In **OLAP** (Online Analytical Processing) workloads, the common access pattern is aggregating or scanning a few columns across millions or billions of rows: total revenue by region, average session duration, distribution of response codes. For these patterns:

- **Projection efficiency**: only the columns referenced by the query are read from disk. If a table has 50 columns and the query touches 3, a column-store reads $\frac{3}{50}$ = 6% of the data a row-store would load.
- **Compression**: a column file contains homogeneous data — all integers, or all strings of the same domain. Homogeneous data compresses dramatically better than the heterogeneous mix on a row-store page. Run-length encoding (RLE) on a sorted integer column can compress 10:1 or better. This further reduces I/O because compressed data means more values fit in each page read.
- **Vectorized execution**: because a column is a contiguous array of uniform-typed values, the query engine can process it with SIMD (Single Instruction, Multiple Data) CPU instructions — operating on 4–16 values per clock cycle. Row-store records require per-tuple branching that prevents SIMD use.
- **Late materialization**: in a column-store, the engine delays reconstructing full tuples until the very last step, after all filters and projections have been applied. If a filter eliminates 99% of rows, only 1% of the remaining columns ever need to be fetched and stitched together.

### The Fundamental Tension: Reconstruction Cost

Column-stores pay a price: **tuple reconstruction**. When a query needs multiple columns (e.g., `SELECT name, salary WHERE age > 40`), the engine must align values across separate files by position to reconstruct output rows. This requires either:

- Storing explicit row IDs alongside each value (position-to-row mapping), or
- Assuming all column files are kept in the same sort order so position $i$ in every file corresponds to the same logical row.

This reconstruction overhead is negligible for pure aggregation queries (`SELECT AVG(salary)`) but becomes significant for queries that return many columns of many rows.

| Dimension | Row-Store (NSM) | Column-Store |
|---|---|---|
| Single-tuple read | Fast — one page I/O | Slow — one I/O per column |
| Full-tuple update | Fast — one page write | Slow — one write per column file |
| Insert | Fast — append one record | Slow — append to every column file |
| Projection scan | Slow — reads all columns | Fast — reads only needed columns |
| Aggregation | Slow — loads unused fields | Fast — tight loops over one array |
| Compression | Low — mixed types per page | High — homogeneous types compress well |
| Vectorized execution | Hard — mixed layout | Natural — contiguous typed arrays |
| Tuple reconstruction | Free — always co-located | Costly — must align across files |
| Best workload | OLTP (point reads/writes) | OLAP (analytical scans) |

## Slotted Pages

A **slotted page** is the standard disk-page format used by row-stores. The page header contains a slot array; each slot holds an (offset, length) pointer into the page body. This design has three key properties:

1. **Variable-length records**: since each slot points to an arbitrary byte range, records of any size can coexist on the same page.
2. **Stable external IDs**: external code refers to a record by (page\_id, slot\_id). When the page is compacted (records shifted to close gaps left by deletions), only the internal offsets in the slot array change — the slot\_id stays fixed, so no external references break.
3. **Free space management**: the page tracks a high-water mark for the slot array (growing from the top) and a high-water mark for record data (growing from the bottom). Insertion succeeds as long as these two regions have not met.

![[Screenshots/Slotted Pages.png]]

```
+------------------------------------------+
| num_slots=3 | free_ptr=... |              |  ← header
| slot[0]: offset=500, len=40              |
| slot[1]: offset=460, len=35  (deleted)   |
| slot[2]: offset=420, len=38              |
+------------------------------------------+
|              free space                  |
+------------------------------------------+
| record 2 data (38 bytes)                 |
| record 0 data (40 bytes)                 |
+------------------------------------------+
```

Slotted pages are the dominant format in row-stores because the free-space and variable-length requirements are nearly universal in OLTP workloads.

## Partition Attributes Across (PAX)

**PAX** (**Partition Attributes Across**) is an intermediate storage format that targets the **memory access bottleneck** rather than the disk bottleneck. The insight is that disk I/O and CPU cache behavior are independent problems: a system could have row-store disk layout but column-store cache behavior within each page.

### The Problem PAX Solves

A standard NSM (N-ary Storage Model / row-store) page loads all fields of every record into cache together. When a query scans only `salary`, the CPU still loads `name`, `age`, `id`, and every other field into the 64-byte cache line — they arrive as neighbors in memory. The result is **cache pollution**: useful cache space is consumed by data that will never be read, causing evictions of data that will be needed.

PAX eliminates this by reorganizing data within the page boundary. The page is still the unit of disk I/O (so the buffer manager is unchanged), but inside the page, values are grouped by attribute rather than by tuple.

### How PAX Works

Within each page, PAX stores all values of attribute A contiguously (a **mini-column**), then all values of attribute B, and so on. A small header at the start of the page records the offset to each mini-column so the engine can seek directly to the right array.

![[Screenshots/Partition Attribtues Across.png]]

```
NSM page layout (row-store):
[A1 B1 C1 D1] [A2 B2 C2 D2] [A3 B3 C3 D3] [A4 B4 C4 D4]
 ↑ cache line loads A,B,C,D together even if only A is needed

PAX page layout:
[header: offsets to each mini-col]
[A1 A2 A3 A4]   ← mini-column A: consecutive, fills cache lines with A values only
[B1 B2 B3 B4]   ← mini-column B
[C1 C2 C3 C4]
[D1 D2 D3 D4]
```

A scan over column A on a PAX page loads only A values into cache. Because the mini-column is a contiguous array, the hardware prefetcher can predict the access pattern and pre-load the next cache line before it is needed.

### PAX Properties

- **Eliminates unnecessary memory accesses**: a tight inner loop over one attribute reads a contiguous mini-array, not scattered interleaved fields.
- **Improves inter-record locality**: successive values of the same column land on adjacent cache lines; the CPU prefetcher works effectively.
- **Does not affect I/O performance**: the same disk blocks are fetched for PAX or NSM — buffer pool page size, disk access count, and I/O patterns are identical. The buffer manager requires no modification.
- **Low implementation cost, high impact**: PAX is a page-level internal reorganization. No changes to the storage manager, buffer manager, or query optimizer are required. The Ailamaki et al. (VLDB 2001) paper reported 20–50% query speedups from this single change.
- **Tuple reconstruction is local**: unlike a full column-store, all attributes of a record still live on the same page. Reconstructing a full tuple costs a single offset lookup per column — no cross-file I/O.

PAX is the most common practical implementation in modern row-store engines for analytical queries, and it directly inspired the Apache Arrow in-memory columnar format.

---

## Deep Dive

### Column-Store vs. Wide-Column Store (BigTable, Cassandra)

The term "column" appears in two completely different database concepts that are frequently confused:

**Column-store (columnar database)** — what this file covers — is about the *physical storage layout* on disk. Data is stored column-by-column to improve I/O efficiency for analytical queries. The data model is still relational (fixed schema, uniform rows). Examples: DuckDB, Vertica, MonetDB, Apache Parquet files.

**Wide-column store** is a *NoSQL data model* where rows can have a sparse, dynamic set of columns grouped into **column families**. The word "column" here refers to a key-value grouping in the data model, not to physical layout. Examples: Google BigTable, Apache Cassandra, Apache HBase.

The critical difference:

| Property | Column-Store (Columnar) | Wide-Column Store |
|---|---|---|
| What "column" means | Physical storage unit on disk | A key-value group in the data model |
| Schema | Fixed, relational schema | Sparse, dynamic — rows can have different columns |
| Physical layout | Actually stores columns contiguously | Row-oriented within each column family |
| Designed for | OLAP analytical scans | OLTP/NoSQL key-based access at scale |
| Example systems | DuckDB, Vertica, Parquet | Cassandra, BigTable, HBase |

In BigTable and Cassandra, **column families** are closer to a logical namespace for related attributes — they control how data is co-located and which columns are stored together. Within a column family, data is physically stored row by row (sorted by row key in BigTable, by partition key in Cassandra). The "column" in wide-column is a modeling concept, not a storage layout concept.

The confusion is a historical naming accident. BigTable's original 2006 paper called its data model "column-oriented" because each cell is addressed by (row key, column family, column qualifier, timestamp) — but this refers to the sparse key structure, not to storing all values of one column contiguously for scan performance.

**Practical implication**: if you want fast analytical scans over many rows and few columns, use a columnar store (Parquet, DuckDB). If you want scalable key-based access with flexible schemas and horizontal sharding, use a wide-column store (Cassandra, BigTable). Using Cassandra as an analytics engine over all rows of one "column" will be slow because it does not use columnar physical layout.

---

## Related
- [[Data Storage and Buffer Management]] — page formats, record formats, heap files, buffer pool eviction
- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Disk and Layout|Disk and Layout]] — seek time, sequential reads, storage layout fundamentals
- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Page and Record Formats|Page and Record Formats]] — slotted pages, fixed vs. variable-length records

## References
- Ailamaki et al. *Weaving Relations for Cache Performance*, VLDB 2001
- Abadi, Boncz, Harizopoulos, Idreos, Madden. *The Design and Implementation of Modern Column-Oriented Database Systems*, Foundations and Trends in Databases, 2012

## Industry Standard Terms
| Course Term | Industry / Standard Term |
|---|---|
| Column-oriented database | Columnar store (e.g., Apache Parquet, Apache ORC, DuckDB, Vertica) |
| PAX (Partition Attributes Across) | Hybrid row/column layout; Apache Arrow in-memory columnar format uses the same principle |
| NSM (N-ary Storage Model) | Row store / heap file; used by PostgreSQL, MySQL InnoDB |
| Vertical partition (physical) | Column projection pushdown; columnar file format |
| Late materialization | Projection pushdown; deferred tuple reconstruction |
| Mini-column (PAX) | Column chunk / row group column (Parquet terminology) |
