# Database Internals: Logging Types

Databases use different logging strategies depending on the [[Database Internals/Transactions/RecoveryComponents/Buffer Management Policies|buffer management policies]] in effect and the performance requirements of the system.

## Log Record Structure

A full log record contains all information needed to both undo and redo a change:

``<T, X, old_v, new_v>``

- `T`: Unique Transaction ID.
- `X`: The element (page or record) being modified.
- `old_v`: The value *before* the update (used for **Undo**).
- `new_v`: The value *after* the update (used for **Redo**).

Each log record is assigned a **Log Sequence Number (LSN)**. Records belonging to the same transaction are linked via LSN pointers, enabling efficient backward traversal during recovery and rollback.

## Specific Log Types

The choice of logging strategy is dictated by the **Steal/No-Steal** and **Force/No-Force** policy combination:

- **[[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]**: Used with **Steal / Force**. Stores old values to revert uncommitted changes.
- **[[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]**: Used with **No-Steal / No-Force**. Stores new values to replay lost committed changes.
- **[[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]**: Used with **Steal / No-Force**. Stores both values for maximum flexibility; the industry standard.

## Mechanism & Abstraction

Logging efficiency and recovery speed are further defined by how state is captured and bounded:

- **[[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Checkpointing|Checkpointing]]**: Periodically marking a known-good state to bound recovery time.
- **[[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Log Abstraction Levels|Log Abstraction Levels]]**: The trade-off between Physical, Logical, and Physiological logging.

## Industry Standard Terms
- **LSN** $\rightarrow$ Log Sequence Number (universal term across RDBMS systems)
- **Undo Log** $\rightarrow$ Rollback segment / Undo segment (Oracle terminology)
- **Redo Log** $\rightarrow$ Redo log / Write-ahead log (used in MySQL InnoDB, Oracle)
- **Undo-Redo Log** $\rightarrow$ Combined WAL (PostgreSQL, SQL Server, DB2)

## Related
- [[Database Internals/Transactions/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[Database Internals/Transactions/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
- [[Database Internals/Transactions/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[Database Internals/Transactions/Recovery|Recovery Overview]]
