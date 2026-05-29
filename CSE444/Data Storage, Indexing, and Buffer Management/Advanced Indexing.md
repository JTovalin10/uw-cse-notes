# Course: Advanced Indexing

Beyond standard B+ Trees, specialized index types are used to handle specific data distributions, query patterns, and complex data types.

## Index Types

### Bitmap Index
A **Bitmap Index** uses bit arrays (bitmaps) to represent the presence of a value in a column across all rows.
- **Suitability**: Best for low-cardinality columns (e.g., Gender, Boolean flags).
- **Advantage**: Allows for extremely fast Boolean query evaluation (AND, OR, NOT) using hardware-optimized bitwise operations.
- **Disadvantage**: Massive locking contention during updates, as updating a single bit typically requires locking the entire bitmap block.

### GIN (Generalized Inverted Index)
The **Generalized Inverted Index (GIN)** is designed for composite data types where queries search for values contained within the items (e.g., keys in a JSONB object, words in a document).
- **Structure**: Maps each internal component (token) to a list of row identifiers (TIDs) where it appears.
- **Trade-off**: Fast containment queries but very slow updates, as a single row modification may affect dozens of index entries.

### GiST (Generalized Search Tree)
The **Generalized Search Tree (GiST)** is a template index structure that allows users to define how to index arbitrary data types by providing custom 'consistent', 'union', and 'penalty' functions.
- **Use Cases**: R-trees for spatial data, Trigram indexes for fuzzy text search.

### Inverted Index
An **Inverted Index** is the foundation of full-text search, mapping every unique word to the list of documents (or rows) that contain it.

### R-Tree
The **R-Tree** is a tree data structure used for indexing spatial data (rectangles, polygons). It organizes data into nested, overlapping **Minimum Bounding Boxes (MBB)**.

## Index Internals and Maintenance

### Selectivity and Cardinality
- **Cardinality**: The number of unique values in a column.
- **Selectivity**: The fraction of rows in a table that match a specific predicate (e.g., $Selectivity = \frac{\text{matching rows}}{\text{total rows}}$).
- **Impact**: The query optimizer uses these metrics to decide whether to use an index scan or a full table scan. High selectivity (few rows returned) favors index usage.

### Online Index Build
An **Online Index Build** creates an index without taking an exclusive lock on the table, allowing concurrent write operations.
- **Mechanism**: A background process scans the table while a side-log captures concurrent changes. Once the scan is complete, the log is 'drained' into the new index before it is made live.

### Index Bloat
**Index Bloat** refers to the disproportionate growth of index files compared to the actual amount of data they represent.
- **Causes**:
  - **Fragmented Splits**: Frequent page splits in a B+ Tree can leave many nodes only half-full.
  - **MVCC Garbage**: In systems using Multi-Version Concurrency Control (MVCC), space from deleted tuples may not be immediately reclaimed, leading to "bloated" index pages that contain many pointers to dead versions.
- **Impact**: Increased disk space usage, more I/O required for scans, and reduced CPU cache efficiency.

### VACUUM and ANALYZE
- **VACUUM**: In MVCC systems like PostgreSQL, updates and deletes leave 'dead' tuples. VACUUM reclaims this space for reuse.
- **ANALYZE**: Collects statistics (histograms, most common values) about the data distribution to inform the query optimizer's cost estimations.

## Related
- [[CSE444/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]]
- [[CSE444/Data Storage, Indexing, and Buffer Management/LSM Trees|LSM Trees]]
- [[CSE444/Query Optimization/Query Optimization|Query Optimization]]
