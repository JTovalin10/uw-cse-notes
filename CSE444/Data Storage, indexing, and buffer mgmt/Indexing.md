# CSE444: Indexes and File Organizations

> For buffer pool management and how pages are flushed to disk, see [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]].

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

![[Screenshots/Searching in a Heap File.png]]

#### Sorted File (Sequential File)

A file sorted on an attribute (usually the primary key) — we say the attribute is **indexed**.

```sql
CREATE INDEX s_sid ON Student(sid);

-- To force physical sorting:
CREATE CLUSTERED INDEX s_sid ON Student(sid);
```

- Binary search is possible: $O(\log_2 n)$ cost
- See [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]]

![[Screenshots/Sequential File.png]]

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

![[Screenshots/Indexes Image.png]]

### Clustered Index (Primary Index)

- Records in the data file have the **same order** as in the index
- **Dense index**: a `(key, RID)` pair for every record; each entry points to one specific record
  - ![[Screenshots/Dense Index.png]]
- **Sparse index**: stores only a subset of `(key, RID)` pairs; each entry points to a page rather than a specific record
  - Only works on a clustered index (requires physical sorting)
  - ![[Screenshots/Sparse Index.png]]

### Secondary Index (Unclustered Index)

- Does **not** determine placement of records in the data file
- All entries must be present — always **dense**
  - Cannot use the sparse index space optimization since the data is not physically sorted on the secondary key
- Inserts and deletions are expensive — the index must be updated

![[Screenshots/Secondary Indexes.png]]

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

See [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree]] — the most widely used index structure in relational DBMSs; supports both point lookups and range scans efficiently.

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

- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree]] — full details on the B+ tree index structure: degree, insertion, deletion, and optimizations
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, heap file structure, and buffer pool management
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — CSE344 coverage of clustered vs. unclustered design
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures overview from CSE344
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager fit together
