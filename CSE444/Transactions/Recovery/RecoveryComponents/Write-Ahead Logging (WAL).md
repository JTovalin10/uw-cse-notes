# CSE444: Write-Ahead Logging (WAL)

The **Write-Ahead Logging (WAL)** rule is the foundational protocol for database durability and atomicity. It ensures that the log remains the authoritative source of truth by always preceding the actual data changes on disk: the log entry must be written before any `OUTPUT`, and the `<COMMIT>` record must be written before the transaction is considered complete.

## The WAL Rule

To ensure the DBMS can recover from any crash, two conditions must be met before any disk I/O is permitted:

1. **Log Before Data**: All log records pertaining to an update must be flushed to non-volatile storage *before* the corresponding data page is written to disk. This ensures that if the system crashes after the data is on disk but before the transaction commits, the DBMS has the Undo information needed to roll back — no committed change is ever lost.
2. **Commit Before Success**: A transaction is not considered committed until its `<COMMIT>` log record has been successfully flushed to stable storage. This guarantees Durability — once the user is told the transaction succeeded, the changes are guaranteed to be in the log, regardless of what happens to the buffer pool.

### Formal Definition

For every update, a log record is created. The key invariant is:

$$\text{pageLSN} \leq \text{FlushedLSN}$$

A page can only be flushed to disk if its most recent update's **Log Sequence Number (LSN)** is less than or equal to the LSN of the last log record already flushed to disk. The log must always be ahead of the data.

### Simplified Explanation

Always write down what you are about to do before you do it. If you crash mid-operation, you can look at your notes (the log) to determine exactly what was in-flight and either undo or redo it.

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|Logging Types]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
