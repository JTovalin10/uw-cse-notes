# CSE444: Recovery and Logging

Database **Recovery** is the process of ensuring the database remains consistent despite crashes, power failures, or transaction aborts. It is the primary enforcement mechanism for **Atomicity** and **Durability** from the [[CSE444/Transactions/Transaction Fundamentals|ACID properties]].

## Core Building Blocks

The recovery system rests on three foundational pillars:

1. **[[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]** — The log always precedes the data page on stable storage. Two rules apply: (1) all log records for a page must be flushed before the page itself is written to disk, and (2) the commit record must be flushed before the transaction is declared committed.

2. **[[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]** — The **Steal/No-Steal** and **Force/No-Force** dimensions define what the log must support:

| Policy Combination | Logging Required |
|-------------------|-----------------|
| No-Steal / Force | No logging needed (simple but impractical) |
| Steal / Force | Undo logging only |
| No-Steal / No-Force | Redo logging only |
| **Steal / No-Force** | **Undo-Redo logging** (industry standard) |

3. **[[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|Logging Types]]** — The specific log record format and abstraction level:
   - [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo Logging|Undo Logging]]
   - [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Redo Logging|Redo Logging]]
   - [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Undo-Redo Logging|Undo-Redo Logging]]
   - [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Checkpointing|Checkpointing]]
   - [[CSE444/Transactions/Recovery/RecoveryComponents/LoggingComponents/Log Abstraction Levels|Log Abstraction Levels]]

## Recovery Algorithm

The industry-standard algorithm is **[[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES]]** (Algorithms for Recovery and Isolation Exploiting Semantics), a Steal/No-Force protocol operating in three phases:

| Phase | Direction | Purpose |
|-------|-----------|---------|
| **Analysis** | Forward from last checkpoint | Reconstruct the Transaction Table and Dirty Page Table; compute `firstLSN` |
| **Redo** | Forward from `firstLSN` | Replay history — restore the exact state at the moment of crash |
| **Undo** | Backward from end of log | Roll back all loser transactions using Compensation Log Records (CLRs) |

## System Failure Context

When a crash occurs, the contents of volatile RAM are lost. The DBMS uses the log to recover:
- **Undo** uncommitted changes that reached disk (because Steal was in effect).
- **Redo** committed changes that were lost from RAM (because No-Force was in effect).

The recovery process is **idempotent** — if the system crashes again mid-recovery, re-running the three phases from the latest checkpoint produces the same correct final state.

## Related
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
