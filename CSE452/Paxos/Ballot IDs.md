# Paxos Ballot IDs (Proposal Numbers)

In Paxos, every proposal must be identified by a unique, monotonically increasing number. This is often called a **Ballot ID**, **Proposal Number**, or **Round Number**.

## Why Global Uniqueness is Required
If two different proposers could use the same ballot number, the system's safety and liveness would collapse.

### 1. Breaking the Agreement Invariant (Safety)
If two proposers use the same ID for different values, they could both potentially reach a majority if they talk to different sets of acceptors.
*   **Scenario**: Proposer A and Proposer B both use Round 10.
*   Proposer A gets "APPLE" accepted by Acceptors {A1, A2}.
*   Proposer B gets "BANANA" accepted by Acceptors {A2, A3}.
*   **Result**: The system has "chosen" two different values for the same slot, which is a total failure of consensus.

### 2. Deadlock and Rejection (Liveness)
Acceptors use the proposal number to determine if a message is "new" or "stale."
*   If an acceptor sees `Prepare(10)` from Proposer A, it promises not to listen to anything less than 10.
*   If it then receives `Prepare(10)` from Proposer B, it will reject it because $10 \ngtr 10$.
*   If both proposers keep picking the same number, they will both be rejected forever, and the system will never progress.

## The Solution: The (Sequence, ID) Tuple
To guarantee uniqueness across all proposers without needing a central coordinator, Paxos uses a tuple:

$$(SequenceNumber, ProposerID)$$

## MultiPaxos Tuple
As we are now dealing with slots we need to keep track of which slot the tuple is for hence multipaxos uses a tuple:
$$
(S=0, R=(seqnum, Proposers Id)
$$
### Comparison Logic
When comparing two Ballot IDs $B_1$ and $B_2$:
1.  Compare the **Sequence Numbers** first.
2.  If the sequence numbers are equal, use the **ProposerID** as a tie-breaker.
3.  $B_1 > B_2$ if:
    - $Seq_1 > Seq_2$
    - OR ($Seq_1 = Seq_2$ AND $ID_1 > ID_2$)

Since every proposer has a unique `ProposerID`, every Ballot ID in the system's history is guaranteed to be globally unique.

## Alternative: Round-Robin Allocation
Another common implementation is to give each proposer a "lane" of numbers:
*   **Proposer 0**: 0, 3, 6, 9...
*   **Proposer 1**: 1, 4, 7, 10...
*   **Proposer 2**: 2, 5, 8, 11...

In this model, the "owner" of any number $n$ is simply $n \pmod{TotalProposers}$.

## Role in the Protocol
*   **Phase 1 (Prepare)**: The proposer "claims" a Ballot ID.
*   **Phase 1b (Promise)**: Acceptors promise to never accept any ID smaller than the one they just saw.
*   **Phase 2 (Accept)**: The proposer uses the same ID to attempt to finalize a value. If it sees a higher ID in the history, it must adopt that value but keep using its own higher ID for authority.

---
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Paxos Invariants|Back to Paxos Invariants]]
- [[CSE452/Paxos/Multi-PaxosComponents/Multi-Paxos|Back to Multi-Paxos]]
