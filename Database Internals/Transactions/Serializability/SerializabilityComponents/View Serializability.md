# Database Internals: View Serializability

**View Serializability** is a weaker (more permissive) notion of serializability than [[Database Internals/Transactions/Serializability/SerializabilityComponents/Conflict Serializability|Conflict Serializability]]. It allows for some schedules that are serializable but cannot be reached via simple non-conflicting swaps, such as those involving **blind writes** (writing a value without first reading it).

## View Equivalence
Two schedules $S$ and $S'$ are **view equivalent** if they satisfy the following three conditions for all data elements $X$:

1. **Initial Read**: If transaction $T_i$ reads the initial value of $X$ in $S$, then $T_i$ must also read the initial value of $X$ in $S'$.
2. **Write-Read (Dependent Read)**: If $T_i$ reads a value of $X$ written by $T_j$ in $S$, then $T_i$ must also read the value of $X$ written by $T_j$ in $S'$.
3. **Final Write**: If $T_i$ performs the final write of $X$ in $S$, then $T_i$ must also perform the final write of $X$ in $S'$.

A schedule is **view serializable** if it is view equivalent to some serial schedule.

## Relationship to Conflict Serializability
- Every **conflict-serializable** schedule is also **view-serializable**.
- Not every view-serializable schedule is conflict-serializable.
- The difference usually arises from **blind writes** — a transaction writes a data element without first reading it, so the "read source" constraints in the view-equivalence definition are vacuously satisfied.

### Example: Thomas' Write Rule
Thomas' Write Rule (used in [[Database Internals/Transactions/OptimisticComponents/Timestamps|Timestamps]]) creates schedules that are view-serializable but not conflict-serializable by intentionally ignoring "outdated" writes. When a write from an older transaction is already superseded by a committed write from a newer transaction, the older write is silently dropped — producing a schedule that satisfies view equivalence but cannot be obtained by swapping non-conflicting actions.

## Complexity
Unlike conflict serializability, which can be checked in polynomial time using a precedence graph ($O(n^2)$), testing for view serializability is **NP-complete**.

## The Serializability Hierarchy
$$Conflict\ Serializable \subset View\ Serializable \subset Serializable$$

---

## Formal Analysis

### Formal Definition
Schedule $S$ is **view serializable** if there exists a serial schedule $S'$ such that for all transactions $T_i, T_j, T_k$ and all data items $X$:
1. If $T_i$ reads the initial value of $X$ in $S$, then $T_i$ reads the initial value of $X$ in $S'$.
2. If $T_i$ reads a value written by $T_j$ in $S$, then $T_i$ reads the value written by $T_j$ in $S'$.
3. If $T_k$ performs the final write of $X$ in $S$, then $T_k$ performs the final write of $X$ in $S'$.

### Simplified Explanation
Two schedules are view equivalent if every transaction reads data from exactly the same "source" transaction and the last writer of each item is the same. As long as these "who-reads-from-whom" and "who-writes-last" relationships match, the schedules are considered equivalent — even if the actions are in a different order.

---

## Industry Standard Terms
- **View Serializability** $\rightarrow$ Theoretical serializability; rarely directly enforced in production
- **Blind Write** $\rightarrow$ Overwrite without prior read
- **NP-Complete Testing** $\rightarrow$ Reason why view serializability is impractical to enforce directly

## Related
- [[Database Internals/Transactions/Serializability/SerializabilityComponents/Conflict Serializability|Conflict Serializability]]
- [[Database Internals/Transactions/Concurrency Anomalies|Schedules and Concurrency Problems]]
- [[Database Internals/Transactions/OptimisticComponents/Timestamps|Timestamps]]
