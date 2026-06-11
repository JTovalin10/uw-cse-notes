# Database Internals: Indexes and File Organizations

Indexes and file organizations are critical for efficient data retrieval. This file serves as the navigation hub for the index-related StorageComponents subtopics.

## Table of Contents

1. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] — heap file API, attribute-based searching, sorted files
2. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Index Types|Index Types: Clustered vs. Secondary]] — dense vs. sparse, primary vs. secondary
3. [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Trees]] — the most common index structure

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

- [[Database Internals/Data Storage, Indexing, and Buffer Management/B+ Tree|B+ Tree]] — full details on the B+ tree index structure
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Advanced Indexing|Advanced Indexing]] — specialized index types: Bitmap, GIN, GiST, R-Tree, and maintenance
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, heap file structure, and buffer pool management
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager fit together
