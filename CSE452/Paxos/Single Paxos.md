# CSE452: Single Decree Paxos

**Single Decree Paxos** is the core algorithm used to reach consensus on a **single value** in a distributed system, even in the presence of node failures.

## Core Concepts
- **[[CSE452/Paxos/Single-PaxosComponents/Roles|Roles]]**: Proposers, Acceptors, and Learners.
- **[[CSE452/Paxos/Single-PaxosComponents/Protocol|The Protocol]]**: Phase 1 (Prepare) and Phase 2 (Accept).
- **[[CSE452/Paxos/Single-PaxosComponents/Majority Overlap|Majority Overlap]]**: Why quorums are required for safety and discovery.
- **[[CSE452/Paxos/Single-PaxosComponents/Safety and Scenarios|Safety and Scenarios]]**: Visualization of votes and complex failure cases.

## Requirements
The protocol must satisfy three formal requirements:
1.  **Validity**: The chosen value was proposed.
2.  **Agreement**: At most one value is chosen.
3.  **Integrity**: No node believes a value is chosen unless it actually was.

> **Note on Liveness**: Paxos does not guarantee it will always terminate (FLP Impossibility), but it makes progress whenever the network behaves "well enough" for long enough.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Multi-Paxos|Continue to Multi-Paxos]]
- [[CSE452/Paxos/Paxos Invariants|In-depth: Ballot IDs and Invariants]]
