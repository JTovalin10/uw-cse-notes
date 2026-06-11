# Database Internals: Lock Modes

Database systems use different "modes" of locks to balance the need for consistency with the goal of high concurrency.

---

### 1. Shared Lock (S)
- **Purpose**: Used for **Read** operations.
- **Rule**: Multiple transactions can hold a Shared lock on the same data element $X$ at the same time.
- **Logic**: If $T_1$ is reading $X$, there is no reason $T_2$ cannot also read $X$ safely.
- **Notation**: $S_i(A)$ means transaction $T_i$ holds a shared lock on $A$.

### 2. Exclusive Lock (X)
- **Purpose**: Used for **Write** operations (`INSERT`, `UPDATE`, `DELETE`).
- **Rule**: Only **one** transaction can hold an Exclusive lock on element $X$ at any time. No other transaction can hold *any* lock (S or X) on $X$ while the X lock is held.
- **Logic**: If $T_1$ is changing $X$, no one else should be reading or writing it, as they would see inconsistent or "in-flight" data.
- **Notation**: $X_i(A)$ means transaction $T_i$ holds an exclusive lock on $A$.

### Lock Compatibility Matrix
The following matrix determines if a lock request can be granted based on the lock currently held by another transaction:

| Lock Held \ Request | Shared (S) | Exclusive (X) |
| :--- | :---: | :---: |
| **Shared (S)** | **Yes** | No |
| **Exclusive (X)** | No | No |

---

## Lock Upgrades (S $\rightarrow$ X)

A **Lock Upgrade** occurs when a transaction that already holds a Shared lock on element $X$ needs to modify that same element.

### The Process
1. $T_1$ starts by reading $X$, so it acquires a **Shared (S)** lock.
2. Later, $T_1$ decides to update $X$ (e.g., `UPDATE accounts SET balance = balance + 10`).
3. $T_1$ requests to **upgrade** its $S$ lock to an **Exclusive (X)** lock.
4. **The Condition**: The DBMS will grant the upgrade **only if** no other transaction currently holds a Shared lock on $X$.

### Common Pitfall: The Upgrade Deadlock
Lock upgrades are a frequent cause of deadlocks.
- **Scenario**:
    1. $T_1$ holds $S(X)$.
    2. $T_2$ holds $S(X)$ (Allowed, since S is compatible with S).
    3. $T_1$ requests to upgrade to $X(X)$. It must wait for $T_2$ to release its $S(X)$.
    4. $T_2$ requests to upgrade to $X(X)$. It must wait for $T_1$ to release its $S(X)$.
- **Result**: Both transactions are stuck waiting for each other to release their shared locks — a classic [[Database Internals/Transactions/PessimisticComponents/Deadlocks|deadlock]].

---

## Lock Granularity

**Lock Granularity** refers to the "size" of the data element that a single lock protects. The DBMS must make a trade-off between concurrency and overhead.

### 1. Fine Granularity Locking
Locks are applied to very small data elements, such as individual **tuples (rows)** or even specific fields.
- **High Concurrency**: Because the locks are so small, it is very rare for two transactions to want the exact same lock. Many transactions can operate on the same table simultaneously, as long as they touch different rows.
- **High Overhead**: If a transaction needs to update 10,000 rows, it must ask the [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Locking Scheduler]] for 10,000 individual locks. This takes significant CPU time, memory (to store the lock records in the lock table), and causes network/bus traffic.

### 2. Coarse Granularity Locking
Locks are applied to large data elements, such as entire **tables**, disk pages/blocks, or even whole databases.
- **Low Overhead**: If a transaction updates 10,000 rows in a table, it only needs to acquire **one** lock (on the table itself). This is very fast and uses almost no memory.
- **High "False Conflicts"**: If $T_1$ locks the entire `Users` table to update Alice's record, and $T_2$ wants to update Bob's record in the same table, $T_2$ is blocked. This is a **false conflict** — they are not actually touching the same data, but the coarse lock forces them to wait anyway, drastically reducing concurrency.

---

## Lock Performance and Thrashing

![[Lock Performance.png]]

As the number of active transactions in a system increases, throughput (transactions completed per second) initially goes up. However, it eventually hits a peak and then **drops drastically**. This collapse in performance is called **Thrashing**.

### Why does performance go down?
Thrashing in a lock-based DBMS happens because transactions spend more time waiting for locks than actually doing work.
1. **The Wait Queue Effect**: As more transactions enter the system, the probability that someone holds a lock you need increases.
2. **Cascading Blocking**: $T_1$ holds a lock. $T_2$ waits for $T_1$. $T_3$ comes in and waits for $T_2$, and so on. Long chains of blocked transactions form.
3. **Deadlocks**: More waiting transactions $\to$ more complex wait-for graphs $\to$ higher chance of [[Database Internals/Transactions/PessimisticComponents/Deadlocks|Deadlocks]]. The DBMS must waste CPU cycles finding and killing transactions, which then restart and add even more load to the system.

### Causes of Thrashing
- **Too Coarse Granularity**: Causes massive false conflicts, creating artificial bottlenecks where transactions wait for no logical reason.
- **Too Fine Granularity**: Causes the DBMS to run out of memory for the Lock Table, or spend all its CPU time just allocating and deallocating tiny locks instead of writing data.

## Industry Standard Terms
- **Shared Lock (S)** $\rightarrow$ Read lock / S-lock (universal terminology)
- **Exclusive Lock (X)** $\rightarrow$ Write lock / X-lock (universal terminology)
- **Lock Upgrade** $\rightarrow$ Lock escalation (though "escalation" more often refers to granularity upgrade from row to table)
- **Thrashing** $\rightarrow$ Lock contention / Lock saturation
- **False Conflict** $\rightarrow$ False sharing / Spurious conflict

## Related
- [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]]
- [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Pessimistic Scheduler]]
- [[Database Internals/Transactions/Phantom Problem|Phantom Problem]]
