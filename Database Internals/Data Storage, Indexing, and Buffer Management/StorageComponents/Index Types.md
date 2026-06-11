# Database Internals: Index Types

An **index** is a separate data structure that enables fast access by a **search key** value, avoiding a full sequential scan of the heap file. Indexes are access methods — they expose the same API as heap files (insert, delete, scan, get by key) but internally organize entries in a way that supports efficient key-based lookup.

- Contains pairs of the form `(key, RID)`
- Indexes are access methods — same API as heap files
- **Search key** = one attribute or a set of attributes (not necessarily the primary key)
- Index = collection of **data entries**

**Data entry for key k can be:**
- `(k, RID)` — pointer to one record
- `(k, list-of-RIDs)` — multiple pointers (when key is not unique)
- The full record with key k — a **clustered (primary) index**

![[Indexes Image.png]]

### Clustered Index (Primary Index)

- Records in the data file have the **same order** as in the index
- **Dense index**: a `(key, RID)` pair for every record; each entry points to one specific record
  - ![[Dense Index.png]]
- **Sparse index**: stores only a subset of `(key, RID)` pairs; each entry points to a page rather than a specific record
  - Only works on a clustered index (requires physical sorting)
  - ![[Sparse Index.png]]

### Secondary Index (Unclustered Index)

- Does **not** determine placement of records in the data file
- All entries must be present — always **dense**
  - Cannot use the sparse index space optimization since the data is not physically sorted on the secondary key
- Inserts and deletions are expensive — the index must be updated

![[Secondary Indexes.png]]

### Clustered vs. Unclustered Summary

| Property | Clustered (Primary) | Unclustered (Secondary) |
|----------|---------------------|--------------------------|
| Key order matches data order | Yes | No |
| Co-located with data file | Yes (common) | Always a separate file |
| Number allowed per table | Only one | Unlimited |
| Also called | Primary index | Secondary index |

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Clustered index | Primary index / IOT (Index-Organized Table) |
| Secondary index | Unclustered index / non-clustered index |
| Dense index | Full index / row-level index |
| Sparse index | Page-level index / block-level index |
| Search key | Index key |
| RID (Record ID) | Row ID / physical row pointer |

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] — the most common data structure used to implement both clustered and unclustered indexes
- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] — the underlying file organizations on top of which indexes are built
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Indexing|Indexing]] — hub file for indexes and file organizations
