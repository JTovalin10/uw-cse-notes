# CSE444: View Serializability

**View Serializability** is a weaker (more permissive) notion of serializability than [[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]. It allows for some schedules that are serializable but cannot be reached via simple non-conflicting swaps, such as those involving "blind writes."

## View Equivalence
Two schedules $S$ and $S'$ are **view equivalent** if they satisfy the following three conditions for all data elements $X$:

1.  **Initial Read**: If transaction $T_i$ reads the initial value of $X$ in $S$, then $T_i$ must also read the initial value of $X$ in $S'$.
2.  **Write-Read (Dependent Read)**: If $T_i$ reads a value of $X$ written by $T_j$ in $S$, then $T_i$ must also read the value of $X$ written by $T_j$ in $S'$.
3.  **Final Write**: If $T_i$ performs the final write of $X$ in $S$, then $T_i$ must also perform the final write of $X$ in $S'$.

A schedule is **view serializable** if it is view equivalent to some serial schedule.

## Relationship to Conflict Serializability
- Every **conflict-serializable** schedule is also **view-serializable**.
- Not every view-serializable schedule is conflict-serializable.
- The difference usually arises from **blind writes** (writing a value without reading it first — a transaction writes a data element without first reading it).

### Example: Thomas' Write Rule
Thomas' Write Rule (used in [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]]) creates schedules that are view-serializable but not conflict-serializable by intentionally ignoring "outdated" writes.

## Complexity
Unlike conflict serializability, which can be checked in polynomial time using a precedence graph ($O(n^2)$), testing for view serializability is **NP-complete**.

## The Serializability Hierarchy
$$Conflict\ Serializable \subset View\ Serializable \subset Serializable$$

## Related
- [[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]
- [[CSE444/Transactions/Concurrency Anomalies|Schedules and Concurrency Problems]]
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]]
