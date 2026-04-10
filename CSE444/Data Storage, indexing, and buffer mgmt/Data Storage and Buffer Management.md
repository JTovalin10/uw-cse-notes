# CSE444: Data Storage and Buffer Management

---

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

---

## Page Format

A **page** holds records and is the unit of I/O between disk and memory.

- **Record Id (RID)**: a pointer to a specific tuple on disk
  - Typically `RID = (pageId, slotNumber)`
  - Used by indexes and transaction logs to reference tuples
- Tuples are **fixed size** at the page level (e.g., `CHAR(100)` pads to 100 bytes even if shorter)
- Records can be **fixed-length** or **variable-length**

### Approach 1: Fixed-Length Records (Packed)
- Divide the page into fixed-size slots; each slot holds one tuple
- `RID = (PageID, SlotNumber)`
- **Adding a tuple**: find free space and claim it; update N (tuple count)
- **Deleting a tuple**: difficult — records cannot be moved because RIDs contain the slot number; also cannot handle variable-length tuples

![[Page Format Approach 1.png]]

### Approach 2: Slot Directory
- Sacrifice a small amount of space for a **slot directory** in the page header
- The slot directory stores `(offset, length)` pairs — fixed-size entries pointing into the page body
- **Deleting a slot**: remove the entry from the slot directory; the slot body space can be reclaimed and compacted
- Supports variable-length records cleanly
- slot directory grows left
- slots grow right

![[Page Format Approach 2.png]]

---

## Record Formats

### Fixed-Length Records
- Each field has a fixed, predetermined length
- The same byte length is used for every record in the relation
- Simple to navigate: field offset = sum of preceding field lengths

![[Record Formats.png]]

### Variable-Length Records
- Fields like `VARCHAR` can differ in length across records
- Requires storing offsets or delimiters to locate each field within a record

![[Variable length records.png]]

---

## Large Objects (LOB)

- **BLOB** (**Binary Large Object**): binary data (images, audio, video)
- **CLOB** (**Character Large Object**): large text data
- Supported by modern database systems
- Storage strategy: attempt to **cluster blocks** of the LOB together on disk to enable sequential reads

---

## Heap File Implementations

A **heap file** is an unordered collection of pages containing records. It is the simplest file organization.

![[Heap File Implementations.png]]

---

## Buffer Manager

The **buffer manager** sits between the storage layer and the rest of the DBMS. It caches disk pages in memory so operators don't read the same page from disk repeatedly.

- Brings pages in from disk and caches them in the **buffer pool**
- **Eviction policies** (which page to flush when the pool is full):
  - Random page (acceptable for simple implementations)
  - **Least-Recently Used (LRU)**
  - The **clock algorithm** (approximates LRU with lower overhead)
- Tracks which pages are **dirty** — a dirty page has in-memory modifications not yet written back to disk
  - Each frame has a **dirty bit**; a dirty frame must be flushed before eviction

![[screenshots/Buffer Manager Image.png]]

### Pushing Updates to Disk

- When inserting or deleting a tuple, `HeapFile` modifies the in-memory page but does **not** immediately write it to disk
- The buffer manager decides when to flush pages to disk (and when to read them in)
  - Cannot keep all pages in memory forever — flush only dirty pages when a frame is needed
- When adding a brand-new page to a file, `HeapFile` writes the page to disk and then reads it back through the buffer manager

> For pin counts, frame slots, and deeper buffer pool details see [[CSE444/DBMS architecture and deployments/Architecture#Buffer Manager|DBMS Architecture — Buffer Manager]].

---

## Related
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — how the buffer manager and storage manager fit into the full DBMS architecture
- [[CSE444/Data Storage, indexing, and buffer mgmt/Indexing|Indexes and File Organizations]] — heap file API, sorted files, and index structures built on top of heap files
- [[CSE344/Database Design/Disk Storage|Disk Storage]] — CSE344 coverage of disk storage fundamentals
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures built on top of heap files
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — how indices relate to physical data layout
- [[CSE344/Query Execution/External Memory Algorithms|External Memory Algorithms]] — algorithms designed around disk page access patterns
