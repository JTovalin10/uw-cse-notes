# Course: Buffer Management Policies

The interaction between the volatile buffer pool (RAM) and the non-volatile disk is defined by two policy dimensions: **Steal** and **Force**. These choices determine the requirements for the recovery manager.

## Policy Dimensions

| Policy | Formal Definition | Mechanism & Impact |
|--------|-------------------|--------------------|
| **Steal** | Allows the buffer manager to flush dirty pages of an uncommitted transaction to disk to reclaim space. | **Why**: Improves memory efficiency. **Cost**: Requires an **Undo Log** to remove these uncommitted changes if the transaction later aborts. |
| **No-Steal** | Dirty pages of uncommitted transactions cannot be written to disk until commit. | **Why**: Simplifies recovery (no undo needed). **Cost**: Limits the size of a single transaction to the available RAM. |
| **Force** | Requires all pages modified by a transaction to be flushed to disk *before* the transaction commits. | **Why**: Simplifies durability (no redo needed). **Cost**: Massive random I/O overhead at commit time. |
| **No-Force** | Pages are not required to be flushed at commit; they can stay in the buffer pool. | **Why**: High performance; disk writes happen asynchronously. **Cost**: Requires a **Redo Log** to replay changes if a crash occurs. |

## Policies and Logs Mapping

This table defines which log types are necessary based on the buffer management strategy:

| Policy Combination | Required Logging | Mechanism / Requirement |
|--------------------|------------------|-------------------------|
| **Force / No-Steal** | None (Strictly) | No undo (no uncommitted on disk) and no redo (all committed on disk). |
| **Force / Steal** | **Undo Log** | Needed because uncommitted changes can "steal" disk space. |
| **No-Force / No-Steal**| **Redo Log** | Needed because committed changes may not have been "forced" to disk. |
| **No-Force / Steal** | **Undo-Redo Log**| The industry standard; handles both uncommitted disk writes and lost committed updates. |

## Related
- [[CSE444/Transactions/Recovery/RecoveryComponents/Write-Ahead Logging (WAL)|Write-Ahead Logging (WAL)]]
- [[CSE444/Transactions/Recovery/RecoveryComponents/ARIES|ARIES Recovery Algorithm]]
- [[CSE444/Transactions/Recovery/Recovery|Recovery Overview]]
