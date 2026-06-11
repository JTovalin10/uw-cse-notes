# Distributed Systems: Holes in the Log

A **hole** is an empty slot in the log. Because Multi-Paxos execution is sequential, a hole at slot $n$ blocks the [[Deterministic State Machine|state machine]] from executing any commands in slots $n+1, n+2, \dots$, even if those later slots have already been decided.

## Conceptual Deep Dive: Who has holes?

### Leaders vs. Followers
In a stable system, the **Leader** will never have holes in its log. This is because the leader inserts client commands sequentially as it receives them (using `slot_in`). It is the primary source of the sequence.

**Followers**, however, can and do have holes. For example, if P2a messages for slots 4 and 5 are dropped by the network but the P2a for slot 6 arrives, the follower will have a gap. This is not a fatal issue for followers:
- They know the holes will eventually be filled when the missing P2a messages finally make it through (or via **Heartbeat** catch-up mechanisms).
- They simply wait for the prefix to become contiguous before continuing execution.

### Why a Leader cannot have holes
It would be a critical problem if an active leader had a hole in its log. Unlike a follower, a leader has no "higher authority" sending it P2a or heartbeat messages to patch the gap. If the leader doesn't have the data, the system cannot progress.

---

## Patching the Log during Leader Election

When a node runs for leader and receives a majority of **P1b** messages, it transitions to being the leader. At this moment, it is guaranteed to know all previously **chosen** slots (due to the majority overlap). However, the candidate leader may find holes in its log created from merging the P1bs it received.

### Why holes appear during recovery
Holes occur during election because the candidate (and the majority it heard from) may have missed the P2a messages for certain slots that the *previous* leader had proposed but failed to get chosen by that specific majority.

> **Philippe's Note**: We patch the log immediately after a candidate leader has received a majority of P1bs and is transitioning to the leader state.

### The No-Op Solution
If the candidate leader identifies a hole in its merged log, it knows for certain that **nothing was chosen** for that slot. If a slot had been chosen, at least one server in the P1b majority would have reported it. 

To "patch" the log, the leader:
1. Proposes a **No-Op** command for the empty slot.
2. Runs **Phase 2** (P2a/P2b) for that No-Op just like a normal client command.
3. Once the No-Op is chosen, the log is contiguous, and the leader can safely propose new client requests.

We use **No-Ops** because they satisfy the requirement of filling the slot (allowing the state machine to progress) without performing extra operations the clients didn't ask for.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Hole** | Log gap / missing log entry |
| **No-Op** | No-op entry / filler command |
| **Patching the Log** | Log reconciliation / gap filling |
| **Log Merging** | Log recovery / catch-up |

---

## Related
- [[Multi-Paxos|Multi-Paxos Overview]]
- [[Leader Election|Leader Election]] — The Phase 1 process where holes are discovered
- [[Log|The Log]] — Data structures and slot pointers ($S_i, S_o$)
- [[Failure Detection|Failure Detection]] — Detecting the leader failure that leads to holes
