# DBMS Architecture: Storage Manager

The storage manager sits below the query processor and is composed of three layers:

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

The optimizer chooses among these during **access path selection** when building a physical plan.
