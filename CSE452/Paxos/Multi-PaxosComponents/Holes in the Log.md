# CSE452: Multi-Paxos Holes in the Log

A **hole** is an empty slot in the log. Holes occur when a leader starts filling a slot but fails before completing Phase 2, and a new leader is elected before that slot reaches consensus. Because execution is sequential, a hole in slot $n$ blocks all slots after it from executing.

## Filling Holes on New Leader Election

When a new leader is elected, it must find and fill all holes before making further progress:

1. During Phase 1, the new leader collects 1b summaries from a majority, which reveal the voting history across all slots.
2. For any slot that appears empty (a hole), the leader proposes a **no-op** (or a safe read-only request like a `GET`) in that slot.
3. The leader runs Phase 2 normally for the no-op, filling the hole without altering the state machine's output.

This ensures the log has a contiguous decided prefix before the new leader begins accepting client requests.

---

## Related
- [[CSE452/Paxos/Multi-Paxos|Back to Multi-Paxos]]
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]] — How the leader failure is detected in the first place
- [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] — The Phase 1 process where holes are discovered
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] — The log data structure and slot pointers
