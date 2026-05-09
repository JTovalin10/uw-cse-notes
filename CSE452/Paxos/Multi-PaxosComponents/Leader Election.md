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

### The Life of a Request (Steady State)

In a healthy cluster, client requests follow a high-speed "push" path designed to minimize latency while maintaining strict consensus.

1.  **Receive**: The Leader receives a request from a client. It first performs a duplicate check to ensure the command has not already been processed or assigned a slot.
2.  **Assign & Local Accept**: The Leader assigns the request to the next available slot index ($S_i$). It immediately marks the slot as **ACCEPTED** in its own local log, as the leader inherently trusts its own proposal.
3.  **Immediate Broadcast (P2a)**: The Leader broadcasts a `P2a` message (Accept Request) to all followers. 
    - **Mechanism**: The Leader does not wait for a periodic heartbeat timer; it pushes the data as soon as the request arrives. 
    - **Outcome**: These messages act as **Implicit Heartbeats**, resetting follower election timers and maintaining leader authority.
4.  **Majority Acknowledgement (P2b)**: Followers receive the `P2a`, verify that the ballot number satisfies their current promise, and respond with a `P2b` (Accept Response).
5.  **The CHOSEN Transition**: Once the Leader receives `P2b` responses from a **majority** of the cluster (including its own local vote), it updates the slot status to **CHOSEN**. 
    - **Formal Definition**: $\text{count}(\text{Accepted}(s, v, b)) > N/2$
    - **Simplified Explanation**: Once more than half the nodes have the data, it can never be lost or changed.
6.  **Piggybacked Commit**: The Leader updates its `leaderCommit` index. The knowledge that this slot is now chosen is included in the next message sent to followers, allowing them to mark their local logs as chosen.
7.  **Execution and Client Response**: The Leader waits for all previous slots to be executed to ensure strict serializability. Once the command is applied to the State Machine, the leader captures the output and transmits the final response to the client.

### Learning and Execution: The Commit Index
In basic Paxos, acceptors do not know when a majority is reached—only the Proposer/Learner is aware of the outcome. Multi-Paxos uses the `leaderCommit` index to propagate this knowledge efficiently.

- **The Mechanism**: The leader tracks the highest slot that has reached a majority. It includes this `leaderCommit` value in its next 2a or heartbeat.
- **Sequential Execution**: When a server receives a message with `leaderCommit = N`, it marks everything up to slot $N$ as **CHOSEN**. The State Machine then executes these commands in strict index order.
- **Timeline Example**: A 2a for slot 10 might carry `leaderCommit = 8`. This proposes the future (slot 10) while confirming the past (everything up to 8 is safe to execute).

### Read-Only Queries and Leases
To ensure **Linearizability**, a leader must ensure it has not been deposed before answering a `GET` request.

- **The Risk**: A partitioned leader might serve stale data if a new leader was elected without its knowledge.
- **Leases**: When acceptors respond to a 1a, they grant the leader a time-bound **Lease** (e.g., 5s). During this time, they promise not to respond to other 1a messages.
- **Optimization**: As long as its lease is active, the leader can serve read requests locally from memory without any network round-trips.

### Phase 3 — Failure and Re-election
### Formal Definition
A failure is detected when the $T_{election}$ timer expires without receiving a valid heartbeat ($P2a$ or explicit ping).
### Simplified Explanation
If we haven't heard from the boss in a while, we assume they're gone and start a vote for a new one.

1. The follower runs Phase 1 with a strictly higher ballot number than the old leader's.
2. It collects 1b summaries from a majority, discovering any holes in the log.
3. It fills any holes (see [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]]) and then enters steady-state Phase 2.

## The Rejection Logic: $\leq$ vs $<$

It is critical to distinguish between when an acceptor rejects a message and when it accepts it. The rules change between Phase 1 and Phase 2.

| Message | Logic | Result | Why? |
| :--- | :--- | :--- | :--- |
| **Phase 1a (Prepare)** | $r > max\_ballot$ | **Accept** (New Promise) | To take over, you must be strictly "newer" than the current leader. |
| **Phase 1a (Prepare)** | $r \leq max\_ballot$ | **Reject** | Prevents old or equal-priority nodes from disrupting the stable leader. |
| **Phase 2a (Accept)** | $r \geq max\_ballot$ | **Accept** (Vote) | The current leader is finishing a round you already promised to support. |
| **Phase 2a (Accept)** | $r < max\_ballot$ | **Reject** | Protects the system from "zombie" leaders or delayed stale proposals. |

## Concurrent Elections & Ballot Uniqueness

### Scenario: The "Same Time" Race
What happens if Node A and Node B both timeout at the exact same millisecond and try to become the leader?

1.  **Unique Incrementing**: They both see the last ballot was `9`. They both increment.
2.  **No Collisions**: Because they use the $(Sequence, ServerID)$ tuple, they generate different IDs:
    - **Node A**: `(10, A)`
    - **Node B**: `(10, B)`
3.  **The Winner**: In lexicographical order, `(10, B) > (10, A)` (assuming $B > A$).
4.  **Acceptor 1** receives `10.A` first. It sends a Promise.
5.  **Acceptor 1** then receives `10.B`. Since $10.B > 10.A$, it **must** update its promise to `10.B`.
6.  **The Preemption**: If Node A now sends a `2a` (Accept) with ballot `10.A`, Acceptor 1 will **reject** it because it has already promised `10.B`.

### Why this matters
- **Signaling**: A higher ballot is a signal that a node *assumed* the current leader died.
- **Protection**: The strictly-greater-than rule for Phase 1a ensures that we only listen to nodes that have advanced the "epoch" of the system.

### Liveness Risk: Dueling Proposers
If Node A gets rejected, it might immediately try `(11, A)`. This preempts Node B. This "duel" can continue forever, preventing any values from being chosen.

**The Fix: Randomized Back-off**
When a node's `P1a` is rejected or its `P2a` fails due to a higher ballot, it must wait a **random** amount of time before trying again. 
- **Typical Range**: 150ms – 300ms is a common range for distributed systems projects. 
- **Goal**: This staggered start ensures that one node likely finishes both Phase 1 and Phase 2 before the other even starts its next attempt.

### Example: Preemption Timeline (The "Right After" Case)
This is what happens when a node assumes the leader is dead and preempts it immediately:

1.  **Node 4** is the stable leader. It sends a `2a(Slot: 10, Ballot: 4.Node4)` for a client request.
2.  **Node 5** (Follower) times out at the exact same time because of a network glitch. It assumes Node 4 is dead.
3.  **Node 5** sends `1a(Ballot: 5.Node5)`.
4.  **Acceptor 1** receives Node 5's `1a` first. It updates its `max_ballot` to `5` and promises allegiance to Node 5.
5.  **Acceptor 1** then receives Node 4's `2a` (Ballot 4). 
    - **Logic**: $4 < 5$. 
    - **Action**: **REJECT**.
6.  **Outcome**: Node 4 has been deposed. It must now back off (wait 150-300ms) and eventually try to become the leader again with a ballot higher than 5.

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
