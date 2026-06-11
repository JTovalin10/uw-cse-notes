# Database Internals: The Pessimistic Scheduler

The **scheduler** is the module in a DBMS that orders transaction actions to ensure [[Database Internals/Transactions/Serializability/Serializability|serializability]].

A **Pessimistic Scheduler** takes a cautious approach — it assumes conflicts *will* happen. Therefore, it forces transactions to ask for permission (acquire a lock) before reading or writing any element. If a lock is held by another transaction, the requesting transaction must wait in a queue.

#### Notation
- $L_i(A)$ = transaction $T_i$ acquires lock for element $A$
- $U_i(A)$ = transaction $T_i$ releases lock for element $A$

![[Pessimistic Scheduler creates conflict-serializable.png]]

---

## Architecture of the Scheduler
The locking scheduler operates by dividing its responsibilities into two main roles: the **Transaction Agent** and the **System Agent**. This separation of concerns is crucial for performance and correctness.

### Role 1: The Transaction Agent (The "Proxy")
Acts on behalf of the transaction by transparently managing lock/unlock requests. The application developer does not write `LOCK(A)` — the agent does it for them.
- **Interception**: It intercepts all `READ(A)` or `WRITE(A)` actions from the transaction.
- **Request Generation**: It automatically adds the appropriate lock requests (e.g., requesting a Shared lock before a read).
- **Rule Enforcement**: It ensures the transaction follows protocols like **[[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Strict 2PL]]** by holding all locks until the end of the transaction.
- **Cleanup**: On **COMMIT** or **ROLLBACK**, it issues the commands to release all locks held by the transaction.

### Role 2: The System Agent (The "Bouncer")
Acts on behalf of the DBMS to execute the lock requests and manage the global state.
- **The Lock Table**: It manages the lock table, which is a major, highly-optimized critical structure in memory.
- **Handling Requests**: When a lock is requested:
	- It checks the lock table against the compatibility matrix.
	- It **grants** the lock if compatible.
	- Otherwise, it adds the transaction to the element's **wait queue** (blocking it).
- **Handling Releases**: When a lock is released:
	- It looks at the wait queue and **reactivates** the next compatible transaction in line.
- **Safety**: It periodically scans the wait queues for cycles to perform **[[Database Internals/Transactions/PessimisticComponents/Deadlocks|Deadlock Detection]]**.

```mermaid
sequenceDiagram
    participant T as Transaction Agent
    participant SA as System Agent
    participant LT as Lock Table
    T->>SA: Request Lock(A)
    SA->>LT: Check compatibility
    alt Lock compatible
        LT-->>SA: Grant
        SA-->>T: Lock granted
    else Lock not compatible
        LT-->>SA: Conflict found
        SA-->>T: Add to wait queue (block)
    end
    T->>SA: Release Lock(A)
    SA->>LT: Remove lock entry
    SA-->>T: Wake next compatible waiter
```

## Lab 3 Notes
- Transactions (not threads) must hold locks — many threads can execute different pieces of the same transaction.
- Must detect deadlocks (cycles in the waits-for graph) and resolve them by aborting a transaction.
- Lock pages, not rows (for this specific lab implementation).

## Industry Standard Terms
- **Pessimistic Concurrency Control** $\rightarrow$ Locking-based Concurrency Control
- **Transaction Agent** $\rightarrow$ Lock Manager client / Transaction proxy
- **System Agent / Lock Table** $\rightarrow$ Lock Manager / Lock table (universal term)
- **Wait Queue** $\rightarrow$ Lock queue / Waiter queue

## Related
- [[Database Internals/Transactions/PessimisticComponents/Two-Phase Locking (2PL)|Two-Phase Locking (2PL)]]
- [[Database Internals/Transactions/PessimisticComponents/Lock Modes|Lock Modes]]
- [[Database Internals/Transactions/Serializability/SerializabilityComponents/Conflict Serializability|Conflict Serializability]]
