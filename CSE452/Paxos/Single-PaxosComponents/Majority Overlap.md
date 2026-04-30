# CSE452: Paxos Majority Overlap

While it is intuitive why Phase 2 needs a majority (to "choose" the value), Phase 1 needs a majority to ensure the Proposer doesn't accidentally "overwrite" a value that was already chosen in an earlier round.

## The "What if I missed it?" Problem
Imagine a system with 5 Acceptors (Majority = 3).
1.  **Round 1**: Proposer A talks to Acceptors {1, 2, 3}. They all accept **"APPLE"**.
    *   **APPLE is now Chosen.**
2.  **Round 2**: Proposer B comes along. They want to propose **"BANANA"**.
    *   **If Proposer B only talked to 2 people** (e.g., {4, 5}), they would see no history. They would think they are free to propose "BANANA".
    *   **The Result**: The system would have two different chosen values (APPLE and BANANA), breaking the **Agreement** invariant.

## The Solution: Majority Overlap
By **forcing** Proposer B to receive responses from a **majority (3 people)**, they are mathematically guaranteed to hit at least one node that was part of the previous majority.
*   If Proposer B talks to {3, 4, 5}:
    *   Nodes 4 and 5 say: "No history here."
    *   **Node 3 says**: "Wait! I already accepted APPLE in Round 1."
*   Because Proposer B hears from Node 3, they now know APPLE was already the winner. They must abandon "BANANA" and use "APPLE" for their own Phase 2.

**Summary**: Phase 1 is a **Discovery Phase**. You talk to a majority so you can be 100% sure that if the group already made a decision, you've heard about it before you try to make a new one.

---
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Paxos Invariants#1. The Quorum Intersection Property|Quorum Intersection Property]]
