# CSE444: DBMS Architecture and Query Processing

A DBMS has two major subsystems: the **Query Processor** (where queries are executed) and the **Storage Manager** (where data is stored).

## Table of Contents

1. [[Query Pipeline|Query Processing Pipeline]] (Parser, Rewrite, Optimizer, Executor)
2. [[Query Executor|Query Executor]] (Push vs Pull, Iterator Interface)
3. [[Storage Manager|Storage Manager]] (Catalog, Pages, Access Methods)
4. [[CSE444/DBMS Architecture and Deployments/Subsystems/Buffer Manager|Buffer Manager]] (Caching, Eviction, Pinning)

---

## Related
- [[Data Storage and Buffer Management|Data Storage and Buffer Management]] — page/record formats, heap files, buffer pool details
- [[Relational Model|Relational Model]] — relational model theory and relational algebra
- [[Introduction to Data Management/Query Execution/Relational Algebra|Relational Algebra]] — CSE344 in-depth coverage of RA operators
- [[SQL to RA Translation|SQL to RA Translation]] — translating SQL into relational algebra trees
- [[Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — physical operator implementations
- [[Database Indices|Database Indices]] — index structures used in access path selection
- [[OS Structure|CSE451]] (OS Structure and Layers)
