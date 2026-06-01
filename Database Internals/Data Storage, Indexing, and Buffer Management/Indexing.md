# CSE444: Indexes and File Organizations

Indexes and file organizations are critical for efficient data retrieval.

## Table of Contents

1. [[Heap and Sorted Files|Heap and Sorted Files]] (Heap API, Searching, Sorted files)
2. [[Index Types|Index Types: Clustered vs Secondary]] (Dense vs Sparse, Primary vs Secondary)
3. [[B+ Tree|B+ Trees]] (The most common index structure)

---

## File Organization Summary

| File Type | Description | Used For |
|-----------|-------------|----------|
| Heap file | Tuples stored without order | General-purpose unordered storage |
| Sequential file | Tuples sorted on attribute(s) | Range scans on the sort key |
| Clustered (primary) index file | Relation + index co-located | Fast access with binary search |
| Unclustered (secondary) index file | Stores `(key, RID)` pairs separately | Multi-attribute access patterns |

---

## Related
- [[B+ Tree|B+ Tree]] — full details on the B+ tree index structure
- [[Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, heap file structure, and buffer pool management
- [[Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — CSE344 coverage of clustered vs. unclustered design
- [[Database Indices|Database Indices]] — index structures overview from CSE344
- [[Architecture|DBMS Architecture]] — how the storage manager and buffer manager fit together
