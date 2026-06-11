# Database Internals: Lost Update

A **Lost Update** (Write-Write Conflict) is a situation where two transactions both read the same data item and then update it, with the second update overwriting the first without incorporating the changes made by the first. The net effect is that one transaction's work is silently discarded.

Lost updates are prevented at the **[[Database Internals/Transactions/Isolation Levels|Serializable]]** isolation level and also prevented by [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]]'s First-Committer-Wins rule. Under [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|2PL]], exclusive write locks prevent two transactions from writing the same element concurrently.

## Industry Standard Terms
- **Lost Update** $\rightarrow$ Write-Write (WW) Conflict; defined in the ANSI SQL standard

## Related
- [[Database Internals/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
- [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]]
