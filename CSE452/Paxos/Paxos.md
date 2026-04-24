# CSE452: Paxos Overview

**Paxos** is a general algorithm used to get a group of nodes (a distributed system) to reach consensus on a single value or a sequence of operations. It is the foundation for building fault-tolerant replicated systems.

## Key Concepts
- **Consensus**: Agreement among a majority of nodes.
- **Quorum**: A majority ($\frac{n}{2} + 1$) of nodes that must be active for the system to make progress.
- **Ballot ID**: A unique, monotonic identifier for proposals (often a pair of `(number, server_id)`).

## Main Components
- [[CSE452/Paxos/Single Paxos|Single Decree Paxos]] — The core algorithm for deciding a single value. Includes roles (Proposer, Acceptor, Learner) and the two-phase protocol (Prepare/Accept).
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — Extending consensus to a sequence of values (a Log). Explains slots and the "Stable Leader" optimization.
- [[CSE452/Paxos/Paxos Invariants|Invariants and Design]] — Why we use specific Ballot IDs, what problems they fix (like split-brain), and the mathematical invariants that guarantee safety.

## Motivation & Requirements
- **Goal**: All servers execute all client requests in the same order.
- **Validity**: Only a proposed value can be chosen.
- **Agreement**: At most one value can be chosen (safety).
- **Integrity**: No node thinks a value was chosen unless it actually was.
- **Fault Tolerance**: Tolerate $f$ nodes failing with $2f + 1$ total nodes.

---

## Related
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — Paxos is used to order commands for a DSM
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — An alternative approach to replication
- [[CSE451/Threads/Deadlocks|CSE451: Deadlocks]] — Consensus help avoid distributed deadlocks
