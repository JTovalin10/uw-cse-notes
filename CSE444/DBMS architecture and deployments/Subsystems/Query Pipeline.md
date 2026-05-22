# CSE444: Query Processing Pipeline

A DBMS has two major subsystems: the **Query Processor** (where queries are executed) and the **[[CSE444/DBMS architecture and deployments/Subsystems/Storage Manager|Storage Manager]]** (where data is stored).

![[Screenshots/DBMS Architecture.png]]

---

## Query Processing Pipeline

Queries go through four major stages before producing results.

### 1. Parser
- Parses the query into an internal format (often an Abstract Syntax Tree)
- Performs validity checks against the **Catalog** (schema metadata)

### 2. Query Rewrite
- **View Rewriting**: expands view references into their underlying definitions
- Flattening and other logical simplifications to improve initial structure

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

Rewritten query (`NearbySupp` expanded):
```sql
SELECT S.sname
FROM Supplier S, Supplies U
WHERE S.scity = 'Seattle' AND S.sstate = 'WA'
  AND S.sno = U.sno AND U.pno = 2
```

### 3. Optimizer
- Finds an efficient **Query Plan** for executing the rewritten query
- A query plan exists in two distinct forms:
  - **Logical Plan**: An extended **[[CSE444/Review of relational model/Relational Algebra|Relational Algebra]]** tree representing the semantic operations.
  - **Physical Plan**: The logical plan annotated with implementation decisions.
    - Access method to use for each relation (file scan vs. index)
    - Operator implementation to use at each node (e.g., **[[CSE444/Query Evaluation/Sort-Merge Join|Sort-Merge Join]]** vs. **[[CSE444/Query Evaluation/Partitioned Hash Algorithms|Hash Join]]**)

#### Logical Query Plan
![[Screenshots/Logical Query Plan.png]]

#### Physical Query Plan
- Logical query plan with extra annotations for execution.
- Implementation choice for each operator.
- **Access Path Selection** for each relation:
  - Bottom of the tree represents reading from disk.
  - Choice between a full **File Scan** or utilizing an **Index**.

![[Screenshots/Physical Query Plan.png]]

### 4. Executor
- Actually executes the physical plan and returns results to the user.
- Typically utilizes the **[[CSE444/DBMS architecture and deployments/Subsystems/Query Executor|Iterator Interface]]** for execution.

---

## Industry Standard Terms
- **Query Rewrite** $\rightarrow$ Query Normalization / Logical Optimization
- **Catalog** $\rightarrow$ Information Schema / Data Dictionary
- **Physical Plan** $\rightarrow$ Execution Plan

## Related
- [[CSE444/Query Optimization/Query Optimization|Query Optimization]] — deep dive into the optimizer's search space and cost estimation
- [[CSE444/DBMS architecture and deployments/Subsystems/Query Executor|Query Executor]] — iterator interface and execution details
- [[SQL to RA Translation|CSE344 SQL to RA Translation]]
