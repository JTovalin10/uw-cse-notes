# CSE444: DBMS Architecture and Query Processing

A DBMS has two major subsystems: the **Query Processor** (where queries are executed) and the **Storage Manager** (where data is stored).

## Table of Contents

1. [[CSE444/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] (Parser, Rewrite, Optimizer, Executor)
2. [[CSE444/DBMS Architecture and Deployments/Subsystems/Query Executor|Query Executor]] (Push vs Pull, Iterator Interface)
3. [[CSE444/DBMS Architecture and Deployments/Subsystems/Storage Manager|Storage Manager]] (Catalog, Pages, Access Methods)
4. [[CSE444/DBMS Architecture and Deployments/Subsystems/Buffer Manager|Buffer Manager]] (Caching, Eviction, Pinning)

---

## Related
- [[CSE444/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page/record formats, heap files, buffer pool details
- [[CSE444/Review of Relational Model/Relational Model|Relational Model]] — relational model theory and relational algebra
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — CSE344 in-depth coverage of RA operators
- [[SQL to RA Translation|SQL to RA Translation]] — translating SQL into relational algebra trees
- [[Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — physical operator implementations
- [[Database Indices|Database Indices]] — index structures used in access path selection
- [[CSE451/Virtualization/Architecture/OS Structure|CSE451]] (OS Structure and Layers)
