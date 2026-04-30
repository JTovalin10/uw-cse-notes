# Indexing: Clustered and Secondary Indexes

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

### Clustered vs. Unclustered Summary

| Property | Clustered (Primary) | Unclustered (Secondary) |
|----------|---------------------|--------------------------|
| Key order matches data order | Yes | No |
| Co-located with data file | Yes (common) | Always a separate file |
| Number allowed per table | Only one | Unlimited |
| Also called | Primary index | Secondary index |
