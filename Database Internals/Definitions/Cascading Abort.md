# Database Internals: Cascading Abort

A **Cascading Abort** is a phenomenon where the failure or rollback of one transaction causes a series of other dependent transactions to also rollback. This occurs in non-recoverable or non-strict schedules where a transaction reads data written by another transaction before that writer has committed.

A **[[Database Internals/Definitions/Recoverable Schedule|Recoverable Schedule]]** prevents cascading aborts by requiring that transactions only commit after all transactions from which they have read have also committed. The strongest prevention is provided by **Strict 2PL** (see [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking]]), which prevents any transaction from reading uncommitted data in the first place by holding write locks until commit.

## Industry Standard Terms
- **Cascading Abort** $\rightarrow$ Cascading rollback / Domino effect rollback

## Related
- [[Database Internals/Definitions/Recoverable Schedule|Recoverable Schedule]]
- [[Database Internals/Transactions/Serializability/SerializabilityComponents/Schedules|Schedules]]
- [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]]
