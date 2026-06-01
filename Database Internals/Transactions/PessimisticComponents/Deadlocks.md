# CSE444: Deadlocks

A **deadlock** occurs in a database when two or more transactions are stuck in a circular dependency, each waiting for a lock held by another in the group. Because none can proceed, they would wait forever unless the DBMS intervenes.

---

## 1. The Wait-For Graph
The primary tool for understanding deadlocks is the **Wait-For Graph** (a directed graph representing dependencies).

- **Nodes**: Represent active transactions ($T_1, T_2, \dots$).
- **Edges**: A directed edge $T_i \to T_j$ exists if $T_i$ is waiting for a lock held by $T_j$.
- **The Deadlock Condition**: A deadlock exists **if and only if** there is a **cycle** in the wait-for graph.

### Example Cycle
- $T_1$ holds a lock on $A$, waits for $B$ (held by $T_2$).
- $T_2$ holds a lock on $B$, waits for $A$ (held by $T_1$).
- **Graph**: $T_1 \to T_2 \to T_1$ (Cycle detected).

![[DeadLock cycle.png]]

---

## 2. Deadlock Detection
Since cycles can form at any time, the DBMS must have a strategy to find them.

### Periodic Cycle Detection
The DBMS maintains the wait-for graph and scans it for cycles.
- **Cost**: Cycle detection (e.g., Depth-First Search) is $O(N + E)$.
- **Frequency**: Checking on every lock request is too expensive. Instead, the DBMS checks **periodically** (e.g., every 500ms).

### Timeout-Based Detection
A simpler, "lazy" approach:
- If a transaction waits for a lock longer than a predefined **timeout** threshold, the DBMS assumes a deadlock has occurred.
- **Pros**: Very low overhead.
- **Cons**: Hard to pick a good timeout. Too short $\rightarrow$ unnecessary aborts. Too long $\rightarrow$ system stalls.

![[2PL Deadlocks.png]]

---

## 3. Deadlock Recovery
Once a deadlock is detected, the DBMS must break the cycle.

1.  **Select a Victim**: Choose one transaction in the cycle to abort.
    - **Criteria**: Usually the transaction with the least amount of work done, the fewest locks held, or the one that started most recently.
2.  **Rollback**: Abort the victim and release all its locks.
3.  **Notify and Retry**: The other transactions in the cycle can now proceed. The victim is notified and typically retries after a short delay.

---

## 4. Deadlock Avoidance
Instead of detecting deadlocks after they happen, some systems try to prevent them from ever occurring.

### Pre-defined Lock Ordering
- All data elements are assigned a global order.
- Transactions **must** acquire locks according to this order (e.g., always lock Table A before Table B).
- This mathematically guarantees that no circular wait can ever form.

### All-at-Once (Static Locking)
- A transaction must request **all** the locks it will ever need at the very beginning.
- If any lock is unavailable, it gets none and waits.
- This prevents the "hold and wait" condition required for deadlocks.

---

## Related
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Locking]]
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|The Locking Scheduler]]
- [[Operating Systems/Concurrency/Problems/Deadlocks|Deadlocks (CSE451)]]
