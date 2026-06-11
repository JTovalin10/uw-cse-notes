# Database Internals: Write Skew

**Write Skew** is a concurrency anomaly possible under [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]] where two transactions $T_1$ and $T_2$ read overlapping data sets but update disjoint sets, violating a cross-record constraint. Because neither transaction modifies the exact same record, the First-Committer-Wins rule does not catch the conflict.

The classic example: a rule requires at least one doctor on call. Both Dr. Alice and Dr. Bob see the other is on call and each signs off. Neither write conflicts with the other, yet the constraint "at least one on call" is broken. Preventing Write Skew requires moving to the **[[Database Internals/Transactions/Isolation Levels|Serializable]]** isolation level or using Serializable Snapshot Isolation (SSI).

## Industry Standard Terms
- **Write Skew** $\rightarrow$ Read-Write Skew; a known limitation of Snapshot Isolation addressed by SSI (Serializable Snapshot Isolation)

## Related
- [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
- [[Database Internals/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
