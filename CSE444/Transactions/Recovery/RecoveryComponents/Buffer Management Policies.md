# CSE444: Buffer Management Policies

The interaction between the volatile buffer pool (RAM) and the non-volatile disk is defined by two policy dimensions: **Steal** and **Force**. These choices determine what the [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]] protocol must guarantee and what [[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|log type]] the recovery manager is required to maintain.

## Policy Dimensions

| Policy       | Formal Definition                                                                                      | Mechanism & Impact                                                                                                                        |
| ------------ | ------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **Steal**    | Allows the buffer manager to flush dirty pages of an uncommitted transaction to disk to reclaim space. | **Why**: Improves memory efficiency. **Cost**: Requires an **Undo Log** to remove uncommitted changes if the transaction later aborts.    |
| **No-Steal** | Dirty pages of uncommitted transactions cannot be written to disk until commit.                        | **Why**: Simplifies recovery (no undo needed). **Cost**: Limits the size of a single transaction to available RAM.                        |
| **Force**    | Requires all pages modified by a transaction to be flushed to disk *before* the transaction commits.  | **Why**: Guarantees durability at commit time without needing a redo log. **Cost**: Massive random I/O overhead at commit time.           |
| **No-Force** | Pages are not required to be flushed at commit; they may remain in the buffer pool.                   | **Why**: High performance; disk writes happen asynchronously. **Cost**: Requires a **Redo Log** to replay changes if a crash occurs.      |

## Policies and Log Requirements

Which log type is needed depends entirely on the buffer management strategy chosen:

| Policy Combination      | Required Logging  | Mechanism / Requirement                                                                                                              |
| ----------------------- | ----------------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| **Force / No-Steal**    | None (Strictly)   | No undo (uncommitted pages never reach disk) and no redo (all committed pages are forced to disk at commit). Simplest, but slowest. |
| **Force / Steal**       | **Undo Log**      | Needed because uncommitted changes can steal disk space before the transaction commits.                                               |
| **No-Force / No-Steal** | **Redo Log**      | Needed because committed changes may not have been forced to disk before a crash.                                                     |
| **No-Force / Steal**    | **Undo-Redo Log** | The industry standard. Handles both uncommitted disk writes and lost committed updates after a crash.                                 |

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/Logging Types|Logging Types]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
