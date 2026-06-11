# Distributed Systems: Multi-Paxos Log Management

The **Log** is the central data structure of a Multi-Paxos node. While the core protocol (see [[Multi-Paxos|Multi-Paxos Hub]]) defines how entries are decided, this file covers the mechanics of managing those entries locally.

## Slot Pointers

Efficient log management requires tracking the "window" of active slots using three pointers:

| Pointer | Symbol | Meaning |
| :--- | :--- | :--- |
| **slot_in** | $S_i$ | The index of the first available (empty) slot for a new proposal. |
| **slot_out** | $S_o$ | The index of the first slot that has not yet been executed by the State Machine. |
| **slot_gc** | $S_{gc}$ | The index of the first slot that has not yet been garbage-collected (truncated). |

**Fundamental Invariant**: $S_{gc} \leq S_o \leq S_i$

- **Advancing $S_i$**: The leader increments this when a new client request arrives.
- **Advancing $S_o$**: A node increments this after successfully applying a **CHOSEN** command to its local State Machine.
- **Advancing $S_{gc}$**: Incremented after a successful garbage collection cycle.

---

## Avoiding Duplicate Proposals

Checking for duplicates is a performance optimization that prevents wasting consensus rounds on requests already handled.

| Case | Action |
| :--- | :--- |
| Request already executed | Retransmit the cached response from the AMO state. |
| Request not yet chosen | If it's already in the log ($S_o \dots S_i$), ignore the new request—it will be decided soon. |
| Request is chosen but not executed | A hole exists; wait for the gap to fill. |

---

## Log Merging (Recovery Phase)

When a node receives a majority of `P1b` messages, it must merge their summaries into its own log to ensure safety.

### Merging Rules
For each slot reported in an incoming `P1b` summary:
1.  **Highest Ballot Wins**: For each slot, identify the command associated with the highest ballot number across all received summaries.
2.  **Majority Check**: If a specific command was reported by a majority as already **CHOSEN**, mark it as chosen locally.
3.  **Hole Detection**: If no command is found for a slot index $s < S_i$, mark it as a hole to be filled by a **No-Op**.

**Warning**: Do not merge directly into your active log. Use a temporary data structure or a "candidate log" until the majority is reached and the leader transition is finalized.

---

## Garbage Collection and Truncation

The log cannot grow forever. To reclaim space, nodes must eventually delete executed slots.

### When is it safe to delete?
A slot $s$ can be deleted (**truncated**) only if:
1.  The command in slot $s$ has been **executed** by the local state machine ($s < S_o$).
2.  **Every node** in the cluster has received and acknowledged the command.

### Snapshots
If a node is so far behind that its missing slots have already been garbage-collected by the leader, the leader cannot send `P2a` messages for those slots.
- **The Solution**: The leader sends an **InstallSnapshot** RPC containing the full serialized state of the State Machine.
- **Outcome**: The follower installs the snapshot, jumps its $S_o$ and $S_{gc}$ forward, and begins processing new log entries from that point.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Slot Pointers ($S_i, S_o, S_{gc}$)** | Log index pointers / next-index, apply-index |
| **Garbage Collection / Truncation** | Log compaction |
| **InstallSnapshot** | Snapshot transfer |
| **Log Merging** | Log reconciliation during recovery |

---

## Related
- [[Multi-Paxos|Multi-Paxos Hub]] — Core log entry structures and status definitions.
- [[Holes in the Log|Holes in the Log]] — Detailed logic for patching gaps with No-Ops.
- [[Leader Election|Leader Election]] — steady-state slot assignment and deduplication.
- [[Deterministic State Machine|State Machine]] — The target for log execution.
