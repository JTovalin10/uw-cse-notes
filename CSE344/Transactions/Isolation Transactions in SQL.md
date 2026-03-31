# Transactions: Serializability and Conflict-Serializability

If we can find a serializable schedule, we can execute transactions concurrently while still maintaining the appearance of isolation.
- See [[Schedules and Serial Schedules]] for the definition of serial schedules and serializability
- By definition, serializable schedules are isolated:
	- Serializable = equivalent to serial
	- Serial = isolated

## Identifying Serializable Schedules

How does the scheduler know that an arbitrary schedule $S$ doesn't create bad interleaving?
- Show that it can modify $S$ — without changing its output — until it becomes serial
- Showing a program is serializable is hard in general

## Conflicts

See [[Interleaving and Concurrency Control#Conflicts]] for the full list of conflict types (WR, RW, WW).

A **conflict** between two operations occurs when changing their order might result in a different DBMS state.
- Conflicts aren't inherently bad — it just means we can't swap the two operations without also considering the database's state

**Notation change:** conflict detection ignores what a transaction specifically does to values — it only considers the *types* of operations (read vs. write).

## Conflict-Free Reordering

- If two operations do **not** have a conflict on the same data, they can always be reordered into a schedule that produces the same output
- If two operations **do** have a conflict on the same data, they *might* be reordered into a schedule that produces the same output — but this is not guaranteed

## Conflict-Serializability and Serializability

**Serializable** schedules require knowing:
- The current state of the database instance
- The specific values used in the specific operations

**Conflict-serializable** schedules can be reordered into a serial schedule by repeatedly swapping non-conflicting operations.
- Conflict-serializability **implies** serializability
- But serializability does **not** imply conflict-serializability

![[Conflict-serializability and serializability.png]]

## Verifying Conflict-Serializability

See [[Precedence Graphs]] for the full algorithm.

A schedule is conflict-serializable if and only if its [[Precedence Graphs|precedence graph]] is **acyclic**.

## Related
- [[Schedules and Serial Schedules]] — definitions of schedules and serializability
- [[Precedence Graphs]] — cycle detection algorithm for verifying conflict-serializability
- [[Atomic and isolated Transactions in SQL]] — 2PL as a practical mechanism for generating conflict-serializable schedules
- [[Isolation Levels]] — weaker notions of isolation and the trade-offs
