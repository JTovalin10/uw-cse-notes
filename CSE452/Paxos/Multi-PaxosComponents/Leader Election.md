# CSE452: Multi-Paxos Leader Election

The naive Multi-Paxos approach — running two full phases (Prepare and Accept) for every single log slot — is slow. The **Distinguished Proposer** optimization addresses this by electing a stable **Leader** that can skip Phase 1 for all subsequent slots.

## Messages

Because each node acts in all roles, every node broadcasts each message and also "sends it to itself."

| Message | Contents |
| :--- | :--- |
| **1a** | $1a(s = \text{slot}, \; r = (\text{seqnum}, \text{address}))$ |
| **1b** | $1b(s = \text{slot}, \; r = (\text{seqnum}, \text{address}), \; \text{old vote})$ |
| **2a** | $2a(s = \text{slot}, \; r = (\text{seqnum}, \text{address}), \; \text{request})$ |
| **2b** | $2b(s = \text{slot}, \; r = (\text{seqnum}, \text{server address}))$ — value omitted; the proposer already knows what won |

## Phase 1 — Becoming Leader

A candidate proposer runs Phase 1 for **all future slots at once** using a single ballot number, rather than per-slot.

- Remove per-slot data from 1a/1b messages to combine Phase 1 across all slots:
    - $1a(r = (\text{seqnum}, \text{address}))$ — implicitly covers all slots
    - $1b(r = (\text{seqnum}, \text{address}), \; \text{summary} = \{\text{slot}: (\text{roundnum}, \text{vote})\})$ — a finite summary of all prior votes across every slot
- Once the candidate receives a majority of 1b responses, it is the **Leader**.
- **Benefit**: A single round trip covers all future slots, saving the per-slot Phase 1 cost.
- Round numbers are tied to election cycles — a new election always uses a strictly higher round number.

## Phase 2 — Steady State

Once an acceptor has promised allegiance to the leader, the leader can **skip Phase 1** for subsequent slots and go directly to Phase 2.

- 2a messages retain per-slot round numbers (same format as in Single Paxos).
- The leader assigns incoming client requests to slots and sends 2a, collecting 2b responses.
- Client requests can serve as implicit heartbeats (see [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]]).

## Learning and Execution: The Commit Index
In basic Paxos, acceptors don't know when a majority is reached—only the Proposer/Learner does.
- **The `leaderCommit` Index**: The leader tracks the highest slot that has reached a majority. It includes this `leaderCommit` value in its next 2a or heartbeat.
- **Execution**: When a server receives a message with `leaderCommit = N`, it knows everything up to slot $N$ is **Chosen** and safe to execute.
- **The Flow**: A 2a for slot 10 might carry `leaderCommit = 8`. This proposes the future (slot 10) while confirming the past (everything up to 8).

## Read-Only Queries and Leases
To ensure **Linearizability**, a leader must ensure it hasn't been deposed before answering a `GET` request.
- **The Risk**: A partitioned leader might serve stale data if a new leader was elected.
- **Leases**: When acceptors respond to a 1a, they grant the leader a time-bound **Lease** (e.g., 5s). During this time, they promise not to respond to other 1a messages.
- **Optimization**: As long as its lease is active, the leader can serve read requests locally from memory without any network round-trips.

## Phase 3 — Failure and Re-election

If the leader fails, a follower will time out and attempt to become the new leader:
1. The follower runs Phase 1 with a higher ballot number than the old leader's.
2. It collects 1b summaries from a majority, discovering any holes in the log.
3. It fills any holes (see [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]]) and then enters steady-state Phase 2.

## Notes
- Timer values matter. We need to give enough time for a server to have a chance to win an election.
- As soon as a server receives a 1a with a higher ballot, it should back off before trying to become a leader.
- Heartbeat messages are how the leader tells followers that it is alive.
---

## Related
- [[CSE452/Paxos/Multi-Paxos|Back to Multi-Paxos]]
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]] — Detecting leader failure via heartbeats
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — How holes are discovered and filled during Phase 1 recovery
- [[CSE452/Paxos/Ballot IDs|Ballot IDs]] — How round numbers (ballot IDs) are structured and compared
