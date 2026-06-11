# Database Internals: Dirty Read

A **Dirty Read** (Write-Read Conflict) is a situation where transaction $T_2$ reads a data item $X$ that was previously modified by transaction $T_1$, where $T_1$ has not yet issued a `COMMIT`. If $T_1$ subsequently performs a `ROLLBACK`, $T_2$ has processed state that never existed in the persistent database.

This is prevented at the **[[Database Internals/Transactions/Isolation Levels|Read Committed]]** isolation level and above. Under [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Strict 2PL]], dirty reads are impossible because write locks are held until commit.

## Industry Standard Terms
- **Dirty Read** $\rightarrow$ Write-Read (WR) Conflict; defined in the ANSI SQL standard as a prohibited anomaly above Read Uncommitted

## Related
- [[Database Internals/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
- [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]]
