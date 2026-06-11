# Database Internals: Storage Manager

The **storage manager** sits below the query processor in the [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS architecture]] and is composed of three layers:

| Layer | Role |
|-------|------|
| **Access Methods** | Organize pages into DB files; organize data inside pages; expose an API for operators |
| **Buffer Manager** | Caches pages in memory; reads/writes pages to/from disk as needed |
| **Disk-Space Manager** | Allocates space on disk for files and access methods |

### Catalog
The **catalog** (also called the **system catalog** or **data dictionary**) is a special relation the DBMS maintains about itself:
- Schema of all relations (table names, column names, types)
- Index information (what indices exist, on which columns)
- Statistics: $T(R)$ = number of tuples, $V(R, \text{attr})$ = number of distinct values per attribute
- The parser and optimizer both query the catalog

### Key Idea: Pages
- A DBMS stores data on disk broken into **pages**
- A page = one disk block (fixed size)
- A page is the **unit of disk I/O** — you read/write one page at a time

### Access Methods
Access methods organize data into files and provide an API operators use to retrieve tuples:

| Access Method | Description |
|---------------|-------------|
| **Heap file** | Unordered collection of pages; supports full scans |
| **Sequential / sorted file** | Pages ordered by some attribute (usually the primary key) |
| **B+ tree index** | Balanced tree; supports point lookups and range scans efficiently |
| **Hash index** | Hash table; fast point lookups, but cannot do range scans |

The optimizer chooses among these during **access path selection** when building a physical plan. The choice depends on the query predicate, available indexes, and cardinality estimates stored in the catalog.

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Catalog | System catalog / Information Schema / Data Dictionary |
| Access methods | Storage engines (MySQL); access paths |
| Heap file | Heap table / sequential scan target |
| Page | Database page / disk block |
| $T(R)$ (number of tuples) | Cardinality / row count |
| $V(R, \text{attr})$ (distinct values) | NDV (Number of Distinct Values) |

## Related

- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — the two-subsystem model the storage manager belongs to
- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — detailed coverage of pages, record formats, heap files, and buffer pool
- [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]] — the buffer pool layer the storage manager depends on
- [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] — how the optimizer uses the catalog and access methods to build a physical plan
