# CSE444: Indexes and File Organizations

---

## Buffer Manager (Review)

- Brings pages in from disk and caches them in the **buffer pool**
- **Eviction policies:**
  - Random page (acceptable for labs)
  - **Least-Recently Used (LRU)**
  - The "clock" algorithm (approximates LRU)
- Tracks which pages are **dirty** — a dirty page has unsaved changes not yet reflected on disk
  - Implementation: each page has a **dirty bit**

![[screenshots/Buffer Manager Image.png]]

### Pushing Updates to Disk

- When inserting or deleting a tuple, `HeapFile` modifies the in-memory page but does **not** immediately write it to disk
- The buffer manager decides when to flush pages to disk (and when to read them)
  - Cannot keep all pages in memory forever — flush only dirty pages when needed
- When adding a new page to a file, `HeapFile` adds the page to disk and then reads it back through the buffer manager

> See [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] for page formats, record formats, and heap file structure.

---

## Heap File Access Methods

### API

| Operation | Description |
|-----------|-------------|
| Create / Destroy | Create or delete a file |
| Insert | Insert a record |
| Delete | Delete a record by **RID** (unique tuple identifier) |
| Get | Retrieve a specific record by RID — used with indexes |
| Scan | Iterate over all records in the file |

- Sequential scan is fine for small tables, but becomes a bottleneck as the database grows

### Access by Attribute Value

Examples of attribute-based queries:
- `SELECT * FROM Supplier WHERE city = 'seattle'`
- `SELECT * FROM Student WHERE GPA > 3.5`
- `SELECT * FROM Student WHERE SID = 12345` — point lookup

#### Searching in a Heap File

- A heap file is **not sorted** on any attribute
- Attribute-based queries require a full sequential scan

![[screenshots/Searching in a Heap File.png]]

#### Sorted File (Sequential File)

A file sorted on an attribute (usually the primary key) — we say the attribute is **indexed**.

```sql
CREATE INDEX s_sid ON Student(sid);

-- To force physical sorting:
CREATE CLUSTERED INDEX s_sid ON Student(sid);
```

- Binary search is possible: $O(\log_2 n)$ cost
- See [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]]

![[screenshots/Sequential File.png]]

**Limitations of Sorted Files:**
- The $\log_2 n$ binary search only applies to the indexed attribute
- Queries on other attributes still require a full sequential scan — solved by adding a **secondary index**

---

## Indexes

An **index** is a separate file that enables fast access by a **search key** value.

- Contains pairs of the form `(key, RID)`
- Indexes are access methods — same API as heap files
- **Search key** = one attribute or a set of attributes (not necessarily the primary key)
- Index = collection of **data entries**

**Data entry for key k can be:**
- `(k, RID)` — pointer to one record
- `(k, list-of-RIDs)` — multiple pointers (when key is not unique)
- The full record with key k — a **clustered (primary) index**

![[screenshots/Indexes Image.png]]

### Clustered Index (Primary Index)

- Records in the data file have the **same order** as in the index
- **Dense index**: a `(key, RID)` pair for every record; each entry points to one specific record
  - ![[screenshots/Dense Index.png]]
- **Sparse index**: stores only a subset of `(key, RID)` pairs; each entry points to a page rather than a specific record
  - Only works on a clustered index (requires physical sorting)
  - ![[screenshots/Sparse Index.png]]

### Secondary Index (Unclustered Index)

- Does **not** determine placement of records in the data file
- All entries must be present — always **dense**
  - Cannot use the sparse index space optimization since the data is not physically sorted on the secondary key
- Inserts and deletions are expensive — the index must be updated

![[screenshots/Secondary Indexes.png]]

### Overflow Pages

- Located at the end of the file
- Temporarily store updated or new records without immediately reorganizing existing pages
- Works with indexed heap files

### Clustered vs. Unclustered Summary

| Property | Clustered (Primary) | Unclustered (Secondary) |
|----------|---------------------|--------------------------|
| Key order matches data order | Yes | No |
| Co-located with data file | Yes (common) | Always a separate file |
| Number allowed per table | Only one | Unlimited |
| Also called | Primary index | Secondary index |

---

## Index Organizations

### Ordered File

- Simple sequential ordering (as shown in the diagrams above)
- Becomes increasingly difficult to maintain with frequent inserts and deletes

### Hash Table

- Supports equality lookups efficiently
- Inferior to B+ trees for range queries

### B+ Tree

A **B+ tree** is a balanced search tree optimized for disk-page access.

**B-tree idea:**
- One node = one page (one disk block)
- Maximize branching factor (number of children per node) to minimize height
- Keep tree height small to minimize the number of page reads

**B+ tree additions:**
- Keys are stored only at the **leaves** — internal nodes just guide search
- **Leaves are linked** in a linked list, enabling efficient range queries
- Each node access = one page read (expensive; the whole point is minimizing tree height)

![[screenshots/B+ Tree example.png]]

---

## File Organization Summary

| File Type | Description | Used For |
|-----------|-------------|----------|
| Heap file | Tuples stored without order | General-purpose unordered storage |
| Sequential file | Tuples sorted on attribute(s) | Range scans on the sort key |
| Clustered (primary) index file | Relation + index co-located | Fast access with binary search |
| Unclustered (secondary) index file | Stores `(key, RID)` pairs separately | Multi-attribute access patterns |

- A table can have at most **one** clustered index but **many** unclustered indexes

---

## Related

- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, heap file structure, and buffer pool management
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — CSE344 coverage of clustered vs. unclustered design
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures overview from CSE344
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager fit together
