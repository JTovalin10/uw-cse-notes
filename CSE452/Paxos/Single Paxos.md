# Single Decree Paxos

**Single Decree Paxos** is the core algorithm used to reach consensus on a **single value** in a distributed system, even in the presence of node failures (excluding Byzantine failures).

## Roles
While often mapped to physical nodes, roles are distinct functional entities:

- **Proposers**: Propose values by starting a new **Ballot**. They first communicate with acceptors to learn about any values already being considered.
- **Acceptors**: The "memory" of the protocol. They vote on proposals. A **Majority** (quorum) of acceptors must agree for a value to be chosen.
    - You can tolerate $f$ failures with $2f + 1$ acceptors (need a majority $\frac{n}{2} + 1$).
- **Learners**: Discover the final result once a value has been chosen by a majority.

## The Algorithm: Step-by-Step

### Phase 1: Prepare
1.  **Proposer**: Selects a unique, monotonically increasing **Ballot Number** $n$. It sends a `Prepare(n)` message to a majority of acceptors.
2.  **Acceptor**: Maintains two pieces of state: `max_ballot` (highest promised) and `(accepted_n, accepted_v)` (the last value it actually voted for).
    - **The Filter**: If $n > max_ballot$, the acceptor updates `max_ballot = n` and responds with a `Promise`.
    - **The Promise**: It guarantees it will never again accept a proposal with a number less than $n$.
    - **The History**: If the acceptor has *ever* accepted a proposal in the past (Phase 2 of an earlier round), it **must** include that `(accepted_n, accepted_v)` in its `Promise` response. If it has never accepted a value, it returns `null`.

#### Example Promise Messages
*   **Case A (Fresh Acceptor)**: Proposer sends `Prepare(10)`. Acceptor has never seen a proposal.
    *   **Response**: `Promise(10, accepted_n=null, accepted_v=null)`
    *   *Result*: Proposer is free to propose any new value.
*   **Case B (Previously Voted)**: Proposer sends `Prepare(20)`. Acceptor previously voted for "Value X" in Round 5.
    *   **Response**: `Promise(20, accepted_n=5, accepted_v="Value X")`
    *   *Result*: Proposer **must** use "Value X" for its own proposal in Phase 2.

### Phase 2: Accept
1.  **Proposer**: Waits for a majority of `Promise` responses.
    - **Crucial Rule**: The proposer looks at all the `(accepted_n, accepted_v)` pairs returned.
    - If any were not `null`, the proposer **must** throw away its own intended value and use the `accepted_v` from the **highest-numbered** round reported by the acceptors.
    - If all were `null`, the proposer can finally use its own value (e.g., the client's request).
    - It sends `Accept(n, v)` to a majority of acceptors.
2.  **Acceptor**: Receives `Accept(n, v)`.
    - If $n \geq max_ballot$, it accepts the value, updates its state to `(accepted_n=n, accepted_v=v)`, and notifies learners.

### Phase 3: Learning
1.  **Learner**: Once a learner receives `Accepted(n, v)` from a majority of acceptors, the value $v$ is considered **chosen**.

## Deep Dive: Understanding Majorities

### 1. The "Fixed Majority" Rule
The majority required for consensus is **always based on the initial total number of nodes**, not the number of nodes currently alive.
- **Example (7-node cluster)**: The majority is always **4**. 
- If 2 nodes die, you still need 4 votes. This means you need 4 out of the 5 remaining nodes to agree.
- If 4 nodes die, the system **stalls** because you only have 3 nodes left and can never reach the required 4 votes.
- **Why?** This prevents "Split Brain." If the cluster partitions, only the side that can reach the *original* majority can make progress.

### 2. Value Adoption (Phase 2 Rule)
When a proposer performs Phase 1 (Prepare), it doesn't care if a value has reached a majority yet. 
- **The Rule**: If **any** node in your Phase 1 quorum reports having accepted a value, you **must** adopt the value from the **highest ballot number** reported.
- **Example**: 
    - Acceptor A voted for "X" in Ballot 5.
    - Acceptor B and C have never voted.
    - Proposer (Ballot 10) talks to A and B. 
    - Even though "X" only has 1 vote (not a majority), the Proposer **must** adopt "X" for Ballot 10.
- **Why?** The proposer cannot know if that value *might* have reached a majority on nodes it didn't talk to (like C). Adopting it "just in case" ensures that once a value is chosen, it stays chosen.

## Summary of Logic
- **Safety**: A value is chosen only when a majority agrees. Since any two majorities overlap by at least one node, that node "remembers" the chosen value and forces any future proposers to adopt it (Phase 2 rule).
- **Liveness**: Paxos does not guarantee liveness (it can get stuck in a "dueling proposers" scenario), but in practice, a leader/randomized backoff is used.

## Visualizing Safety: A Step-by-Step Scenario
Imagine a system with 3 Acceptors (A1, A2, A3).

1.  **Proposer 1** starts **Round 10**.
    - Sends `Prepare(10)` to A1 and A2.
    - Both respond `Promise(10, null, null)`.
2.  **Proposer 1** sends `Accept(10, "Value A")` to A1 and A2.
    - Both accept it. **"Value A" is now chosen** (a majority has voted).
3.  **Proposer 2** starts **Round 20** (a later round).
    - Sends `Prepare(20)` to A2 and A3.
    - A3 responds `Promise(20, null, null)` (it hasn't voted yet).
    - **Crucially**, A2 responds `Promise(20, accepted_n=10, accepted_v="Value A")`.
4.  **Proposer 2** must follow the rule:
    - It sees "Value A" was already being voted on in Round 10.
    - It **must** drop its own value and send `Accept(20, "Value A")`.
    - **Result**: Even though Proposer 2 had a higher number, it was forced to "adopt" the already chosen value. Safety is preserved.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Multi-Paxos|Continue to Multi-Paxos]]
- [[CSE452/Paxos/Paxos Invariants|In-depth: Ballot IDs and Invariants]]
