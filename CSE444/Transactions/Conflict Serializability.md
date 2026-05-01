# CSE444: Conflict Serializability

A schedule is **conflict serializable** if it can be transformed into a serial schedule by a series of swaps of adjacent **non-conflicting** actions.

## What is a Conflict?
Two actions conflict if they belong to **different transactions**, access the **same data item**, and **at least one of them is a write**.

- **RW Conflict**: $r_i(X), w_j(X)$
- **WR Conflict**: $w_i(X), r_j(X)$
- **WW Conflict**: $w_i(X), w_j(X)$

## Testing for Conflict-Serializability: Precedence Graphs
To determine if a schedule is conflict-serializable:
1. Create a node for each transaction $T_i$.
2. Draw an edge $T_i \to T_j$ if an action in $T_i$ conflicts with an action in $T_j$, and $T_i$'s action occurs first.
3. **Result**: The schedule is conflict-serializable **if and only if** the precedence graph is **acyclic**.

![[Acyalic Graph Conflict Serializable.png]]

## View Equivalence
A serializable schedule need not be conflict serializable, even under the "worst case update" assumption. **View equivalence** is a weaker notion of equivalence that captures more serializable schedules.

![[View Equivalence Example.png]]
![[View Equivalence.png]]

## Related
- [[Schedules and Concurrency Problems]]
- [[Locking]]
- [[Transaction Fundamentals]]
