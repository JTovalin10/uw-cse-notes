# Multi-Paxos: The Log

The **Log** tracks the full state of the Multi-Paxos algorithm: what commands to feed into the [[CSE452/RPC/Deterministic State Machine|state machine]], which slots have been decided, and how to avoid processing duplicate requests.

## Data Structure

```java
HashMap<Integer, LogEntry> log;
// key   = slot index
// value = all data about that slot
```

### Slot Pointers

Finding the next empty slot naively (scanning for the largest index) is inefficient. Instead, maintain three auxiliary pointers:

| Pointer | Symbol | Meaning |
| :--- | :--- | :--- |
| **slot_in** | $S_i$ | First available (empty) slot for a new proposal |
| **slot_out** | $S_o$ | First slot that has not yet been executed |
| **slot_gc** | $S_{gc}$ | First slot that has not yet been garbage collected |

**Invariant**: $S_{gc} \leq S_o \leq S_i$

- $S_i$ advances when a new request is assigned to a slot.
- $S_o$ advances when a slot is executed and fed to the state machine.
- The protocol aims toward $S_i = S_o$, which occurs when all assigned slots have been executed and there are no pending requests.

## Avoiding Duplicate Log Entries

Checking for duplicates is a **performance** optimization, not a correctness requirement — it avoids wasting consensus rounds on requests already handled.

Before proposing a request, check if it is already in the log:

| Case | Action |
| :--- | :--- |
| Request already executed | Retransmit the cached response to the client |
| Request is old and not in AMO | Client already received the response; ignore |
| Request not yet chosen | If the system is making progress, ignore — it will be proposed soon |
| Request is chosen but not yet executed | A hole exists in the log; if it is already being handled, no further action needed |

## Ejection Policy / Garbage Collection

**Main Question**: When is it safe to delete a log entry?

This is hard because network delays mean nodes can disagree on whether a slot has been executed.

**Rules**:
- A slot must be **executed** before it can be deleted.
- A slot cannot be deleted until **every node** has received and acknowledged it, so that lagging nodes can still catch up.
- Only **prefixes** of the log are deleted — slot $n$ cannot be removed while any slot $m < n$ is still present.

### Catching Up

If a node missed a chosen command (e.g., it was partitioned or temporarily down), the leader must inform it of the missing entries. The leader keeps log entries alive long enough for all nodes to catch up before deleting them. Once a node has received all missing entries and applied them to its state machine, it is safe to garbage-collect the earlier prefix.

---

## Related
- [[CSE452/Paxos/Multi-PaxosComponents/Multi-Paxos|Back to Multi-Paxos]]
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]] — Handling holes left by failed leaders
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — What the log feeds into
