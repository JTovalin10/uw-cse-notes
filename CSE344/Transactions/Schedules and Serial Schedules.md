# Transactions: Schedules and Serial Schedules

## Schedules

A **schedule** is a sequence of interleaved operations from all active transactions.

Notation for operations in transaction $i$:
- $\text{READ}_i(A)$: read element $A$
- $\text{WRITE}_i(A)$: update element $A$
- $\text{INSERT}_i(A)$: insert/create element $A$
- $\text{DELETE}_i(A)$: delete element $A$

## Serial Schedules

A **serial schedule** is one where all operations of one transaction are performed to completion before any other transaction starts — no interleaving.
- There are no concurrency control problems in a serial schedule
- It is the gold standard for correctness

A schedule is **serializable** if it is equivalent to some serial schedule.
- By definition, serializable schedules satisfy the **Isolated** ([[ACID Properties#I = Isolated|I]]) property of ACID

![[Serial Schedule Example.png]]

## Why Not Always Use Serial Schedules?

The concurrency control manager does not always execute serial schedules because:
- **Disk latency**: when a transaction waits for I/O, another transaction can productively proceed
- **Multicore hardware**: operations from different transactions are interleaved at the hardware level anyway

## Related
- [[ACID Properties]] — why serializability maps to isolation
- [[Isolation Transactions in SQL]] — conflict-serializability as a practical way to verify serializability
- [[Precedence Graphs]] — the tool used to check whether a schedule is conflict-serializable
