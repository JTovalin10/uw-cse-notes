# Database Internals: Heap File and LOBs

## Large Objects (LOB)

- **BLOB** (**Binary Large Object**): binary data (images, audio, video)
- **CLOB** (**Character Large Object**): large text data
- Supported by modern database systems
- Storage strategy: attempt to **cluster blocks** of the LOB together on disk to enable sequential reads

---

## Heap File Implementations

A **heap file** is an unordered collection of pages containing records. It is the simplest file organization. The heap file exposes the same API as other access methods: create/destroy, insert, delete by RID, get by RID, and scan. See [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] for the full API and the comparison with sorted files.

![[Heap File Implementations.png]]

The two common heap file implementations are:
- **Linked-list heap file**: The header page contains pointers to a list of full pages and a list of pages with free space. Insertion scans the free-space list for a page with sufficient room. Simple to implement but requires a scan of the free-space list.
- **Page directory heap file**: A directory of pages maps each data page to its free-space count. The directory fits in a small number of pages, making free-space lookup much faster than the linked-list approach. This is the standard implementation.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| BLOB (Binary Large Object) | BLOB; also `bytea` (PostgreSQL), `VARBINARY` (SQL Server) |
| CLOB (Character Large Object) | CLOB; also `TEXT` (PostgreSQL), `LONGTEXT` (MySQL) |
| Heap file | Heap table / unordered data file |

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Heap and Sorted Files|Heap and Sorted Files]] — heap file API and sorted file comparison
- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Page and Record Formats|Page and Record Formats]] — how records are laid out within a heap file page
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — hub file for storage components
