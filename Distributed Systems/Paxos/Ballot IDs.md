# Distributed Systems: Ballot IDs and Proposal Numbers

In Paxos, every proposal must be identified by a unique, monotonically increasing number. This identifier, known as a **Ballot ID**, **Proposal Number**, or **Round Number**, establishes the "authority" of a proposer.

## Why Global Uniqueness is Required
If two different proposers were to use the same ballot number for different values, the system's safety and liveness would collapse.

### 1. Breaking the Agreement Invariant (Safety)
If two proposers use the same ID for different values, they could both potentially reach a majority if they communicate with disjoint sets of acceptors.
- **Scenario**: Proposer A and Proposer B both use Round 10.
- Proposer A gets "APPLE" accepted by Acceptors {A1, A2}.
- Proposer B gets "BANANA" accepted by Acceptors {A2, A3}.
- **Outcome**: The system has "chosen" two different values for the same slot, violating the fundamental agreement invariant.

### 2. Deadlock and Rejection (Liveness)
Acceptors use the proposal number to determine if a message is a valid update or a stale request.
- If an acceptor has promised Ballot 10, it will ignore any `Prepare(10)` it receives.
- If both proposers repeatedly choose the same number, they will be rejected indefinitely, preventing the system from ever reaching a decision.

## The Solution: The (Sequence, ID) Tuple
To guarantee global uniqueness without a central coordinator, Paxos uses a comparable tuple:

$$(SequenceNumber, ServerID)$$

### Comparison Logic
When comparing two Ballot IDs $B_1$ and $B_2$, the system uses lexicographical ordering:
1.  Compare the **Sequence Numbers** first.
2.  If the sequence numbers are equal, the **ServerID** acts as the tie-breaker.
3.  $B_1 > B_2$ if:
    - $Seq_1 > Seq_2$
    - OR ($Seq_1 = Seq_2$ AND $ID_1 > ID_2$)

Since every server in the cluster is assigned a unique `ServerID`, every generated Ballot ID is guaranteed to be unique.

## Multi-Paxos Context
In [[Multi-Paxos|Multi-Paxos]], Ballot IDs are combined with Slot indices to track consensus across an infinite log. The full identifier for an operation is often expressed as:
$$(\text{Slot}, (\text{Sequence}, \text{ServerID}))$$

## Implementation Alternatives: Round-Robin
Another common implementation gives each proposer a fixed "lane" of numbers to avoid collisions:
- **Server 0**: 0, 3, 6, 9...
- **Server 1**: 1, 4, 7, 10...
- **Server 2**: 2, 5, 8, 11...

In this model, the owner of any number $n$ is simply $n \pmod{\text{TotalServers}}$.

## Role in the Protocol
- **Phase 1 (Prepare)**: The proposer "claims" a Ballot ID to assert authority.
- **Phase 1b (Promise)**: Acceptors promise to never accept any ID smaller than or equal to the one they just saw.
- **Phase 2 (Accept)**: The proposer uses the same ID to attempt to finalize a value. If an acceptor has already seen a higher ID, it must reject this proposal.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Ballot ID** | Proposal number / round number / term (Raft) |
| **(Sequence, ServerID) Tuple** | Lamport-style unique-ID tuple |
| **Round-Robin Allocation** | Proposer ID partitioning |

---

## Related
- [[Single Paxos|Single Decree Paxos]] — where ballot IDs first appear in the two-phase protocol
- [[Paxos Invariants|Paxos Invariants and Design]] — how ballot IDs enforce the safety invariants
- [[Multi-Paxos|Multi-Paxos]] — ballot IDs combined with slot indices across the log
