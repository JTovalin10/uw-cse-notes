# Conflict Serializability

A schedule is **conflict serializable** if it can be transformed into a serial schedule by a series of swaps of adjacent **non-conflicting** actions.

## What is a Conflict?
Two actions conflict if they belong to different transactions, access the same data item, and at least one of them is a **write**.

- **RW Conflict**: $r_i(X), w_j(X)$
- **WR Conflict**: $w_i(X), r_j(X)$
- **WW Conflict**: $w_i(X), w_j(X)$

*Note: Actions by the same transaction $r_i(X), w_i(Y)$ always conflict in terms of ordering.*

## Testing for Conflict-Serializability: Precedence Graphs
To determine if a schedule is conflict-serializable:
1.  Create a node for each transaction $T_i$.
2.  Draw an edge $T_i \to T_j$ if an action in $T_i$ conflicts with an action in $T_j$, and $T_i$'s action occurs first.
3.  **Result**: The schedule is conflict-serializable **if and only if** the precedence graph is **acyclic** (has no cycles).

![[Acyalic Graph Conflict Serializable.png]]

---

## Concurrency Control in Practice (Lab 3)

DBMSs use **Lock Managers** to ensure conflict serializable execution.

- **Strict 2-Phase Locking (Strict 2PL)**:
    - Transactions must obtain a lock before reading/writing.
    - All locks held by a transaction are released only **after** the transaction commits or aborts.
- **Lock Manager Implementation**:
    - Transactions (not just threads) must hold locks.
    - Must detect **deadlocks** (cycles in the "waits-for" graph) and resolve them by aborting a transaction.
    - Internal data structures for locks should be protected using synchronization (e.g., Java `synchronized`).
