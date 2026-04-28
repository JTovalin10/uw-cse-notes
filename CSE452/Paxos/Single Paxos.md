# Single Decree Paxos

**Single Decree Paxos** is the core algorithm used to reach consensus on a **single value** in a distributed system, even in the presence of node failures.

## The Consensus Problem
The protocol must satisfy three formal requirements:
1.  **Validity**: The chosen value was proposed (no making up values).
2.  **Agreement**: At most one value is chosen (never two different winners).
3.  **Integrity**: No node believes a value is chosen unless it actually was (Learners aren't misled).

> **Note on Liveness**: Paxos does not guarantee it will always terminate (FLP Impossibility), but it makes progress whenever the network behaves "well enough" for long enough.

## Roles
- **Proposer**: Drives the protocol. Picks ballot numbers and proposes values.
- **Acceptor**: Votes on proposals. The fixed set of acceptors collectively holds the state.
- **Learner**: Detects when a value has been chosen and reports it.

## The Ballot Protocol (Message Names)
Paxos is often described using a compact message notation:

| Message      | Name           | Direction | Content                                                                   |
| :----------- | :------------- | :-------- | :------------------------------------------------------------------------ |
| **1a(r)**    | Prepare        | P $\to$ A | "I am beginning round $r$."                                               |
| **1b(r, s)** | Promise        | A $\to$ P | "I promise not to participate in rounds < $r$. Here is my history ($s$)." |
| **2a(r, v)** | Accept Request | P $\to$ A | "Please vote for value $v$ in round $r$."                                 |
| **2b(r, v)** | Accept Reply   | A $\to$ L | "I voted for $v$ in round $r$."                                           |

## The Algorithm: Step-by-Step

### Phase 1: Prepare (1a/1b)
1.  **Proposer**: Selects a unique, monotonically increasing **Ballot Number** $r$. 
    - **See also**: [[CSE452/Paxos/Ballot IDs|How to generate unique Ballot IDs]].
2.  **Acceptor**: 
    - If $r > max\_ballot$, updates $max\_ballot = r$ and responds with **1b**.
	    - This means that the acceptor promises to never accept anything than r
    - **The Summary ($s$)**: If the acceptor previously voted (sent a 2b) in an earlier round, it includes the highest round $r'$ and value $v'$ it voted for. Otherwise, $s = null$.

### Phase 2: Accept (2a/2b)
1.  **Proposer**: Waits for a majority of **1b** responses.
    - If all summaries are $null$, the proposer can propose its own value.
    - If any summary is non-null, the proposer **must** propose the value $v'$ from the **highest-numbered round** $r'$ reported.
    - **Crucial Rule**: The proposer's original intended value is **not** part of this comparison. If it sees a previous value, it **discards** its own and "adopts" the old one.

> **Example**: Proposer M is running **Round 8**. It hears from three acceptors:
> - A1: Voted in Round 2 for $V_1$
> - A2: No history ($null$)
> - A3: Voted in Round 4 for $V_2$
> 
> Even though M is in Round 8, it sees that Round 4 is the highest historical round. M **must** propose $(8, V_2)$. It uses its own round (8) for authority, but the old value ($V_2$) for safety.

2.  **Acceptor**: Receives **2a(r, v)**. If it hasn't promised a higher round since Phase 1, it sends **2b(r, v)** to the learners.

## Why Phase 1 Needs a Majority (The "History Check")
While it is intuitive why Phase 2 needs a majority (to "choose" the value), Phase 1 needs a majority to ensure the Proposer doesn't accidentally "overwrite" a value that was already chosen in an earlier round.

### The "What if I missed it?" Problem
Imagine a system with 5 Acceptors (Majority = 3).
1.  **Round 1**: Proposer A talks to Acceptors {1, 2, 3}. They all accept **"APPLE"**.
    *   **APPLE is now Chosen.**
2.  **Round 2**: Proposer B comes along. They want to propose **"BANANA"**.
    *   **If Proposer B only talked to 2 people** (e.g., {4, 5}), they would see no history. They would think they are free to propose "BANANA".
    *   **The Result**: The system would have two different chosen values (APPLE and BANANA), breaking the **Agreement** invariant.

### The Solution: Majority Overlap
By **forcing** Proposer B to receive responses from a **majority (3 people)**, they are mathematically guaranteed to hit at least one node that was part of the previous majority.
*   If Proposer B talks to {3, 4, 5}:
    *   Nodes 4 and 5 say: "No history here."
    *   **Node 3 says**: "Wait! I already accepted APPLE in Round 1."
*   Because Proposer B hears from Node 3, they now know APPLE was already the winner. They must abandon "BANANA" and use "APPLE" for their own Phase 2.

**Summary**: Phase 1 is a **Discovery Phase**. You talk to a majority so you can be 100% sure that if the group already made a decision, you've heard about it before you try to make a new one.

## What "Chosen" Actually Means
In Paxos, "chosen" is a property of the **system state**, not an action.
- **chosen(r, v)** holds if a majority of acceptors have sent 2b(r, v).
- **chosen(v)** holds if there exists any round $r$ where $v$ was chosen.

**Key Insight**: A value can be chosen even if the proposer crashes immediately after sending 2a, and before any node "knows" it. The learner's job is simply to detect this pre-existing state.

## Connection to Knowledge
Paxos climbs the knowledge hierarchy:
1.  **Distributed Knowledge**: Once a majority votes, "v is chosen" is distributed knowledge. No single node knows it, but the group's state determines it.
2.  **Individual Knowledge**: The Learner gathers 2b messages to achieve $K_L(v \text{ is chosen})$.
3.  **Common Knowledge**: Impossible in asynchronous systems, but we reach enough "Everyone Knows" ($E_G$) to perform work.

## The Votes Table (Visualization)
A useful tool for tracking safety. Rows are rounds, columns are acceptors.
- `✓`: Voted (sent 2b).
- `✗`: Promised not to vote (sent 1b for a higher round).
- A value is chosen when a row has a majority of `✓`.

| Round | A1 | A2 | A3 | Result |
| :--- | :--- | :--- | :--- | :--- |
| 1 ($v_1$) | `✓` | `✗` | `✗` | Minority; not chosen. |
| 2 ($v_2$) | ` ` | `✓` | `✓` | **Chosen!** (Majority A2, A3) |

Safety is guaranteed because any new majority in a higher round **must** overlap with the previous majority, encountering at least one `✓` that forces the proposer to adopt the old value.

## Failure Scenario: Dropped 2b
If all 2b messages for a chosen value $v_1$ are dropped, the learner sees nothing. 
- **Recovery**: Any proposer can start a fresh round (Round 2). 
- Because $v_1$ was chosen (or even just voted for by a minority that the new proposer hits), Phase 1 will return a non-null summary.
- The new proposer is forced to propose $v_1$ again, "re-choosing" it and giving the learner another chance to hear the result.

## The Three-Round Scenario (Safety in Action)
This scenario demonstrates how the "Highest Round" rule and "Majority Overlap" work together when the system state is fragmented.

**Setup (3 Acceptors: A1, A2, A3):**
1.  **Round 1**: A3 votes for $v_1$ (sent 2b).
2.  **Round 2**: A2 votes for $v_2$ (sent 2b).
3.  **Round 3**: Proposer $P_3$ starts Phase 1.

| Round | A1 | A2 | A3 | Summary |
| :--- | :--- | :--- | :--- | :--- |
| 1 ($v_1$) | ` ` | ` ` | `✓` | Not chosen |
| 2 ($v_2$) | ` ` | `✓` | ` ` | Not chosen |
| 3 ($v_?$) | ` ` | ` ` | ` ` | **What must $P_3$ propose?** |

**Outcome for $P_3$:**
$P_3$ needs a majority (2 out of 3) of 1b responses. Because A2 and A3 have both voted, $P_3$ **cannot** avoid seeing a non-null summary:
- **If $P_3$ hits {A1, A2}**: It sees $v_2$ from Round 2. It **must** propose $v_2$.
- **If $P_3$ hits {A1, A3}**: It sees $v_1$ from Round 1. It **must** propose $v_1$.
- **If $P_3$ hits {A2, A3}**: It sees both. It must pick the value from the **highest round** (Round 2) and propose $v_2$.

### The 5-Acceptor Comparison
The interaction between the number of acceptors and rounds matters. If we had 5 acceptors (majority = 3):
- If only A2 and A3 had voted, $P_3$ could potentially reach A1, A4, and A5. 
- All three would return `null` summaries.
- $P_3$ would then be "free" to propose a brand new value $v_3$.
- **Why is this safe?** Because with only 2 votes ($v_1$ and $v_2$), no value could have possibly been chosen yet in a 5-node system. The "distributed knowledge" of a chosen value is only guaranteed to be hit if the proposer contacts a majority.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Multi-PaxosComponents/Multi-Paxos|Continue to Multi-Paxos]]
- [[CSE452/Paxos/Paxos Invariants|In-depth: Ballot IDs and Invariants]]
