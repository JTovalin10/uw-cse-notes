# CSE444: Redo Logging

**Redo Logging** is a recovery strategy used when a system follows a **No-Force** policy. It allows the DBMS to replay changes that were committed but lost from the buffer pool during a crash, since committed pages may not have been flushed to disk before the failure.

## Mechanism

A Redo Log record stores the "after image" of the data.

- **Record Format**: `<T, X, v>` where `v` is the **new value** of element X after the modification.
- **Interpretation**: While the format is identical to an Undo Log, the value stored is what the element *should* be set to, not what it was before.

![[Recovery with Redo Logging.png]]

## Protocol Rules

Redo logging is governed by two rules that ensure durability and simplify recovery by avoiding the need for undo operations:

1. **R1 (WAL Rule)**: If transaction `T` modifies element `X`, then the log record `<T, X, v>` must be written to disk *before* `OUTPUT(X)`.
2. **R2 (No-Steal Constraint)**: All log records for transaction `T`, including the `<COMMIT T>` record, must be flushed to disk *before* **any** of `T`'s dirty pages are written to disk.

### Mechanism Walkthrough: Why No-Steal?

The **R2** rule effectively enforces a **No-Steal** policy. In a No-Steal system, the buffer manager is prohibited from flushing a dirty page to disk until the transaction that modified it has committed.

- **The Dependency**: Since Redo Log records only store the **after-image** (the new value `v`), the system has no record of the "old value" that existed before the update.
- **The Risk**: If the system allowed "Steal" (writing uncommitted data to disk) and then crashed, the disk would contain uncommitted data. Without an undo log, the Recovery Manager would have no way to revert these changes to a consistent state.
- **The Solution**: By requiring that the `<COMMIT T>` record be flushed *before* any data pages are written, we ensure that the only way an update reaches the disk is if the transaction has already committed (at which point it is safe) or if it has not yet committed but the pages are still only in the volatile buffer pool (where they will be wiped upon a crash, effectively "undoing" them).

## Recovery Process

The recovery manager performs **two forward passes** over the log to restore committed data that may have been lost from the buffer pool. Unlike the three-phase [[Database Internals/CSE444/Transactions/Recovery/ARIES|ARIES]] algorithm, simple Redo logging has **no Analysis phase** that reconstructs in-memory tables (ATT/DPT) and **no Undo phase** — the No-Steal policy makes undo unnecessary.

### Pass 1: Identify Committed Transactions (Winners)
The first pass exists only to determine *which* transactions committed, because a `<COMMIT T>` record may appear in the log after `T`'s update records. We cannot redo an update on the spot without first knowing its transaction's final outcome.

1.  **Scan Log Forward**: Start from the beginning of the log (or the last checkpoint).
2.  **Collect Committed Transactions**:
    - If a `<COMMIT T>` record is found, add $T$ to the **Winners** set.
    - If only `<START T>` (or an `<ABORT T>`) is present with no commit, $T$ is **not** a winner and will be ignored.
3.  **Result**: The complete set of transactions that reached a committed state before the crash.

Note that this is *not* the ARIES Analysis phase: we do not rebuild the Active Transaction Table or Dirty Page Table, and we do not track losers — incomplete transactions simply do not appear in the Winners set.

### Pass 2: Redo Committed Transactions (Forward)
The second pass replays the "after images" of committed transactions only, in **forward (earliest-to-latest) order**, to ensure Durability.

1.  **Start Point**: Restart the scan from the beginning of the log.
2.  **Perform Redo**:
    - For every update record $\langle T, X, v \rangle$:
    - Check if $T$ is in the **Winners** set.
    - If $T$ is a winner, write the **new value** $v$ (after-image) to element $X$ on disk.
3.  **Why Forward Order**: Redo must proceed oldest-first so that when several committed updates touch the same element $X$, the **latest** value is the one that ends up on disk. (This is the mirror image of Undo logging, which must scan backward to apply the *oldest* before-image last.)
4.  **Ignore Losers**: If $T$ is not in the Winners set, its updates are skipped entirely. Crucially, simple Redo logging does **not** "repeat history" by redoing losers the way ARIES does — because the **No-Steal** rule guarantees uncommitted changes never reached disk, there is nothing to redo and nothing to undo for them.

### Finalization
After the redo pass, the recovery manager writes an `<ABORT T>` record for each incomplete transaction. This marks them as resolved so a subsequent crash during recovery will not reconsider them.

### How Redo Logging Differs From ARIES
| Aspect | Simple Redo Logging | ARIES |
|--------|--------------------|-------|
| Buffer policy | No-Steal / No-Force | Steal / No-Force |
| First pass | Identify committed transactions (Winners) | Analysis: rebuild ATT + DPT, find Losers |
| Redo scope | Winners only | "Repeating History" — redo **all** updates (winners and losers) |
| Undo phase | None (No-Steal means losers never hit disk) | Required — roll back Losers using CLRs |
| Passes | Two (both forward) | Three (Analysis, Redo, Undo) |

### Formal Definition
1. Let $L$ be the set of all log records.
2. Initialize $S = \emptyset$ (Set of committed transactions).
3. **Pass 1 (Identify Winners)**: For each record $r \in L$ from start to end:
   - If $r = \langle \text{COMMIT } T \rangle$, then $S = S \cup \{T\}$.
   - If $r = \langle \text{ABORT } T \rangle$, then $S = S \setminus \{T\}$.
4. **Pass 2 (Redo, forward)**: For each record $r \in L$ from start to end:
   - If $r = \langle T, X, v \rangle$ and $T \in S$, then $\text{WRITE}(X, v)$.

### Simplified Explanation
First, read the whole log to make a list of everyone who successfully finished. Then, start from the beginning of the log again and redo every change made by the people on that list. If they didn't finish, ignore their changes because they never reached the disk anyway.

### Java Implementation

```java
public class RedoRecoveryManager {
    /**
     * Performs two-pass redo recovery.
     * @param logRecords The full log history.
     */
    public void performRedoRecovery(List<LogRecord> logRecords) {
        Set<Integer> winners = new HashSet<>();

        // Pass 1: Identify committed transactions (winners) - Forward Scan
        for (LogRecord record : logRecords) {
            if (record.getType() == LogType.COMMIT) {
                winners.add(record.getTransactionId());
            } else if (record.getType() == LogType.ABORT) {
                winners.remove(record.getTransactionId());
            }
        }

        // Pass 2: Redo (Forward Scan) - Re-apply changes for winners
        for (LogRecord record : logRecords) {
            if (record.getType() == LogType.UPDATE) {
                if (winners.contains(record.getTransactionId())) {
                    // Re-apply the "after image" (new value)
                    diskManager.write(record.getElementId(), record.getNewValue());
                }
            }
        }
        
        diskManager.flush();
    }
}
```

## Recovery Walkthrough

Consider the following log state at the time of a crash. Assume elements $A, B, C, D$ initially have values $1, 2, 3, 4$.

**Log at Crash:**
1. `<START T1>`
2. `<T1, A, 100>`
3. `<START T2>`
4. `<T1, B, 200>`
5. `<COMMIT T1>`
6. `<T2, C, 300>`
7. `<START T3>`
8. `<T3, D, 400>`
9. *--- CRASH ---*

### Step-by-Step Recovery

**Step 1: Identify Winners (Pass 1)**
The Recovery Manager scans the log forward:
- **T1**: Has both `<START T1>` and `<COMMIT T1>`. Status: **Committed**.
- **T2**: Has `<START T2>` but no completion record. Status: **Not Committed**.
- **T3**: Has `<START T3>` but no completion record. Status: **Not Committed**.
- **Result**: $S = \{T1\}$.

**Step 2: Redo (Pass 2)**
The Recovery Manager scans forward again and applies changes for committed transactions ($T \in S$):
1. `<T1, A, 100>`: **REDO** (T1 is committed). Set $A = 100$.
2. `<T1, B, 200>`: **REDO** (T1 is committed). Set $B = 200$.
3. `<T2, C, 300>`: **IGNORE** (T2 not committed).
4. `<T3, D, 400>`: **IGNORE** (T3 not committed).

**Final State**: $A=100, B=200, C=3, D=4$. Changes for $C$ and $D$ are lost because their transactions never committed. Because of the **No-Steal** policy (Rule R2), we are guaranteed that the uncommitted values for $C$ and $D$ never reached the physical disk, so no undo is required.

## Trade-offs

| Pros | Cons |
|------|------|
| **Low Commit Latency**: Only the log record needs to be flushed at commit, not the data pages. | **Memory Pressure**: Requires No-Steal, meaning dirty pages must stay in RAM until commit. |
| Efficient sequential I/O for logging. | **Long Recovery**: Must replay all committed transactions since the last checkpoint. |

## Industry Standard Mapping
- **Redo Logging** $\rightarrow$ Transaction Logs / Write-Ahead Logs (e.g., SQL Server Transaction Log, Postgres WAL).

### Rollback vs. Recovery
- **Restart Recovery**: Triggered after a crash. Requires two forward passes (Analysis to find winners, then Redo to apply their changes).
- **Rollback (Abort)**: Redo logging alone cannot perform a standard rollback of a running transaction because it lacks "before images" (old values). In a Redo-only system, "rolling back" effectively means ignoring the transaction's changes in the buffer pool and letting them be wiped on crash, or maintaining a separate undo mechanism.

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]
