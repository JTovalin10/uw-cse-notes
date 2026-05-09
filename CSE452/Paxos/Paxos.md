# Paxos: Distributed Consensus Overview

**Paxos** is the foundational algorithm for reaching consensus in a distributed system. It allows a cluster of nodes to agree on a single value (or a sequence of values) even when the network is unreliable and nodes may fail.

## Core Concepts

### Formal Definition
Consensus is a coordination primitive that ensures a set of processes agree on a single result $v$ such that:
1. **Validity**: $v$ was proposed by some process.
2. **Agreement**: All non-faulty processes eventually decide on the same $v$.
3. **Termination**: All non-faulty processes eventually reach a decision.

### Simplified Explanation
Paxos is a voting system. Instead of needing everyone to agree, you only need a **Majority** (half the group plus one). Once a majority votes for something, it is "locked in" forever, and even nodes that were offline must eventually accept that result.

## The Quorum Requirement
To tolerate $f$ failures, a system must have at least $2f + 1$ nodes.
- **Why?**: A majority of $f+1$ nodes ensures that any two successful quorums share at least one node. This "overlapping node" is the link that prevents the system from making two different decisions (Split-Brain).

## Main Components of the Paxos Suite
- **[[CSE452/Paxos/Single Paxos|Single Decree Paxos]]**: The core mechanism for deciding one single value. It introduces the two-phase protocol (Prepare and Accept).
- **[[CSE452/Paxos/Multi-Paxos|Multi-Paxos]]**: The production-ready extension that handles an infinite sequence of decisions (a Log). It introduces the "Stable Leader" and "Commit Index" optimizations.
- **[[CSE452/Paxos/Paxos Invariants|Invariants and Design]]**: The mathematical rules that guarantee safety, specifically how Ballot IDs prevent "time travel" or overwriting chosen values.
- **[[CSE452/Paxos/Ballot IDs|Ballot IDs]]**: The technical implementation of unique, monotonic identifiers used to establish authority.

## Motivation
In a replicated system (like a database), every server must execute every client request in the **exact same order**. Paxos provides the "Global Clock" or "Ordered Log" that makes this possible without a single point of failure.

---

## Related
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — Paxos is used to order commands for a DSM
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — An alternative approach to replication
- [[CSE451/Concurrency/Problems/Deadlocks|CSE451: Deadlocks]] — Consensus helps avoid distributed deadlocks
