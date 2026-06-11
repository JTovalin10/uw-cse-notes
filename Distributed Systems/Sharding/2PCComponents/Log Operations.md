# Distributed Systems: 2PC Log Operations

Every participant and coordinator in a [[Transactions|Two-Phase Commit (2PC)]] transaction maintains a **persistent log** of every operation it takes. This log is the durability guarantee: if a node crashes and restarts, it can replay the log to determine what state it was in and whether to commit or abort. The log is written via the local [[Multi-Paxos|Paxos]] consensus layer before any action is taken, ensuring that the entry is durable across the replica group before execution.

There are six lab-defined log entry types, plus two additional entries used in the lecture's presentation (`Write` and `Unlock`). The lecture also separates the write lock and tentative-write into two distinct log entries, where the lab combines them into `LOCK(WRITE, var, value)`. Both represent the same protocol; the lecture notation makes the distinction between locking and staging a value more explicit.

There are six possible log entries (lab terminology):

---

## BEGIN

```
BEGIN
```

Logged when a group first learns it is involved in a transaction — either because it received the client request (coordinator) or because it received a `Prepare` message from the coordinator (participant). The `BEGIN` entry records the start of this group's participation.

**Preconditions**: The group must have the correct keys for its role, be on the right configuration number, and not be in the middle of a conflicting transaction. If these conditions are not met, the transaction is rejected before `BEGIN` is ever logged.

---

## LOCK(READ, var)

```
LOCK(READ, var)
```

Logged when a participant acquires a **read lock** on variable `var`. A read lock signals intent to read `var` as part of the transaction without modifying it.

**Lock compatibility rule**: At any point in time, a variable can hold either:
- Multiple read locks simultaneously (shared access for concurrent readers), OR
- Exactly one write lock (exclusive access).

A read lock can be acquired only if no write lock is currently held on `var`. If a write lock is already held, the participant cannot acquire the read lock and must abort.

---

## LOCK(WRITE, var, value)

```
LOCK(WRITE, var, value)
```

Logged when a participant acquires a **write lock** on variable `var` and stages the new `value`. This is a **tentative write** — `value` is recorded in the log and held in temporary state, but is not yet committed to persistent memory. The lock prevents any other transaction from acquiring any lock (read or write) on `var` until this transaction resolves.

**Why tentative?** The write must not be made permanent until the coordinator decides to commit. If the coordinator decides to abort, the tentative write is discarded and the original value is preserved. Logging the value here ensures the write can be applied atomically on `COMMIT` or cleanly rolled back on `ABORT`.

---

## PREPARE-COMMIT

```
PREPARE-COMMIT
```

Logged by a participant after it has successfully acquired all necessary locks and staged all tentative writes. This entry is the participant's **binding promise** to the coordinator: "I have everything I need; if you tell me to commit, I will." The participant replies `PrepareOK` to the coordinator only after this entry is durably written to the log.

The `PREPARE-COMMIT` entry creates the core safety property of 2PC: once logged, the participant cannot unilaterally abort or release its locks. It is in a blocked state, waiting for the coordinator's final decision.

### Formal Definition

A participant $p$ may log `PREPARE-COMMIT` for transaction $T$ if and only if:
$$\forall v \in \text{keys}(T, p): \text{lock}(v) \text{ is held by } T$$

### Simplified Explanation

Every key this participant is responsible for is locked. The participant is committed in spirit — it just needs the coordinator's final word.

---

## COMMIT

```
COMMIT
```

Logged by a participant (or coordinator acting as participant) upon receiving a `Commit` message from the coordinator, after having previously logged `PREPARE-COMMIT`. The `COMMIT` entry triggers two actions:

1. **Persist the writes**: All tentative writes from `LOCK(WRITE, ...)` entries are written to persistent memory (the durable KVStore state).
2. **Release locks**: All read and write locks held for this transaction are released, allowing other transactions to proceed.

After `COMMIT` is logged and applied, the participant sends `CommitOK` back to the coordinator.

---

## ABORT

```
ABORT
```

Logged in two distinct situations:

**Case 1 — Participant cannot prepare**: A participant cannot acquire a necessary lock (because it is held by another transaction). The participant logs `ABORT` immediately and replies `PrepareNotOK` to the coordinator, without ever logging `PREPARE-COMMIT`. Any tentative writes staged before the failed lock acquisition are rolled back.

**Case 2 — Coordinator receives a PrepareNotOK or timeout**: The coordinator, upon receiving `PrepareNotOK` from any participant (or timing out waiting for a response), logs `ABORT` in its own log and sends `Abort` messages to all participants that already replied `PrepareOK`. Those participants then log `ABORT`, undo their tentative writes, and release their locks.

In both cases, `ABORT` guarantees that **no data is modified**. Temporary writes are undone and the system returns to its pre-transaction state.

---

## Write(key, value)

```
Write(key, value)
```

In the lecture's presentation, `Lock(W, key)` and the tentative write are two **separate** log entries. The `Write(key, value)` entry records the staged value after the write lock has been acquired. It serves the same purpose as the `value` field inside the lab's `LOCK(WRITE, var, value)` entry: the value is held tentatively and not committed to persistent memory until `COMMIT` is logged.

This separation makes the distinction between the locking step and the value-staging step explicit.

---

## Unlock(key)

```
Unlock(key)
```

Logged after `COMMIT` or `ABORT`, when a participant releases its lock on `key`. This entry is the explicit log record of the lock being surrendered. In the lab implementation, lock release happens as part of processing the `COMMIT` or `ABORT` entry; the lecture shows it as its own entry to make the Two-Phase Locking (2PL) structure explicit — all locks are held through the end of Phase 2, then released together.

---

## Log Sequence Summary

**Lab terminology** (complete commit path):

| Role | Log Sequence |
| :--- | :--- |
| Coordinator | `BEGIN → LOCK(R,...) → LOCK(W,...) → PREPARE-COMMIT → COMMIT` |
| Participant | `BEGIN → LOCK(R,...) → LOCK(W,...) → PREPARE-COMMIT → COMMIT` |

**Lecture terminology** (complete commit path, separating lock and write, with unlock):

| Role | Log Sequence |
| :--- | :--- |
| Coordinator | `Transaction start(coord) → Lock(R,key) → Lock(W,key) → Write(key,val) → Coordinator prepared → Commit → Unlock(key)` |
| Participant | `Transaction start(part) → Lock(R,key) → Lock(W,key) → Write(key,val) → Prepared → Committed → Unlock(key)` |

**Abort paths** (lab terminology):

| Scenario | Participant Log | Coordinator Log |
| :--- | :--- | :--- |
| Lock unavailable | `BEGIN → ABORT` | `BEGIN → LOCK(...) → PREPARE-COMMIT → ABORT` |
| Coordinator timeout | `BEGIN` (stuck) | `BEGIN → LOCK(...) → PREPARE-COMMIT → ABORT` |

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **LOCK(READ, var)** | Shared lock / S-lock |
| **LOCK(WRITE, var, value)** | Exclusive lock / X-lock / write lock |
| **PREPARE-COMMIT** | Vote-commit (in the XA protocol) |
| **COMMIT** | Phase 2 commit / decision record |
| **ABORT** | Vote-abort / rollback record |
| **Tentative write** | Undo log entry / write-ahead log entry |

---

## Related

- [[Transactions|Transactions (2PC)]] — hub file linking all 2PC components
- [[MultiPut Walkthrough|MultiPut Walkthrough]] — see these log entries in action in a concrete example
- [[Failure Scenarios|Failure Scenarios]] — what the log looks like when things go wrong
- [[Phases and Roles|Phases and Roles]] — how the 2PC phases use these log entries
- [[Locking and Deadlock|Locking and Deadlock]] — the locking mechanics behind LOCK(READ) and LOCK(WRITE)
