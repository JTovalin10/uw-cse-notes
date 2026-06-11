# Database Internals: Validation (Optimistic Concurrency Control)

Concurrency Control by Validation (also known as **Optimistic Concurrency Control** or **OCC**) assumes that conflicts are rare and validates transactions only at commit time.

## Workflow in Depth

Unlike [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Pessimistic Locking]] (where you wait for locks *before* doing work), Validation-based CC assumes you will succeed.

### Timestamps in Validation
Every transaction $T$ is tracked using three critical timestamps:
1. **$START(T)$**: When $T$ starts its Read Phase.
2. **$VAL(T)$**: When $T$ starts its Validation Phase. This determines the **serialization order**.
3. **$FIN(T)$**: When $T$ finishes its Write Phase.

> **Me**: Does a read-only transaction need a validation timestamp?
> **Answer**: Yes. Even if a transaction does not write anything ($WS(T) = \emptyset$), it must be validated against the Write Sets of transactions that committed *after* $T$ started. This ensures $T$ saw a consistent, serializable snapshot of the data.

### The Three Phases

#### 1. The Read Phase (Parallel Execution)
- **Work**: The transaction $T$ executes its logic fully in a private workspace (local buffer).
- **Reads**: It reads values from the database. The set of elements read is the **Read Set** ($RS(T)$).
- **Writes**: Any updates are performed **only** in the private workspace. The real database remains unchanged.
- **Concurrency**: Because there are no locks, many transactions can run simultaneously at full speed.

#### 2. The Validate Phase (The Critical Section)
- **Work**: Once $T$ is finished, it requests validation. The scheduler checks if any other transaction committed changes that conflict with $T$'s work.
- **Sequentiality**: Validation is typically a **critical section**. The DBMS processes one validation at a time to assign a unique $VAL(T)$ timestamp.
- **Check**: The scheduler compares $RS(T)$ and $WS(T)$ against the Write Sets of other transactions ($WS(U)$) based on the [[#Formal Validation Rules|Validation Rules]].

#### 3. The Write Phase
- **Work**: If validation succeeds, the changes in the private workspace are copied into the actual database.
- **Finish**: $FIN(T)$ is recorded, and the transaction is officially committed.

---

## Formal Validation Rules
To ensure [[Database Internals/Transactions/Serializability/Serializability|serializability]], for any two transactions $T_i$ and $T_j$ where $VAL(T_i) < VAL(T_j)$ ($T_i$ is logically older), **one** of the following must hold:

### Rule 1: No Overlap
$$FIN(T_i) < START(T_j)$$
$T_i$ finished everything before $T_j$ even started. No conflict possible.

### Rule 2: No Read Conflict
$$FIN(T_i) < VAL(T_j) \quad \text{and} \quad WS(T_i) \cap RS(T_j) = \emptyset$$
$T_i$ finished writing before $T_j$ started checking. Safe as long as $T_i$ did not change anything $T_j$ read.

### Rule 3: No Read or Write Conflict
$$VAL(T_i) < VAL(T_j) \quad \text{and} \quad WS(T_i) \cap (RS(T_j) \cup WS(T_j)) = \emptyset$$
They are finishing at the same time. Safe only if their work is completely independent (no shared reads or writes).

---

## Walkthrough Example

Consider two transactions:
- **$T_1$**: Reads $A$, Writes $A$.
- **$T_2$**: Reads $A$, Writes $B$.

| Time | Event | $T_1$ State | $T_2$ State | Result |
| :--- | :--- | :--- | :--- | :--- |
| 1 | $START(T_1)$ | Read Phase | - | $T_1$ reads $A=10$. |
| 2 | $START(T_2)$ | Read Phase | Read Phase | $T_2$ reads $A=10$. |
| 3 | $T_2$ calculates $B=A+5$ | Read Phase | Read Phase | $WS(T_2)=\{B\}$. |
| 4 | $VAL(T_1)$ | **Validate** | Read Phase | $T_1$ validates. No one committed yet. **Success**. |
| 5 | $T_1$ Writes $A=20$ | Write Phase | Read Phase | $T_1$ updates DB. |
| 6 | $FIN(T_1)$ | **Committed** | Read Phase | $T_1$ is done. |
| 7 | $VAL(T_2)$ | - | **Validate** | Check $T_2$ against $T_1$ (since $VAL(T_1) < VAL(T_2)$). |

**Validation Check for $T_2$ at Time 7:**
- **Rule 1?** No. $FIN(T_1) (6) \not< START(T_2) (2)$.
- **Rule 2?** No. $FIN(T_1) (6) < VAL(T_2) (7)$ is true, BUT $WS(T_1) \cap RS(T_2) = \{A\} \cap \{A\} = \{A\}$. The intersection is NOT empty.
- **Rule 3?** No. $VAL(T_1) < VAL(T_2)$ is true, but again, the sets overlap.
- **Outcome**: $T_2$ **Rolls back**. It read a value of $A$ (10) that $T_1$ has since changed (to 20).

---

## Conflict Avoidance Summary
OCC avoids conflicts by detecting them *before* they are written to the database.
- **Pros**: High performance when conflicts are rare; no deadlocks.
- **Cons**: High overhead of rollbacks if conflicts are frequent; "starvation" of long transactions.

![[Avoid $r_t(X) - w_U(X)$ conflicts.png]]

## Industry Standard Terms
- **Optimistic Concurrency Control (OCC)** $\rightarrow$ Universal term; used in distributed systems, databases, and version control
- **Read Set / Write Set** $\rightarrow$ RS/WS (standard OCC notation)
- **Validation Phase** $\rightarrow$ Commit validation / Conflict check
- **$VAL(T)$** $\rightarrow$ Serialization timestamp / Commit timestamp

## Related
- [[Database Internals/Transactions/OptimisticComponents/Timestamps|Timestamps]]
- [[Database Internals/Transactions/OptimisticComponents/Snapshot Isolation|Snapshot Isolation]]
- [[Database Internals/Transactions/Serializability/Serializability|Serializability]]
- [[Database Internals/Transactions/PessimisticComponents/Pessimistic Scheduler|Pessimistic Scheduler]]
