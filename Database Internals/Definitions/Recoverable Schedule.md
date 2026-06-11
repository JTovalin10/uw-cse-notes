# Database Internals: Recoverable Schedule

A **Recoverable Schedule** is a schedule where, for every pair of transactions $T_i$ and $T_j$ such that $T_j$ reads a data item previously written by $T_i$, the commit operation of $T_i$ appears before the commit operation of $T_j$. In other words, a transaction may not commit until all transactions from which it has read have also committed.

This property prevents **[[Database Internals/Definitions/Cascading Abort|Cascading Aborts]]**: if $T_i$ aborts, $T_j$ (which read $T_i$'s data) can also be safely aborted because $T_j$ has not yet committed. See [[Database Internals/Transactions/Serializability/SerializabilityComponents/Schedules|Schedules]] for the full hierarchy of schedule properties.

## Industry Standard Terms
- **Recoverable Schedule** $\rightarrow$ Safe schedule / Commit-order-safe schedule

## Related
- [[Database Internals/Definitions/Cascading Abort|Cascading Abort]]
- [[Database Internals/Transactions/Serializability/SerializabilityComponents/Schedules|Schedules]]
- [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]]
