# CSE444: Indexes and File Organizations

Indexes and file organizations are critical for efficient data retrieval.

## Table of Contents

1. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Heap and Sorted Files|Heap and Sorted Files]] (Heap API, Searching, Sorted files)
2. [[CSE444/Data Storage, indexing, and buffer mgmt/StorageDetails/Index Types|Index Types: Clustered vs Secondary]] (Dense vs Sparse, Primary vs Secondary)
3. [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Trees]] (The most common index structure)

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
- [[CSE444/Data Storage, indexing, and buffer mgmt/B+ Tree|B+ Tree]] — full details on the B+ tree index structure
- [[CSE444/Data Storage, indexing, and buffer mgmt/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page formats, record formats, heap file structure, and buffer pool management
- [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]] — CSE344 coverage of clustered vs. unclustered design
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures overview from CSE344
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture]] — how the storage manager and buffer manager fit together
