# Course: Write-Ahead Logging (WAL)

The **Write-Ahead Logging (WAL)** rule is the foundational protocol for database durability and atomicity. It ensures that the log remains the "source of truth" that always precedes the actual data changes on disk.

## The WAL Rule

To ensure the DBMS can recover from any crash, two conditions must be met:

1. **Log Before Data**: All log records pertaining to an update must be flushed to non-volatile storage (disk) *before* the corresponding data page is allowed to be written to disk. This ensures that if the system crashes after the data is on disk but before the transaction commits, the DBMS has the "Undo" information needed to roll back.
2. **Commit Before Success**: A transaction is not considered committed until its `<COMMIT>` log record has been successfully flushed to stable storage. This ensures "Durability"—once the user is told the transaction succeeded, the changes are guaranteed to be in the log.

## Formal Definition
- For every update, a log record is created.
- `pageLSN <= FlushedLSN`: A page can only be flushed if its latest update's log sequence number is less than or equal to the LSN of the last log record flushed to disk.

## Simplified Explanation
Always write down what you are going to do before you do it. If you crash mid-way, you can look at your notes (the log) to see what you were doing and fix it.

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|Logging Types]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
