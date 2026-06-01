# CSE452: Transactions (2PC)

To support operations that span multiple keys across different [[Shard|shards]] and [[Replica Group|replica groups]], the system implements **Two-Phase Commit (2PC)** with distributed locking. For the motivation — the failure modes of the naive cross-group protocol that make 2PC necessary — see [[Two-Phase Commit|Two-Phase Commit: Motivation]].

---

## 2PC Components

- [[Phases and Roles|Phases and Roles]] — coordinator vs. participant roles, Phase 1 (Prepare) and Phase 2 (Commit/Abort) mechanics, reconfiguration interactions, and the one-configuration rule
- [[Locking and Deadlock|Locking and Deadlock]] — read/write lock rules, locks held in the replicated state machine, abort-on-conflict deadlock prevention, and retry differentiation
- [[Vanilla 2PC vs Paxos Commit|Vanilla 2PC vs Paxos Commit]] — the blocking problem in classic 2PC, how Paxos Commit solves it, and why this course's implementation is already a form of Paxos Commit
- [[Log Operations|Log Operations]] — the six log entry types (`BEGIN`, `LOCK(READ)`, `LOCK(WRITE)`, `PREPARE-COMMIT`, `COMMIT`, `ABORT`) with semantics, preconditions, and log sequence for each outcome
- [[MultiPut Walkthrough|MultiPut Walkthrough]] — step-by-step trace of `MultiPut({k1: v1}, {k2: v2})` across two groups showing messages and log state at each step
- [[Failure Scenarios|Failure Scenarios]] — lock contention (PrepareNotOK) and coordinator timeout, including recovery using the log

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Two-Phase Commit (2PC)** | Atomic Commitment Protocol (ACP) |
| **Transaction Coordinator** | Transaction Manager (TM) |
| **Participant** | Resource Manager (RM) |
| **Prepare Phase** | Voting phase |
| **Commit/Abort Phase** | Decision / completion phase |
| **Distributed Lock** | Pessimistic write lock / two-phase locking (2PL) |
| **Abort-on-conflict** | No-wait deadlock prevention |

---

## Related

- [[Two-Phase Commit|Two-Phase Commit: Motivation]] — naive swap protocol and its five failure modes
- [[Sharding|Sharding Overview]] — the architecture transactions span
- [[Reconfiguration|Reconfiguration]] — the one-configuration rule and delayed reconfiguration
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — the groups participating as coordinator and participants
- [[Linearizability|Linearizability]] — the guarantee 2PC preserves for multi-key operations
- [[Multi-Paxos|Multi-Paxos]] — the consensus layer behind every 2PC state transition
