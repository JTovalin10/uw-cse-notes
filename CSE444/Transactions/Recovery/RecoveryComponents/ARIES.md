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
- **Transaction Table**: Tracks all active transactions. Stores `transID`, `status` (Running/Committed/Aborted), and `lastLSN` (the LSN of the most recent log record for that transaction).
- **Dirty Page Table (DPT)**: Tracks all pages in the buffer pool that have been modified but not yet flushed to disk. Stores `pageID` and `recLSN` (the LSN of the *first* log record that made the page dirty).

## The Three Phases of ARIES Recovery

When the database restarts after a crash, it performs recovery in three distinct steps:

### 1. Analysis Phase
The goal is to determine the state of the database at the exact moment of the crash.
- **Action**: Scans the log forward from the most recent **Checkpoint**.
- **Result**: Reconstructs the Dirty Page Table and the Transaction Table. Identifies "loser" transactions that were active during the crash.

### 2. Redo Phase (Repeating History)
The goal is to restore the database to the exact state it was in at the time of the crash—even redoing the work of transactions that eventually aborted.
- **Action**: Scans the log forward from the oldest `recLSN` in the DPT.
- **Optimization**: For each record, skip redo if the `pageLSN` on the actual disk is already greater than or equal to the log record's LSN (meaning the change already made it to disk).

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
