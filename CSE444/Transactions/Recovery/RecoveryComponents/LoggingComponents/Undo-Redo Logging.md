# CSE444: Undo-Redo Logging

**Undo-Redo Logging** is the industry-standard logging strategy and the basis for modern recovery algorithms like [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES]]. It combines both strategies to support a **Steal / No-Force** buffer management policy, providing maximum flexibility and performance.

## Mechanism

Every log record stores both the "before image" (undo) and the "after image" (redo) of the modified data.

- **Record Format**: `<T, X, old_v, new_v>`
	- `T`: Transaction identifier.
	- `X`: The data element (page or record).
	- `old_v`: The value before the update (used for **Undo**).
	- `new_v`: The value after the update (used for **Redo**).

![[Screenshots/Recovery with UndoRedo Log.png]]

## Protocol Rules

Undo-Redo logging follows the core **Write-Ahead Logging (WAL)** principle:

1. **UR1**: If transaction `T` modifies element `X`, then the log record `<T, X, old_v, new_v>` must be written to disk **before** the dirty page containing `X` is flushed to disk (`OUTPUT(X)`).
2. **UR2**: All log records (including the `<COMMIT T>` record) must be flushed to disk before the transaction is considered successfully committed.

Unlike Undo or Redo logging, there are no additional constraints on *when* dirty pages must be flushed:
- **Steal is allowed**: Dirty pages can be flushed to disk at any time to free buffer space (supported by `old_v`).
- **No-Force is allowed**: Committed pages do not need to be forced to disk immediately (supported by `new_v`).

## Recovery Process

The recovery manager typically follows a three-step process (Analysis, Redo, Undo) to restore the database to a consistent state.

### 1. Analysis Phase
Scan the log to identify **Winners** (transactions that have a `<COMMIT>` record) and **Losers** (transactions that have a `<START>` but no `<COMMIT>` or `<ABORT>` record).

### 2. Redo Phase (Repeating History)
Scan the log **forward** from the last checkpoint. For every update record `<T, X, old_v, new_v>`, set `X = new_v`. This restores the database to the exact state it was in at the moment of the crash.

### 3. Undo Phase
Scan the log **backward** from the end. For every update record belonging to a **Loser** transaction, set `X = old_v`.

![[Screenshots/Undo, Redo crash.png]]

## Recovery Walkthrough

Consider the following log sequence and a system crash at the end:

1.  **LSN 10**: `<START T1>`
2.  **LSN 20**: `<T1, A, 10, 20>`
3.  **LSN 30**: `<START T2>`
4.  **LSN 40**: `<T2, B, 50, 60>`
5.  **LSN 50**: `<COMMIT T1>`
6.  **LSN 60**: `<START T3>`
7.  **LSN 70**: `<T3, C, 100, 110>`
8.  **LSN 80**: `<T2, A, 20, 30>` (T2 updates A after T1 committed)
9.  **`<CRASH>`**

### Recovery Steps

1.  **Analysis**:
    *   **Winners**: $\{T_1\}$ (has `<COMMIT>` at LSN 50).
    *   **Losers**: $\{T_2, T_3\}$ (started but never committed).
2.  **Redo Phase (Forward Scan)**:
    *   Redo LSN 20: $A = 20$
    *   Redo LSN 40: $B = 60$
    *   Redo LSN 70: $C = 110$
    *   Redo LSN 80: $A = 30$
    *   *State at end of Redo*: $A=30, B=60, C=110$.
3.  **Undo Phase (Backward Scan)**:
    *   Undo LSN 80 ($T_2$ is loser): $A = 20$
    *   Undo LSN 70 ($T_3$ is loser): $C = 100$
    *   Undo LSN 40 ($T_2$ is loser): $B = 50$
    *   *Final Consistent State*: $A=20$ (T1's change), $B=50$ (Original), $C=100$ (Original).

## Implementation: Combined Logic (Java)

The following Java implementation illustrates the three-phase recovery logic for an Undo-Redo manager:

```java
public class UndoRedoRecoveryManager {
    public void recover(List<LogRecord> logRecords) {
        Set<Integer> winners = new HashSet<>();
        Set<Integer> losers = new HashSet<>();

        // Phase 1: Analysis (Forward Scan)
        for (LogRecord record : logRecords) {
            switch (record.getType()) {
                case START:
                    losers.add(record.getTransactionId());
                    break;
                case COMMIT:
                    winners.add(record.getTransactionId());
                    losers.remove(record.getTransactionId());
                    break;
                case ABORT:
                    losers.remove(record.getTransactionId());
                    break;
            }
        }

        // Phase 2: Redo Phase (Forward Scan - Repeating History)
        for (LogRecord record : logRecords) {
            if (record.getType() == LogType.UPDATE) {
                // In Undo-Redo, we redo ALL updates first to restore state
                diskManager.write(record.getElementId(), record.getNewValue());
            }
        }

        // Phase 3: Undo Phase (Backward Scan)
        ListIterator<LogRecord> it = logRecords.listIterator(logRecords.size());
        while (it.hasPrevious()) {
            LogRecord record = it.previous();
            if (record.getType() == LogType.UPDATE && losers.contains(record.getTransactionId())) {
                // Restore old value for transactions that never committed
                diskManager.write(record.getElementId(), record.getOldValue());
            }
        }
        
        diskManager.flush();
    }
}
```

## Performance and Buffer Policy

Undo-Redo logging is the only strategy that supports the **Steal / No-Force** policy combination, which is critical for high-performance database systems.

### Policy Support
- **Steal Support**: By storing `old_v`, the system can "steal" a page from a running transaction and write it to disk to free up buffer space. If the transaction later aborts or the system crashes, the `old_v` allows the recovery manager to revert the change.
- **No-Force Support**: By storing `new_v`, the system does not have to "force" committed pages to disk at the moment of commit. If the system crashes before the dirty page reaches disk, the `new_v` allows the recovery manager to replay the commit.

### Log Size vs. Performance Gain
The primary drawback of this strategy is **Log Record Size**. Since each update record must store both the pre-state and post-state, the log can grow significantly faster than Undo-only or Redo-only logs. 

However, this is a favorable trade-off for most workloads because:
1.  **Sequential I/O**: Writing to the log is a sequential append operation, which is extremely fast on both HDDs and SSDs.
2.  **Decoupled I/O**: Supporting **No-Force** means the database can group many page writes together and perform them in the background (asynchronous checkpoints), rather than stalling the user during a transaction commit for random I/O writes.

## Industry Standard Mapping
- **Undo-Redo Logging** $\rightarrow$ Standard WAL with Undo Segments / CLRs (e.g., IBM DB2, SQL Server, MySQL InnoDB, PostgreSQL).

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
