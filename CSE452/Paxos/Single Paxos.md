# CSE452: Single Decree Paxos

**Single Decree Paxos** is the core algorithm used to reach consensus on a **single value** in a distributed system. It serves as the atomic building block for more complex systems like [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]].

## Formal Requirements
The protocol must satisfy three formal safety requirements:
1.  **Validity**: The chosen value must have been proposed by some node.
2.  **Agreement**: At most one value can be chosen across the entire cluster.
3.  **Integrity**: A node cannot believe a value is chosen unless it actually reached a majority.

## Narrative Mechanics
The protocol operates in two distinct phases to ensure that a value is only chosen if it is safe to do so.

1.  **Phase 1 (Discovery and Promise)**: A proposer "pings" a majority to see if anyone has already voted for a value and to "lock down" the majority so they don't listen to older proposers.
2.  **Phase 2 (Propose and Accept)**: If Phase 1 succeeds, the proposer tells the majority to "vote" for a specific value.

### Simplified Explanation
Think of Phase 1 as a "Reservation." You ask a majority of nodes to save a spot for your proposal number. If they agree, Phase 2 is when you actually show up and "Fill" that spot with a value.

## Implementation Detail
- **[[CSE452/Paxos/Single-PaxosComponents/Roles|Roles]]**: Every node can act as a Proposer, Acceptor, or Learner.
- **[[CSE452/Paxos/Single-PaxosComponents/Protocol|The Protocol]]**: The step-by-step logic for 1a, 1b, 2a, and 2b messages.
- **[[CSE452/Paxos/Single-PaxosComponents/Majority Overlap|Majority Overlap]]**: The mathematical proof that quorums must intersect.
- **[[CSE452/Paxos/Single-PaxosComponents/Safety and Scenarios|Safety and Scenarios]]**: How the system handles node crashes during the voting process.

> **Note on Liveness**: Paxos guarantees **Safety** (it will never make a wrong decision) but not **Liveness** (it might never make a decision at all if proposers keep fighting). This is known as the **FLP Impossibility** — see [[CSE452/Knowledge/Knowledge#Consensus and the FLP Impossibility Result|Knowledge: FLP Impossibility]].

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Single Decree Paxos** | Basic Paxos / Synod algorithm |
| **Phase 1 (Prepare)** | Prepare / read phase |
| **Phase 2 (Accept)** | Accept / write phase |
| **Chosen Value** | Committed / decided value |

---

## Related
- [[CSE452/Paxos/Paxos|Paxos Overview]] — the consensus problem and the Paxos suite
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — extending single-decree Paxos to a log of values
- [[CSE452/Paxos/Paxos Invariants|Paxos Invariants and Design]] — Ballot IDs and the safety invariants
- [[CSE452/Knowledge/Knowledge|Knowledge in Distributed Systems]] — the FLP result behind Paxos's liveness limitation
