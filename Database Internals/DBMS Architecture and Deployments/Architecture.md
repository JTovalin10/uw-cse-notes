# Database Internals: DBMS Architecture and Query Processing

A DBMS has two major subsystems: the **Query Processor** (where queries are executed) and the **[[Database Internals/DBMS Architecture and Deployments/Subsystems/Storage Manager|Storage Manager]]** (where data is stored). Understanding how these two subsystems interact is the foundation for all query processing and optimization.

## Table of Contents

1. [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] — parser, rewrite, optimizer, executor
2. [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Executor|Query Executor]] — push vs. pull, iterator interface
3. [[Database Internals/DBMS Architecture and Deployments/Subsystems/Storage Manager|Storage Manager]] — catalog, pages, access methods
4. [[Database Internals/Data Storage, Indexing, and Buffer Management/StorageComponents/Buffer Manager|Buffer Manager]] — caching, eviction, pinning

---

## Related

- [[Database Internals/Data Storage, Indexing, and Buffer Management/Data Storage and Buffer Management|Data Storage and Buffer Management]] — page/record formats, heap files, buffer pool details
- [[Database Internals/Review of Relational Model/Relational Model|Relational Model]] — relational model theory and relational algebra
- [[Database Internals/Review of Relational Model/Relational Algebra|Relational Algebra]] — RA operators, joins, SQL-to-RA conversion
- [[Database Internals/DBMS Architecture and Deployments/Engine Internals|Engine Internals]] — PostgreSQL vs. InnoDB internals, MVCC implementations
- [[SQL to RA Translation|SQL to RA Translation]] — translating SQL into relational algebra trees
- [[Physical Algorithms and Pipelining|Physical Algorithms and Pipelining]] — physical operator implementations
