# CSE444: Serializability

**Serializability** is the criterion for correctness in a concurrent database system. A schedule is considered correct if its effect on the database is the same as some serial execution of the same transactions.

## What it means to be Serializable
A schedule is **serializable** if it is equivalent to some **serial schedule** (a schedule where transactions execute one after another without interleaving).

- **Correctness**: Since serial schedules are assumed to be correct (transactions are independent units), any schedule equivalent to a serial one is also correct.
- **Goal**: Allow the DBMS to interleave actions for better performance (disk I/O, CPU utilization) while maintaining the illusion of serial execution.

## Types of Serializability
Serializability is usually defined by different levels of "equivalence":

1.  **[[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]**: Equivalent to a serial schedule by swapping non-conflicting adjacent actions. This is the most common type used in practice (e.g., [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|2PL]]).
2.  **[[CSE444/Transactions/Serializability/View Serializability|View Serializability]]**: Equivalent to a serial schedule by maintaining the same "view" of data (who reads what and who writes last). A weaker condition that allows for **blind writes**.

## Hierarchy of Correctness
$$Conflict\ Serializable \subset View\ Serializable \subset Serializable$$

## Related
- [[CSE444/Transactions/Concurrency Anomalies|Schedules and Concurrency Problems]]
- [[CSE444/Transactions/Transaction Fundamentals|Transaction Fundamentals]]
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Locking]]
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]]
