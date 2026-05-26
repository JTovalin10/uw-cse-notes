# CSE444: Logging Types

Databases use different logging strategies depending on the [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|buffer management policies]] in effect and the performance requirements of the system.

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

- **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]**: Used with **Steal / Force**. Stores old values to revert uncommitted changes.
- **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]**: Used with **No-Steal / No-Force**. Stores new values to replay lost committed changes.
- **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]**: Used with **Steal / No-Force**. Stores both values for maximum flexibility; the industry standard.

## Mechanism & Abstraction

Logging efficiency and recovery speed are further defined by how state is captured and bounded:

- **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Checkpointing|Checkpointing]]**: Periodically marking a known-good state to bound recovery time.
- **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Log Abstraction Levels|Log Abstraction Levels]]**: The trade-off between Physical, Logical, and Physiological logging.

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
