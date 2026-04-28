# Multi-Paxos: Failure Detection

Failure detection in Multi-Paxos covers two related problems: detecting that the **leader has failed** (via heartbeats) and handling the **holes** a failed leader may leave behind in the log.

## Heartbeats

- The leader periodically tells followers it is still alive by sending **heartbeats**.
- Client requests serve as implicit heartbeats — an explicit heartbeat is only sent when there are no incoming client requests.
- Each follower runs a **timer**. If the timer expires without hearing from the leader, the follower assumes the leader has failed and attempts to become the new leader by running Phase 1 with a higher ballot number.

See [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] for how a new leader is elected.

---

## Related
- [[CSE452/Paxos/Multi-PaxosComponents/Multi-Paxos|Back to Multi-Paxos]]
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — How empty slots left by a failed leader are detected and filled
- [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] — How a new leader is elected after a failure
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] — The log data structure, slot pointers, and garbage collection
