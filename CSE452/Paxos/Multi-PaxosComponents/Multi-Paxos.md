# Multi-Paxos

**Multi-Paxos** builds on [[CSE452/Paxos/Single Paxos|Single Decree Paxos]] to reach consensus on an entire sequence of log slots, rather than just a single value.

## What is a Log?

In a distributed system, a **Log** is an ordered sequence of commands — think of it as a list of "to-do" items for a database or state machine.

- **The Goal**: Every server in the cluster maintains an identical copy of the log (a "global log").
- **Consistency**: If Server A executes `[Set X=1, Set Y=2]` but Server B executes `[Set Y=2, Set X=1]`, they may end up with different data. The log ensures every node performs the exact same operations in the exact same order.
- **Slots (Indices)**: Each position in the log is called a **Slot**. Conceptually, there are infinitely many slots.
    - The order of decisions is not the order of execution — a value can be inserted into slot 3 while slots 1 and 2 are still empty, but slot 3 cannot be *executed* until slots 1 and 2 complete.
        - Slot 1: `PUT "Apple" = 5`
        - Slot 2: `PUT "Banana" = 10`
        - Slot 3: `DELETE "Apple"`
- **Replicated State Machine (RSM)**: The actual application (e.g., a key-value store or SQL database) reads commands from the log one-by-one and executes them. Because Paxos ensures every server's log is identical, every server's state stays perfectly in sync.

See [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] for detailed data structures, slot pointers, duplicate detection, and garbage collection.

## Basic Idea (Unoptimized)

- Run [[CSE452/Paxos/Single Paxos]] independently in each slot.
- A client broadcasts its request to all servers.
- Each server finds an empty slot and proposes the request.
- Once a prefix of the log is chosen, the server executes the request and responds to the client.
- **Problem**: Running a full two-phase protocol per slot produces multiple unnecessary rounds of communication.

## Roles in Multi-Paxos

In most practical implementations, every server acts as a **Proposer**, **Acceptor**, and **Learner** simultaneously.
- One server is designated the **Distinguished Proposer** (the Leader).
- Clients send requests to the Leader.
- The Leader assigns the request to the next available slot and drives Phase 2.

## Key Differences from Single Paxos

| Property | Single Paxos | Multi-Paxos |
| :--- | :--- | :--- |
| **Roles** | Separate Proposer, Acceptor, Learner | All nodes play all roles |
| **Ballot IDs** | Simple number | Pair `(seqnum, server_id)`, compared lexicographically |
| **Instances** | One decision | One Paxos instance per log slot |
| **Phase 1** | Run for every decision | Only the leader runs it; elided in steady state |
| **Log Gaps** | N/A | Holes must be filled before later slots can execute |

---

## Components
- [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Leader Election]] — The Distinguished Proposer optimization: combining Phase 1 across all slots, steady-state Phase 2, and failure handling.
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] — The log data structure, slot pointers ($S_i$, $S_o$, $S_{gc}$), duplicate detection, and garbage collection.
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]] — Heartbeats and detecting leader failure.
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — Empty slots left by failed leaders and how they are filled.

---

## Related
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Paxos Invariants|Ballot IDs and Invariants]]
