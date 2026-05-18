# Course: ARIES Recovery Algorithm

**Algorithms for Recovery and Isolation Exploiting Semantics (ARIES)** is the industry-standard recovery algorithm. It is a **Steal / No-Force** algorithm that uses an **Undo-Redo Log** to provide high performance and robust crash recovery.

## Core Mechanisms and Data Structures

To track the state of the system, ARIES maintains several key structures:

### Log Sequence Number (LSN)
Every log record is assigned a unique, monotonically increasing **LSN**.
- **pageLSN**: Every data page on disk/RAM stores the LSN of the *latest* update that modified it.
- **FlushedLSN**: The LSN of the latest log record successfully written to stable storage.
- **WAL Requirement**: To flush a page to disk, the DBMS must ensure `pageLSN <= FlushedLSN`.

### System Tables (In-Memory)
- **Transaction Table (ATT)**: Tracks all active transactions. Stores `transID`, `status` (Running/Committed/Aborted), and `lastLSN` (the LSN of the most recent log record for that transaction).
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

### T Commits or Aborts
1. Write `<COMMIT T>` or `<ABORT T>` to the log.
2. Flush the log up to this record (force the commit or abort record to stable storage).
3. Write `<END T>` and remove `T` from the Transaction Table.

## Checkpoints

ARIES takes **Fuzzy Checkpoints** to periodically record system state without stalling ongoing transactions. A checkpoint writes two structures to the log:
1. The entire **Transaction Table** (all active transactions and their `lastLSN`).
2. The entire **Dirty Page Table** (all dirty pages and their `recLSN`).

A background process periodically flushes dirty pages to disk. Recovery always starts by loading the most recent checkpoint, which bounds how far back in the log the Analysis Phase must read.

## The Three Phases of ARIES Recovery

When the database restarts after a crash, it performs recovery in three distinct steps.

![[ARIES Method Illustration.png]]

### 1. Analysis Phase
**Goal**:
- Determine the point in the log where the Redo Phase should begin.
- Reconstruct a conservative estimate of which pages were dirty at the time of the crash.
- Identify all active (uncommitted) transactions at the time of the crash.

**Approach**:
1. Start from the most recent **Checkpoint** entry in the log.
2. Scan forward through all subsequent log records, rebuilding the Transaction Table and Dirty Page Table by replaying every `START`, `UPDATE`, `COMMIT`, `ABORT`, and `END` entry.
3. After scanning, compute `firstLSN = min(recLSN)` across all entries in the Dirty Page Table. This is the starting point for the Redo Phase.

![[ARIES Analysis Phase.png]]

### 2. Redo Phase (Repeating History)
**Main Principle**: Replay history — restore the database to the exact state it was in at the moment of the crash, including the in-progress work of transactions that will ultimately be rolled back.
- Process the log **forward**, starting from `firstLSN`.
- Re-apply every update record sequentially. Redo actions are **not** themselves recorded in the log.
- Uses the Dirty Page Table as an optimization: skip redo for a page if its on-disk `pageLSN` is already greater than or equal to the log record's LSN (the change already made it to disk before the crash).

### 3. Undo Phase
The goal is to roll back the changes of all "loser" transactions identified in the Analysis phase.
- **Action**: Scans the log backward from the end.
- **Compensation Log Records (CLR)**: For every undo action, ARIES writes a CLR to the log.
- **Why CLRs?**: They ensure **Idempotence**. If the system crashes *during* recovery, the CLRs tell the next recovery attempt that these undos have already been performed, preventing the system from re-undoing an undo.

## Idempotence
An operation is **Idempotent** if $f(f(x)) = f(x)$. In the context of recovery, this means that if you run the recovery process once, twice, or ten times (due to repeated crashes), the final state of the database is the same. This is achieved through physical/physiological logging and CLRs.

## Related
- [[CSE444/Transactions/Recovery/Recovery|Recovery and Logging (Fundamentals)]]
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Recovery/Recovery#The Write-Ahead Logging (WAL) Rule|WAL Rules]]
