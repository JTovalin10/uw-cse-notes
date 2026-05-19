# CSE452: Multi-Paxos Leader Election

In optimized Multi-Paxos, the **Leader** (or Distinguished Proposer) handles all proposals to minimize network latency. This file details the steady-state mechanics, lease management, and the logic for handling concurrent elections.

For core data structures and message formats (P1a, P1b, etc.), see the [[CSE452/Paxos/Multi-Paxos|Multi-Paxos Hub]].

---

## Phase 2: Steady State Mechanics

Once a leader is elected and has completed Phase 1 for all slots, it enters the "Steady State" where it can propose client requests using only Phase 2 (**1 RTT**).

### The Life of a Request (Steady State)

1.  **Receive**: The Leader receives an `AMORequest` from a client. It first performs a duplicate check using its local AMO state (see [[CSE452/Paxos/Multi-PaxosComponents/Log#Avoiding Duplicate Proposals|Deduplication]]).
2.  **Assign & Local Accept**: The Leader assigns the request to the next available slot index ($S_i$). It immediately marks the slot as **ACCEPTED** in its own local log.
3.  **Immediate Broadcast (P2a)**: The Leader broadcasts a `P2a` message to all followers. These messages act as **Implicit Heartbeats**, resetting follower election timers.
4.  **Majority Acknowledgement (P2b)**: Followers receive the `P2a`, verify that the ballot satisfies their current promise, and respond with a `P2b`.
5.  **The CHOSEN Transition**: Once the Leader receives `P2b` responses from a **majority** (including itself), it updates the slot status to **CHOSEN**.
6.  **Execution and Client Response**: The Leader waits for all previous slots to be executed to ensure strict serializability. Once applied to the State Machine, it transmits the response to the client.

---

## The Rejection Logic: $\leq$ vs $<$

Acceptors must strictly follow their promises to maintain safety. The rules for rejection differ between Phase 1 and Phase 2.

| Message | Logic | Result | Why? |
| :--- | :--- | :--- | :--- |
| **Phase 1a (Prepare)** | $r > max\_ballot$ | **Accept** (New Promise) | To take over, you must be strictly "newer" than the current leader. |
| **Phase 1a (Prepare)** | $r \leq max\_ballot$ | **Reject** | Prevents old or equal-priority nodes from disrupting the stable leader. |
| **Phase 2a (Accept)** | $r \geq max\_ballot$ | **Accept** (Vote) | The current leader is finishing a round you already promised to support. |
| **Phase 2a (Accept)** | $r < max\_ballot$ | **Reject** | Protects the system from "zombie" leaders or delayed stale proposals. |

---

## Linearizability and Leases

To ensure **Linearizability** (where a read always returns the most recent write), a leader must ensure it hasn't been deposed before answering a read-only request.

- **The Risk**: A partitioned leader might serve stale data if a new leader was elected without its knowledge.
- **The Solution (Leases)**: When acceptors respond to a `P1a`, they grant the leader a time-bound **Lease** (e.g., 5 seconds). During this time, they promise **not** to respond to any other `P1a` messages.
- **Optimization**: As long as its lease is active and it has a majority, the leader can serve read requests locally from memory without a network round-trip.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Distinguished Proposer / Leader** | Leader |
| **Steady State** | Normal-case operation / fast path |
| **Lease** | Leader lease / read lease |
| **CHOSEN Transition** | Commit |
| **Zombie Leader** | Stale / deposed leader |

---

## Related
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos Hub]] — Core message structures and data types.
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Failure Detection]] — Detecting leader failure via timers.
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — Recovery logic for the transition from Follower to Leader.
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Log]] — slot pointers and deduplication referenced during steady state.
