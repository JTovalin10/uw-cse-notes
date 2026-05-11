# Course: Recovery and Logging

Database **Recovery** is the process of ensuring that the database remains in a consistent state despite system crashes, power failures, or transaction aborts. It is the primary mechanism for enforcing **Atomicity** and **Durability** from the [[CSE444/Transactions/Transaction Fundamentals|ACID properties]].

## Core Components

The recovery system is built on three fundamental pillars:

1. **[[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]**: The protocol that ensures the log always precedes the data on disk.
2. **[[CSE444/Transactions/Recovery/RecoveryComponents/Buffer Management Policies|Buffer Management Policies]]**: The **Steal** and **Force** dimensions that define logging requirements.
3. **[[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|Logging Types]]**: The abstraction level (Physical, Logical, Physiological) and direction (Undo/Redo) of the log records.

## Recovery Algorithms

For a deep dive into the industry-standard implementation, see:
- **[[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]**: A 3-phase algorithm (Analysis, Redo, Undo) supporting Steal/No-Force.

## System Failure Context

Every transaction has an internal state in RAM. When a crash occurs:
- Volatile state is lost.
- The DBMS must use the log to **Undo** uncommitted changes that reached disk and **Redo** committed changes that were lost from RAM.

## Related
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Concurrency Anomalies|Concurrency Anomalies]]

Source: UW CSE444 Lecture Notes
