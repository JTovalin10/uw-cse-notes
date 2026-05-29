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

The recovery manager follows a three-phase process (**Analysis**, **Redo**, and **Undo**) to restore the database to a consistent state. This implementation typically utilizes a **Write-Ahead Log (WAL)** with a master pointer at the beginning of the file.

### Phase 1: Analysis (Finding the Starting Point)
Before redoing or undoing, the system must determine the crash state and the starting point for recovery.

1.  **Read Master Pointer**: Read the initial bytes of the log (e.g., Offset 0–8) to retrieve the `checkpointOffset`.
2.  **Initialize Loser Set**: Create a tracking set (e.g., `Set<Long> losers`) to identify transactions that were active at the time of the crash.
3.  **Process Checkpoint**:
    - If a checkpoint exists (`checkpointOffset != -1`), jump to that offset.
    - Read the list of active transactions stored in the checkpoint and add them to the `losers` set.
    - *Note*: Redo begins at the checkpoint because the checkpointing process ensures all prior dirty pages were already flushed to disk.
4.  **No Checkpoint**: If no checkpoint exists, start from the beginning of the log (skipping the master pointer).

### Phase 2: Redo Phase (Forward Pass)
The system scans the log forward from the starting point (Checkpoint or log start) to the end, "repeating history" to restore the disk to the exact state it was in at the moment of the crash.

1.  **Read Record Header**: For every record, read the transaction ID (TID) and record type.
2.  **Track Transaction Status**:
    - **BEGIN**: Add the TID to the `losers` set.
    - **COMMIT**: Remove the TID from the `losers` set (it is now a "Winner").
    - **ABORT**: Do nothing (it remains in the `losers` set).
3.  **Perform Redo**:
    - If the record is an **UPDATE**: Read the before and after images.
    - **Always Redo**: Write the `afterImage` (new value) to the corresponding disk page.
    - *Logic*: We redo *everything* (even for losers) because it is simpler to restore the entire crash state and then selectively "fix" the losers in the next phase.
4.  **Alignment**: Read the record footer (e.g., a trailing length or LSN) to ensure the file cursor remains aligned for the next record.

### Phase 3: Undo Phase (The Losers)
Once the crash state is restored, the system must revert the changes made by "Loser" transactions (those that started but never committed).

1.  **Reset Cursor**: Jump back to the beginning of the log (after the master pointer).
2.  **Scan Forward**: (Note: While backward scanning is technically faster, forward scanning is often implemented for simplicity with existing read tools).
3.  **Perform Undo**:
    - If an **UPDATE** record belongs to a TID in the `losers` set:
        - Read the before and after images.
        - **Undo**: Write the `beforeImage` (old value) to the disk. This replaces uncommitted data with the original "good" data.
        - **Buffer Sync**: Discard the page from the Buffer Pool cache to ensure subsequent reads pull the restored version from disk.
4.  **Alignment**: Continue reading payloads and footers to keep the cursor moving correctly through the log.

### Formal Definition
1. **Analysis**: $S_{loser} = \{ T \mid \langle \text{START } T \rangle \in \text{Log} \land \langle \text{COMMIT } T \rangle \notin \text{Log} \}$
2. **Redo**: For each $\langle T, X, \text{old\_v}, \text{new\_v} \rangle$ in Log (forward): $\text{WRITE}(X, \text{new\_v})$.
3. **Undo**: For each $\langle T, X, \text{old\_v}, \text{new\_v} \rangle$ in Log (backward): If $T \in S_{loser}$, then $\text{WRITE}(X, \text{old\_v})$.

### Simplified Explanation
First, find out who was still working when the power went out. Second, replay the entire log forward to get the disk back to the exact (messy) state it was in at the crash. Third, go back and undo the changes for anyone who never finished.

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

### Rollback vs. Recovery
It is important to distinguish between these two operations in a live system:
- **Restart Recovery**: The system-wide process triggered after a crash. It follows the three-phase process (Analysis, Redo, Undo) to restore the entire database to a consistent state.
- **Rollback (Abort)**: The process of undoing a single transaction's changes while the system is running (e.g., due to a user command or deadlock). The system uses the Undo portion of the log to revert only that specific transaction's updates.

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
