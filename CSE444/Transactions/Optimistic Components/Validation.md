# CSE444: Validation

Concurrency Control by Validation (also known as **Optimistic Concurrency Control**) assumes that conflicts are rare and validates transactions only at commit time.

## Workflow in Depth

Unlike pessimistic locking (where you wait for locks *before* doing work), Validation-based CC assumes you will succeed. 

### 1. The Read Phase (Parallel Execution)
- **Work**: The transaction $T$ executes its logic fully in a private workspace.
	- *What this means*: $T$ runs its entire business logic (e.g., calculations) without requesting any locks (Shared or Exclusive). It assumes no conflicts will occur.
- **Reads**: It reads the necessary values from the main database into its own memory.
- **Writes**: Any `UPDATE` or `INSERT` is performed **only** in a **private workspace** (a local buffer). The real database on disk remains unchanged.
- **Concurrency**: Because there are no locks, many transactions can "complete their work" simultaneously at full speed.

### 2. The Validate Phase (The Critical Section)
- **Work**: Once $T$ is finished with its work, it asks the DBMS: "Did anyone else make a change while I was working that would make my work invalid?"
- **Sequentiality**: To ensure correctness, the **Validation and Write phases are typically sequential**. The DBMS processes one validation at a time (or uses a very tight lock) to assign the serialization order based on $VAL(T)$.
- **Checks**: It compares $T$'s Read Set ($RS(T)$) and Write Set ($WS(T)$) against the Write Sets of other transactions that committed recently.

### 3. The Write Phase
- **Work**: If (and only if) validation succeeds, the changes in the **private workspace** are copied into the actual database.
- **Atomicity**: This is where the transaction officially "happens" for everyone else to see.

---

## What happens if Validation fails?
If the DBMS detects a conflict (i.e., another transaction $U$ changed data that $T$ relied on), validation fails.

1. **Immediate Abort**: The transaction $T$ is killed.
2. **Discard Workspace**: The private workspace is deleted. Because no changes were ever written to the main database, there is **nothing to undo/rollback** in the physical storage—the "rollback" is just deleting local memory.
3. **Restart**: The transaction is typically restarted from the beginning with a new $START(T)$ time.

---

## Formal Validation Rules
To ensure [[CSE444/Transactions/Serializability/Serializability|serializability]], for any two transactions $T_i$ and $T_j$ such that $VAL(T_i) < VAL(T_j)$ (meaning $T_i$ is logically "older"), **one** of the following three conditions must hold:

### Rule 1
$$FIN(T_i) < START(T_j)$$
$T_i$ finishes its Write phase before $T_j$ even starts its Read phase.

### Rule 2
$$FIN(T_i) < VAL(T_j) \quad \text{and} \quad WS(T_i) \cap RS(T_j) = \emptyset$$
$T_i$ finishes its Write phase before $T_j$ starts its Validation phase, and $T_i$ did not write any data elements that $T_j$ read.

### Rule 3
$$VAL(T_i) < VAL(T_j) \quad \text{and} \quad WS(T_i) \cap (RS(T_j) \cup WS(T_j)) = \emptyset$$
$T_i$ completes its Validation phase before $T_j$ completes its own, and $T_i$ does not write to any data elements that $T_j$ either reads or writes.

---

## Simplified Logic for Validation Rules

| Rule | Simple Logic |
| :--- | :--- |
| **Rule 1** | $T_i$ finished everything before $T_j$ even started. They never overlapped, so no conflict is possible. |
| **Rule 2** | $T_i$ finished writing before $T_j$ started checking. As long as $T_i$ didn't change anything $T_j$ was looking at, $T_j$ is still valid. |
| **Rule 3** | $T_i$ and $T_j$ are finishing at nearly the same time. This is only safe if their work is completely independent (they didn't read or write the same things). |

## Conflict Avoidance

In Optimistic Concurrency Control, "Conflict Avoidance" refers to the process of **detecting and blocking** any transaction that would break [[CSE444/Transactions/Serializability/Serializability|serializability]] before its changes touch the actual disk.

- **How it works**: The DBMS uses the [[#Formal Validation Rules|Validation Rules]] to compare the data a transaction "drafted" in private against the data other transactions actually "committed" to the system. 
- **The "Avoidance" mechanism**: If a conflict is found, the transaction is **aborted**. By killing the transaction *before* it writes, the database **avoids** ever entering a state that violates serializability.

### Why Conflict Avoidance Matters

If we do not strictly avoid these conflicts, we lose the **Isolation** guarantee of ACID:

1. **Prevents "Reading the Past"**: Without avoidance, $T_j$ might commit based on a value that $T_i$ changed *after* $T_j$ read it. This would mean $T_j$ acted on "stale" information.
2. **Prevents Lost Updates**: Avoidance ensures that if $T_i$ and $T_j$ both try to update the same record, only the one that "arrives" at validation first wins. The second one is forced to restart, preventing it from accidentally overwriting $T_i$'s work without seeing it.
3. **Ensures the Serial Illusion**: The entire goal of a DBMS is to make it look like transactions happened one-by-one. Conflict avoidance is the "security guard" that prevents any interleaving that doesn't fit into a clean, serial timeline.

![[Avoid $r_t(X) - w_U(X)$ conflicts.png]]

## Related
- [[CSE444/Transactions/Optimistic Components/Timestamps|Timestamps]]
- [[CSE444/Transactions/Optimistic Components/Snapshot Isolation|Snapshot Isolation]]
- [[CSE444/Transactions/Serializability/Conflict Serializability|Conflict Serializability]]
