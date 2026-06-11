# Database Internals: Undo Logging

**Undo Logging** is a recovery strategy used when a system follows a **Steal** policy. It allows the DBMS to revert changes made by transactions that did not successfully commit, as those uncommitted changes may have already been written to disk.

## Mechanism

An Undo Log record stores the "before image" of the data.

- **Record Format**: `<T, X, v>` where `v` is the **old value** of element X before the modification.
- **Purpose**: Enables the system to restore data to a known-good point in time or to create consistent snapshots.

![[Undo Log Example.png]]

## Protocol Rules

Undo logging is governed by two strict rules that ensure atomicity and the correctness of the recovery process:

1. **U1 (WAL Rule)**: If transaction `T` modifies element `X`, then the log record `<T, X, v>` must be written to disk *before* the dirty page containing `X` is flushed to disk (`OUTPUT(X)`).
2. **U2 (Force-like Rule)**: If `T` commits, then **all** dirty pages modified by `T` (`OUTPUT(X)`) must be written to disk *before* the `<COMMIT T>` record is written to the log.

### Mechanism Walkthrough: Why U1 and U2?

These rules are strictly required because Undo Logging lacks "after images" (redo information).

- **Why U1 (WAL)?**: If the DBMS flushed a dirty page to disk *before* the corresponding log record was persisted, and a crash occurred immediately after, the disk would contain uncommitted data. Without the log record, the Recovery Manager would have no knowledge of the transaction's previous state and would be unable to "undo" the change, violating **Atomicity**.
- **Why U2 (Force)?**: Since the log only contains old values, it cannot be used to "redo" a transaction. Therefore, the system must ensure that every change made by a committed transaction is already safely on disk *before* the `<COMMIT T>` record is persisted. If we wrote `<COMMIT T>` without forcing the data, a crash would result in a "committed" transaction whose changes are lost, violating **Durability**.

## Recovery Process

The recovery manager performs a backward scan of the log to revert changes from incomplete transactions. This process is typically divided into two logical phases.

### Phase 1: Analysis (Classification)
The system identifies which transactions completed successfully and which must be undone.

1. **Initialize Sets**: Create a set for **Committed** transactions and a set for **Losers** (incomplete).
2. **Scan Log**: The system scans the log to categorize transactions:
    - If `<COMMIT T>` or `<ABORT T>` is found, $T$ is considered **Complete**.
    - If only `<START T>` is found without a corresponding completion record, $T$ is a **Loser**.

### Phase 2: Undo Phase (Backward Scan)
The system restores the "before images" for all loser transactions to ensure Atomicity.

1. **Start Point**: Begin at the end of the log and scan backward toward the oldest relevant record (often the start of the log or the most recent checkpoint).
2. **Perform Undo**:
    - For every record $\langle T, X, v \rangle$:
    - Check if $T$ is a **Loser** (i.e., it has no `<COMMIT>` or `<ABORT>` record in the log).
    - If $T$ is a loser, write the **old value** $v$ to element $X$ on disk.
3. **Idempotency**: Because we apply the old values in reverse order, the process is idempotent. If a crash occurs during recovery, re-running the undo scan will result in the same consistent state.
4. **Finalization**: Once all losers are undone, the system may write `<ABORT T>` records for the losers to signify they have been handled.

## Recovery Walkthrough

Consider the following log sequence and disk state at the time of a crash. Assume elements $A, B, C, D$ initially have values $10, 20, 30, 40$.

**Log at Crash:**
1. `<START T1>`
2. `<T1, A, 10>`
3. `<START T2>`
4. `<T2, B, 20>`
5. `<T1, C, 30>`
6. `<COMMIT T1>` *(Note: By U2, A and C are guaranteed to be 11 and 31 on disk now)*
7. `<T2, D, 40>`
8. `--- CRASH ---`

### Step-by-Step Recovery

1. **Identify Losers**: Scanning the log, we see `<COMMIT T1>`, so $T1$ is committed. We see `<START T2>` but no `<COMMIT T2>`, so $T2$ is a **loser**.
2. **Backward Scan**:
    - **Record 7**: `<T2, D, 40>`. $T2$ is a loser. **Action**: Write $D = 40$ to disk.
    - **Record 6**: `<COMMIT T1>`. $T1$ is committed. **Action**: None (Mark $T1$ as "done" for this scan).
    - **Record 5**: `<T1, C, 30>`. $T1$ is committed. **Action**: Skip.
    - **Record 4**: `<T2, B, 20>`. $T2$ is a loser. **Action**: Write $B = 20$ to disk.
    - **Record 3**: `<START T2>`. **Action**: None.
    - **Record 2**: `<T1, A, 10>`. $T1$ is committed. **Action**: Skip.
    - **Record 1**: `<START T1>`. **Action**: None.

**Final Disk State**: $A=11, B=20, C=31, D=40$. Note that $T1$'s changes persisted while $T2$'s uncommitted changes to $B$ and $D$ were reverted.

## Trade-offs

| Pros | Cons |
|------|------|
| Simple recovery logic. | **High Commit Latency**: Forces all data to disk at commit time (Rule U2). |
| Supports Steal policy (memory efficiency). | **I/O Bottleneck**: Can result in many small, random disk writes during commit. |

---

## Formal Analysis

### Formal Definition
$S_{loser} = \{ T \mid \langle \text{START } T \rangle \in \text{Log} \land \langle \text{COMMIT } T \rangle \notin \text{Log} \land \langle \text{ABORT } T \rangle \notin \text{Log} \}$

For each record $\langle T, X, v \rangle$ in Log (scanned backwards):
If $T \in S_{loser}$, then $\text{OUTPUT}(X, v)$.

### Simplified Explanation
Find everyone who did not finish. Walk backwards through the log and put the old values back for those "losers" so it is as if their changes never happened.

![[Recovery With Undo Log.png]]

---

## Java Implementation

```java
public class UndoRecoveryManager {
    /**
     * Performs undo recovery by scanning the log backwards.
     * @param logRecords List of log entries, where the last element is the newest.
     */
    public void performUndoRecovery(List<LogRecord> logRecords) {
        Set<Integer> committedTransactions = new HashSet<>();
        Set<Integer> activeLosers = new HashSet<>();

        // Traverse log in reverse (from most recent to oldest)
        ListIterator<LogRecord> it = logRecords.listIterator(logRecords.size());
        while (it.hasPrevious()) {
            LogRecord record = it.previous();

            switch (record.getType()) {
                case COMMIT:
                case ABORT:
                    committedTransactions.add(record.getTransactionId());
                    break;

                case UPDATE:
                    if (!committedTransactions.contains(record.getTransactionId())) {
                        // Transaction is a loser; restore the "before image" (old value)
                        activeLosers.add(record.getTransactionId());
                        diskManager.write(record.getElementId(), record.getOldValue());
                    }
                    break;

                case START:
                    if (activeLosers.contains(record.getTransactionId())) {
                        // Transaction fully undone; in a real system, log a CLR or END record here
                        activeLosers.remove(record.getTransactionId());
                    }
                    break;
            }
        }

        // Finalize by flushing disk and persisting state
        diskManager.flush();
    }
}
```

### Key Properties

- **Scope**: Only updates from incomplete (uncommitted) transactions are undone.
- **Traversal**: Requires scanning backwards to ensure the most recent "old value" is applied first if multiple transactions touched the same element.
- **Idempotency**: Log records are idempotent; if the system crashes during recovery, re-running the algorithm from the same point results in the same correct state.

### Rollback vs. Recovery
- **Restart Recovery**: Triggered after a crash to restore consistency. Requires scanning the log backwards and undoing all incomplete transactions.
- **Rollback (Abort)**: Triggered for a specific transaction (e.g., on user error). Only the updates for that specific transaction are undone using the log.

## Industry Standard Terms
- **Undo Logging** $\rightarrow$ Transaction Rollback / Undo Segments (e.g., Oracle Undo tablespace, InnoDB Undo Logs)
- **Before Image** $\rightarrow$ Old value / Pre-update image
- **Losers** $\rightarrow$ Incomplete transactions / Active transactions at crash time

## Related
- [[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]
- [[Database Internals/Transactions/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]
- [[Database Internals/Transactions/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
