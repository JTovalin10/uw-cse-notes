# Transactions: Lock Modes and Lock Granularity

## Binary Locks

**Binary locks** have two states:
- **Locked**: no other transaction may proceed on this element
- **Unlocked**: no transaction holds the lock; any may acquire it

Any transaction has either full or no control of the lock.
- Leads to excessive deadlocking
- Doesn't allow differentiating between reads and writes

## Shared/Exclusive Locks

**Shared/exclusive locks** have three possible states:

| State | Also Called | Behavior |
|---|---|---|
| **Exclusive lock** | Write lock | Just like a binary lock — only one holder allowed |
| **Shared lock** | Read lock | Multiple shared locks may coexist simultaneously |
| **Unlocked** | — | Any transaction may acquire the lock |

This allows concurrent reads while still serializing writes.

## Lock Granularity

**Fine-grained locking** locks small pieces of data (e.g., individual tuples):
- High concurrency — transactions can work on different rows simultaneously
- High overhead in managing many locks
- Can be implemented with simple binary locks (spin locks, etc.)

**Coarse-grained locking** locks large pieces of data (e.g., entire tables or the entire database):
- Low concurrency — many false conflicts where transactions block on unrelated data
- Less overhead in managing locks
- Needs to escalate lock types depending on the operation

## Related
- [[Atomic Transactions in SQL]] — basic locking and atomicity
- [[Atomic and isolated Transactions in SQL]] — 2PL, which uses these lock types
- [[Phantom Reads]] — predicate locks as a form of fine-grained locking
