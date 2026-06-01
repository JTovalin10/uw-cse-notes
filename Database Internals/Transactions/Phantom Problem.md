# CSE444: The Phantom Problem

If tuples are inserted or deleted during a transaction, the **Phantom Problem** appears.

![[Phantom Problem.png]]

A **phantom** is a tuple that is invisible during part of a transaction execution but not invisible during the entire execution.

**Example**:
1. $T_1$ reads a list of products.
2. $T_2$ inserts a new product.
3. $T_1$ re-reads the list: a new "phantom" product appears.

## Dealing with Phantoms
- **Table Locks**: Lock the entire table (coarse-grained).
- **Index Locking**: Lock the index entry (e.g., for 'blue') if an index is **available**.
- **Predicate Locks**: A lock on an arbitrary predicate (very expensive).

Dealing with phantoms is generally expensive and requires locking more than just existing individual tuples.

## Related
- [[CSE444/Transactions/Pessimistic Components/Pessimistic Scheduler|Locking]]
- [[CSE444/Transactions/Pessimistic Components/Lock Modes|Lock Modes]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
