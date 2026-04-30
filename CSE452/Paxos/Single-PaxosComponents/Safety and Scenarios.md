# CSE452: Paxos Safety and Scenarios

## What "Chosen" Actually Means
In Paxos, "chosen" is a property of the **system state**, not an action.
- **chosen(r, v)** holds if a majority of acceptors have sent 2b(r, v).
- **chosen(v)** holds if there exists any round $r$ where $v$ was chosen.

**Key Insight**: A value can be chosen even if the proposer crashes immediately after sending 2a, and before any node "knows" it. The learner's job is simply to detect this pre-existing state.

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

---
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Single-PaxosComponents/Majority Overlap|Majority Overlap]]
