# DBMS Architecture: Query Processing Pipeline

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
