# Data Storage: Disk and Layout

## Working with Disk

- Disk access is slow — **seeking** (moving the disk head) takes a long time
  - Seek time: 10–40ms; rotational latency: ~5ms
- **Sequential reads** are fast; random reads are expensive
  - Cost of random scan ≈ 1–2% of a full sequential scan
  - Bandwidth: typically 40–80 MB/s
- The unit of disk access is a **page** (= one disk block, fixed size, typically 512B–4KB)
- Only one block can be read per read operation
- One block contains one or more **tuples**

## Storage Layout: Row-Store vs. Column-Store

How tuples are physically laid out affects which workloads are fast:

| Layout | Description | Fast For |
|--------|-------------|----------|
| **Row-store** | All attributes of a tuple stored together on the same page | OLTP: retrieving full rows, point lookups, updates |
| **Column-store** | Each attribute stored in a separate file (one file per column) | OLAP: aggregating/scanning a single column across many rows |

Most traditional DBMSs (PostgreSQL, MySQL, Oracle) are row-stores. Analytical systems (Vertica, DuckDB, Snowflake) use column-stores because analytical queries typically scan a few columns over millions of rows.

**Additional layout options:**
- **Heap file**: unordered pages — no sorting guarantee
- **Sequential file**: pages ordered by an attribute (usually the primary key)
