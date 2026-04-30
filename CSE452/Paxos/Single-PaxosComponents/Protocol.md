# CSE452: The Paxos Protocol

The Paxos protocol consists of two main phases to ensure that a single value is chosen safely.

## Message Names
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
	    - This means that the acceptor promises to never accept anything with a ballot lower than $r$.
    - **The Summary ($s$)**: If the acceptor previously voted (sent a 2b) in an earlier round, it includes the highest round $r'$ and value $v'$ it voted for. Otherwise, $s = null$.

### Phase 2: Accept (2a/2b)
1.  **Proposer**: Waits for a majority of **1b** responses.
    - If all summaries are $null$, the proposer can propose its own value.
    - If any summary is non-null, the proposer **must** propose the value $v'$ from the **highest-numbered round** $r'$ reported.
    - **Crucial Rule**: The proposer's original intended value is **not** part of this comparison. If it sees a previous value, it **discards** its own and "adopts" the old one.

2.  **Acceptor**: Receives **2a(r, v)**. If it hasn't promised a higher round since Phase 1, it sends **2b(r, v)** to the learners.

---
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Single-PaxosComponents/Majority Overlap|Why Phase 1 needs a Majority]]
- [[CSE452/Paxos/Single-PaxosComponents/Roles|Paxos Roles]]
