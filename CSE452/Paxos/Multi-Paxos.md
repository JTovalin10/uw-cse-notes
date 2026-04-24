# Multi-Paxos

**Multi-Paxos** builds on the core Single Decree Paxos algorithm to decide values for an entire sequence of log slots rather than just a single decision.

## The Concept of Slots
In a replicated state machine, we don't just need one agreement; we need to agree on an ordered sequence of commands.
- The log is divided into **slots** (Slot 1, Slot 2, ..., Slot $i$).
- Each slot runs an independent instance of Paxos to decide which command goes into that slot.

## Efficiency: The "Stable Leader"
Running two full phases (Prepare and Accept) for every single log slot is slow. Multi-Paxos optimizes this by electing a **Leader**.

1.  **Leader Election**: A proposer runs Phase 1 (Prepare) for **all future slots** at once using a single ballot number.
2.  **Steady State**: Once an acceptor promises to that leader, the leader can skip Phase 1 for subsequent slots. It only needs to run Phase 2 (Accept) to propose new values.
3.  **Failure**: If the leader fails, a new proposer will eventually time out and try to become the leader by running Phase 1 with a higher ballot number.

## Roles in Multi-Paxos
In most practical implementations:
- Every server acts as a **Proposer**, **Acceptor**, and **Learner**.
- One server is designated the **Distinguished Proposer** (Leader).
- Clients send requests to the Leader.
- The Leader assigns the request to the next available slot and initiates Phase 2.

## Key Differences from Single Paxos
- **Multiple Instances**: One Paxos instance per log index.
- **Phase 1 Elision**: Only the leader runs Phase 1; everyone else just accepts (Phase 2).
- **Log Gaps**: If a slot fails to reach consensus (e.g., due to message loss), the log may have "holes" that must be filled before the state machine can execute subsequent commands.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Paxos Invariants|In-depth: Ballot IDs and Invariants]]
