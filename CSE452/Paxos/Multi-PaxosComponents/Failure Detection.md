# CSE452: Multi-Paxos Failure Detection

Failure detection in Multi-Paxos covers two related problems: detecting that the **leader has failed** (via heartbeats) and handling the **holes** a failed leader may leave behind in the log.

## Heartbeats

- The leader periodically tells followers it is still alive by sending **heartbeats**.
- Each follower runs a **timer**. If the timer expires without hearing from the leader, the follower assumes the leader has failed and attempts to become the new leader by running Phase 1 with a higher ballot number.

### Implicit vs. Explicit Heartbeats
In Multi-Paxos, heartbeats are often integrated into the standard message flow to save bandwidth:

1.  **Implicit Heartbeats (P2a Messages)**:
    - As long as the leader is processing client requests, its **P2a messages** serve as heartbeats.
    - When a follower receives a valid P2a from the leader, it resets its election timer.
2.  **Explicit Heartbeats (Idle Mode)**:
    - If there are no incoming client requests, the leader sends dedicated, empty heartbeat messages just to keep the followers from timing out.
    - These are sent periodically based on a `heartbeat_timeout` (which must be significantly shorter than the followers' `election_timeout`).

### The Role of `leaderCommit`
Regardless of whether a heartbeat is implicit (P2a) or explicit (empty), it **always** includes the current **`leaderCommit` index**.
- This tells followers which slots have been officially "Chosen" by a majority.
- This allows followers to keep their state machines in sync and execute commands even during idle periods or when they've missed earlier messages.

See [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] for how a new leader is elected.

---

## Related
- [[CSE452/Paxos/Multi-Paxos|Back to Multi-Paxos]]
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — How empty slots left by a failed leader are detected and filled
- [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] — How a new leader is elected after a failure
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] — The log data structure, slot pointers, and garbage collection
