# CSE444: ARIES Recovery Algorithm

**Algorithms for Recovery and Isolation Exploiting Semantics (ARIES)** is the industry-standard recovery algorithm. It is a **Steal / No-Force** algorithm that uses an **Undo-Redo Log** to provide high performance and robust crash recovery.

## Core Mechanisms and Data Structures

To track the state of the system, ARIES maintains several key structures:

### Log Sequence Number (LSN)
Every log record is assigned a unique, monotonically increasing **LSN**.
- **pageLSN**: Every data page on disk/RAM stores the LSN of the *latest* update that modified it.
- **FlushedLSN**: The LSN of the latest log record successfully written to stable storage.
- **WAL Requirement**: To flush a page to disk, the DBMS must ensure `pageLSN <= FlushedLSN`.

### System Tables (In-Memory)
- **Active Transaction Table (ATT)**: Tracks all active transactions. Stores `transID` and `lastLSN` (the LSN of the most recent log record for that transaction).
- **Dirty Page Table (DPT)**: Tracks all pages in the buffer pool that have been modified but not yet flushed to disk. Stores `pageID` and `recLSN` (the LSN of the *first* log record that made the page dirty).

![[ARIES Data Structures.png]]

## Normal Operations

During normal operation, ARIES maintains its data structures by following strict rules for every state transition.

### T Writes Page P
1. Write log record `<T, P, old_v, new_v>` to the log (no need to flush to disk yet).
2. Set `pageLSN(P) = LSN` of the new log record.
3. Set `prevLSN` of the log record to `lastLSN(T)`, linking it backward through T's log chain.
4. Update `lastLSN(T) = LSN` in the Transaction Table.
5. If `recLSN(P)` is null in the Dirty Page Table, set `recLSN(P) = LSN` (first time this page became dirty).

### Buffer Manager Outputs Page P
When the buffer manager evicts and flushes page `P` to disk:
1. Flush the log up to `pageLSN(P)` — WAL requires the log to precede the data page.
2. Remove `P` from the Dirty Page Table.

### Buffer Manager Inputs Page P
When the buffer manager reads page `P` from disk into the buffer pool:
1. Create an entry in the Dirty Page Table with `recLSN = null`.

### T Starts
1. Write `<START T>` to the log.
2. Create a new entry for `T` in the Transaction Table with `lastLSN = null`.

### T Commits
1. Write `<COMMIT T>` to the log.
2. Flush the log up to this record — forcing the commit record to stable storage is the actual **commit point** (durability is guaranteed once this returns).
3. Write `<END T>` and remove `T` from the Transaction Table.

### T Aborts
1. Write `<ABORT T>` to the log.
2. **Roll back** `T`: scan `T`'s log chain backward (via `prevLSN`) and undo each update, writing a **Compensating Log Record (CLR)** for every undone action — the same Undo machinery used during crash recovery (see the [[#Phase 3: Undo Phase|Undo Phase]] and [[#Compensating Log Records (CLR)|CLR]] sections below).
3. Once all of `T`'s updates are undone, write `<END T>` and remove `T` from the Transaction Table.

## Checkpoints

ARIES takes **Fuzzy Checkpoints** to periodically record system state without stalling ongoing transactions. A checkpoint writes two structures to the log:
1. The entire **Transaction Table** (all active transactions and their `lastLSN`).
2. The entire **Dirty Page Table** (all dirty pages and their `recLSN`).

A background process periodically flushes dirty pages to disk. Recovery always starts by loading the most recent checkpoint, which bounds how far back in the log the Analysis Phase must read.

## The Three Phases of ARIES Recovery

When the database restarts after a crash, ARIES performs recovery in three distinct phases: **Analysis**, **Redo**, and **Undo**.

### Phase 1: Analysis
The goal of the Analysis phase is to reconstruct the state of the system at the time of the crash and identify the starting points for the subsequent phases.

1.  **Start Point**: Begin scanning forward from the most recent **Checkpoint** entry.
2.  **Reconstruct Tables**: Rebuild the **Active Transaction Table (ATT)** and **Dirty Page Table (DPT)** by replaying log records:
    - If `<START T>`: Add $T$ to ATT.
    - If `<COMMIT T>` or `<ABORT T>`: Change $T$'s status in ATT.
    - If `<UPDATE P>`: If page $P$ is not in DPT, add it with `recLSN = LSN`.
    - If `<END T>`: Remove $T$ from ATT.
3.  **Identify Winners and Losers**: At the end of the scan, any transaction still in the ATT whose status is **not Committed** (i.e., it was still Running and never wrote a `<COMMIT T>` record) is a **Loser**. A transaction that wrote `<COMMIT T>` but crashed before its `<END T>` record will also still be in the ATT — but it is a **Winner**; it only needs its `<END T>` written, not an undo. Losers are defined by commit status, not by the absence of an `END` record.
4.  **Compute Redo Start**: The Redo Phase will start at the `min(recLSN)` in the reconstructed DPT.

### Phase 2: Redo Phase (Repeating History)
ARIES follows the "Repeating History" principle, restoring the database to the exact state it was in at the crash, including updates from transactions that will eventually be undone.

1.  **Direction**: Forward scan from `min(recLSN)`.
2.  **Logic**: For every update record `<T, P, u, v>` at `LSN`:
    - **Should we redo?**: Redo the action *unless* any of the following are true:
        - Page $P$ is not in the DPT.
        - `recLSN` for $P$ in DPT is greater than `LSN`.
        - The `pageLSN` on the physical disk page is $\ge$ `LSN` (requires reading the page from disk).
3.  **Action**: If none of the above are true, re-apply the update and set `pageLSN(P) = LSN`.
4.  **Idempotency**: Redo is **idempotent**. If the system crashes during this phase, restarting recovery will result in the same state.

### Phase 3: Undo Phase
The system reverts the changes made by transactions that were active (Losers) at the time of the crash.

1.  **Direction**: Backward scan from the end of the log.
2.  **ToUndo Set**: Initialize a set of LSNs to undo, containing the `lastLSN` for every transaction in the Loser set.
3.  **Process Log**: Repeatedly pick the largest LSN from the `ToUndo` set:
    - If it is a regular update record:
        - Perform the undo action (write `old_v` to disk).
        - Write a **Compensating Log Record (CLR)** to the log.
        - The CLR's `undoNextLSN` is set to the `prevLSN` of the record just undone.
        - Add `undoNextLSN` to the `ToUndo` set.
    - If it is a CLR:
        - Do not undo the CLR itself.
        - Add the CLR's `undoNextLSN` to the `ToUndo` set.
    - If the LSN is null (reached the start of a transaction):
        - Write an `<END T>` record.

### Formal Definition
1. **Analysis**: $S_{loser} = \text{ATT}$ after forward scan from checkpoint.
2. **Redo**: $\forall \langle T, P, u, v \rangle \text{ at } L$: If $P \in \text{DPT} \land L \ge \text{recLSN}(P) \land \text{pageLSN}(P) < L$, then $\text{WRITE}(P, v)$.
3. **Undo**: $\forall \text{ Loser } T$: Scan $T$'s log chain backward; $\forall \text{ update } u$: $\text{UNDO}(u)$ and $\text{WRITE\_CLR}(\text{undoNextLSN} = u.\text{prevLSN})$.

### Simplified Explanation
First, read the log from the last checkpoint to see who was doing what when we crashed. Second, start from the oldest "dirty" page and redo *everything* in the log to get the disk back to the exact state it was in at the crash. Third, walk backwards through the losers' changes and undo them, writing "Undo-of-Undo" notes (CLRs) so we never have to undo the same thing twice if we crash again.

![[ARIES Method Illustration.png]]

## Compensating Log Records (CLR)
CLRs are the secret to ARIES's robust recovery. A CLR is a special log record written *during* the Undo phase to record the fact that an undo was performed.

- **Non-Undone**: CLRs are never themselves undone (they have no "before image").
- **Redo-Only**: If the system crashes during recovery, the Redo phase will replay the CLRs just like regular updates, ensuring the undo work is preserved.
- **LSN Chaining**: By using the `undoNextLSN` pointer, CLRs allow the system to "jump over" updates that have already been undone, preventing infinite undo loops.

![[CLR Part 1.png]]
![[CLR Part 2.png]]

### Issues
- We could unplay history the same way we replay history. However, we cannot do this selectively for one transaction that wants to roll back.
- Reason 1:
	- TXN T1 updates one record on page X
	- TXN T2 updates another record on the same page X
	- TXN T2 commits
	- TXN T1 wants to ROLLBACK, but we cannot isolate only T1's changes on page X
- Reason 2: indexes — for similar reasons, undoing a single transaction's index changes in isolation is not straightforward
- Explanation: these constraints limit our abstract model and require the CLR mechanism described above

## Idempotence
An operation is **Idempotent** if $f(f(x)) = f(x)$. In the context of recovery, this means that if you run the recovery process once, twice, or ten times (due to repeated crashes), the final state of the database is the same. This is achieved through physical/physiological logging and CLRs.

## UNDO/REDO Logging
ARIES is built on **[[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]**, which allows it to support Steal/No-Force policies.

## Related
- [[CSE444/Transactions/Recovery/Recovery and Logging|Recovery and Logging (Fundamentals)]]
- [[Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
