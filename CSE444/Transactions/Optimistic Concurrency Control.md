# CSE444: Optimistic Concurrency Control

Optimistic Concurrency Control (OCC) assumes that conflicts between transactions are rare. Instead of locking, it validates transactions at commit time.

## Pessimistic vs. Optimistic
- **Pessimistic CC (Locking)**:
	- Prevent unserializable schedules before they happen.
	- Never abort for serializability reasons (but may abort for deadlocks).
	- Best for workloads with **high levels of contention**.
- **Optimistic CC (Timestamp, Multi-version, Validation)**:
	- Assume schedules will be serializable.
	- Abort when conflicts are detected at commit time.
	- Best for workloads with **low levels of contention**.

## Concurrency Control by Timestamp
Each transaction receives a **unique timestamp** $TS(T)$ when it begins.
- **System Clock**: Can be used, but tricky in distributed systems.
- **Unique Counter**: Incremented by the scheduler.

![[CSE444/screenshots/Timestamp Multiple Transactions example.png]]

### Main Invariant
The **timestamp order** defines the **serialization order** of the transaction. The scheduler generates a schedule that is **view-equivalent** to a serial schedule and **recoverable**.

### Mechanisms
With each data element $X$, associate timestamps:
- **RT(X)**: The highest timestamp of any transaction that has **read** $X$.
- **WT(X)**: The highest timestamp of any transaction that has **written** $X$.
- **C(X)**: The **commit bit**; true if the transaction with the highest timestamp that wrote $X$ has committed.

If a transaction aborts, the timestamps must be reset to their previous values.

## Related
- [[Locking]]
- [[Isolation Levels]]
- [[Conflict Serializability]]
