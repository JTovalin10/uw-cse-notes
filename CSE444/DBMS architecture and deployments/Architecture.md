# CSE444: DBMS Architecture and Query Processing

A DBMS has two major subsystems: the **Query Processor** (where queries are executed) and the **Storage Manager** (where data is stored).

![[Screenshots/DBMS Architecture.png]]

---

## Query Processing Pipeline

Queries go through four stages before producing results.

### 1. Parser
- Parses the query into an internal format
- Performs validity checks against the **catalog** (schema metadata)

### 2. Query Rewrite
- **View rewriting**: expands view references into their underlying definitions
- Flattening and other logical simplifications

**Example** — given the view `NearbySupp`:
```sql
Supplier(sno, sname, scity, sstate)
Part(pno, pname, psize, pcolor)
Supplies(sno, pno, price)

CREATE VIEW NearbySupp AS
SELECT sno, sname
FROM Supplier
WHERE scity = 'Seattle' AND sstate = 'WA'
```

Original query:
```sql
SELECT sname
FROM NearbySupp
WHERE sno IN (SELECT sno FROM Supplies WHERE pno = 2)
```

Rewritten query (NearbySupp expanded):
```sql
SELECT S.sname
FROM Supplier S, Supplies U
WHERE S.scity = 'Seattle' AND S.sstate = 'WA'
  AND S.sno = U.sno AND U.pno = 2
```

### 3. Optimizer
- Finds an efficient **query plan** for executing the rewritten query
- A query plan exists in two forms:
  - **Logical plan**: an extended relational algebra tree
  - **Physical plan**: the logical plan annotated with implementation decisions
    - Access method to use for each relation (file scan vs. index)
    - Operator implementation to use at each node

#### Logical Query Plan
![[Screenshots/Logical Query Plan.png]]

#### Physical Query Plan
- Logical query plan with extra annotations
- Implementation choice for each operator
- **Access path selection** for each relation
  - Bottom of tree = reading from disk
  - Use a file scan or use an index

![[Screenshots/Physical Query Plan.png]]

### 4. Executor
- Actually executes the physical plan and returns results

---

## Query Executor

### Push vs. Pull Execution
- **Pull-based**: child operator answers "can I have a tuple?" with "here is a tuple" — the parent drives execution
- **Push-based**: child operator sends "here is a tuple" unprompted — the child drives execution
- Many modern databases (especially distributed ones) implement push-based execution because it reduces network round-trips

### Iterator Interface
Every operator implements an iterator interface (e.g., `OPIterator.java` in the labs):

| Method | Description |
|--------|-------------|
| `open()` | Initializes operator state; sets parameters like selection predicates |
| `next()` | Returns one tuple; recursively calls `next()` on child operators |
| `close()` | Cleans up operator state |

Each operator holds a reference to its child operator and can call `child.open()`, `child.next()`, etc.

![[Screenshots/Query Execution.png]]

---

## Storage Manager

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

### Buffer Manager
- Brings pages into memory and caches them in the **buffer pool**
- The buffer pool is divided into fixed-size **frames** (slots in memory); each frame holds one page
- **Pin count**: each frame has a pin count incremented when an operator is using the page and decremented when done — a frame with `pin_count > 0` cannot be evicted
- **Eviction policies** (when all frames are unpinned and the pool is full):
  - Random page
  - **Least Recently Used (LRU)**
  - The **clock algorithm** (approximates LRU with low overhead)
- Tracks which pages are **dirty** (modified in memory but not yet written to disk)
  - Each frame has a **dirty bit**
  - A dirty frame must be **flushed** to disk before it can be evicted (write-back)

![[Screenshots/Buffer Manager.png]]

See [[Data Storage and Buffer Management]] for details on page formats, record layouts, and heap file organization.

---

## Related
- [[Data Storage and Buffer Management]] — page/record formats, heap files, buffer pool details
- [[CSE444/Review of relational model/Relational Model|Relational Model]] — relational model theory and relational algebra
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — CSE344 in-depth coverage of RA operators
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — translating SQL into relational algebra trees
- [[CSE344/Query Execution/Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — physical operator implementations
- [[CSE344/Database Design/Database Indices|Database Indices]] — index structures used in access path selection
- [[CSE451/OS Architecture/OS Structure|CSE451]] (OS Structure and Layers)
