# Course: LSM Trees

Log-Structured Merge (LSM) Trees are data structures designed to provide high write throughput by transforming random writes into sequential I/O operations. They are the foundational storage architecture for many NoSQL databases and modern analytical engines.

## Core Architecture

An LSM Tree consists of two or more levels of data storage, typically organized by age and size.

### Memtable
The **Memtable** is an in-memory, sorted data structure (such as a Skip List or Red-Black Tree) that buffers incoming write operations. When the Memtable reaches a predefined size threshold, it is frozen and flushed to disk as an immutable **SSTable**.
- **Role**: Provides immediate write response and keeps recent data sorted.
- **Persistence**: To ensure durability during a crash, every write is also appended to a **Write-Ahead Log (WAL)** before being added to the Memtable.

### SSTable (Sorted String Table)
An **SSTable** is an immutable on-disk file containing a sorted sequence of key-value pairs. 
- **Structure**: Typically consists of a data block, an index block for fast lookups, and a **Bloom Filter**.
- **Immutability**: Once written, an SSTable is never modified. Updates and deletes are handled by inserting new versions or **Tombstones**.

## Read Path Optimizations

Because data for a single key may exist in multiple SSTables across different levels, reads can be expensive (Read Amplification).

### Bloom Filters
A **Bloom Filter** is a probabilistic data structure stored in memory that can quickly determine if a key is definitely NOT in a given SSTable.
- **Mechanism**: Checking the filter before disk I/O allows the system to skip irrelevant SSTables.
- **Trade-off**: False positives may occur, leading to unnecessary disk reads, but false negatives are impossible.

### Compaction
**Compaction** is the background process of merging multiple SSTables into a single, larger SSTable while removing redundant versions and expired **Tombstones**.

#### Leveled Compaction
- **Formal Definition**: Each level $L_i$ has a fixed size limit, and files within a level do not overlap in keyspace. When $L_i$ exceeds its limit, a file is merged with overlapping files in $L_{i+1}$.
- **Simplified Explanation**: Keeps levels clean and non-overlapping so reads only check one file per level.
- **Pro**: Minimal Read Amplification.
- **Con**: High Write Amplification due to frequent merges.

#### Tiered Compaction
- **Formal Definition**: Levels contain multiple SSTables that may overlap in keyspace. When a level reaches a certain number of files, they are all merged into a single file in the next level.
- **Simplified Explanation**: Wait until you have enough files, then smash them together all at once.
- **Pro**: Low Write Amplification, optimized for high-speed ingestion.
- **Con**: High Read Amplification as multiple files must be checked per level.

## RUM Conjecture
The **RUM Conjecture** (Read, Update, Memory) states that storage engines can only optimize for two of the following three overheads:
1. **Read Overhead**: The time taken to retrieve data.
2. **Update Overhead**: The cost of modifying or adding data.
3. **Memory/Storage Overhead**: The space required for data and auxiliary structures.

| Structure | Prioritizes | Sacrifices |
|-----------|-------------|------------|
| B+ Tree   | Read, Memory| Update     |
| LSM Tree  | Update      | Read, Memory|

## Related
- [[CSE444/Data Storage, Indexing, and Buffer Management/Indexing|Indexing]]
- [[CSE444/Transactions/Recovery/Recovery and Logging|Recovery and Logging]]
