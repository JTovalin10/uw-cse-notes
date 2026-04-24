# Paxos Invariants and Design

This note explains the technical "why" behind Paxos, focusing on the Ballot ID structure and the invariants that keep the system safe.

## The Ballot ID (Proposal Number)
A Ballot ID must be **unique** and **monotonically increasing**. 

To ensure this, Paxos typically uses a tuple $(SequenceNumber, ServerID)$ or round-robin allocation. 

**See also**: [[CSE452/Paxos/Ballot IDs|Detailed: Why Ballot IDs must be unique]]

## What do Ballot IDs fix?
1.  **Stale Proposers**: If an old proposer (who was partitioned or slow) tries to propose something after a newer proposer has already started, the newer proposer will have a higher ballot number. Acceptors will reject the old proposer's messages because they have already promised a higher number.
2.  **Split Brain**: In a network partition, both sides might try to elect a leader. The side with the higher ballot number (and a majority) will eventually win or pre-empt the other side.
3.  **Safety Invariance**: It allows the protocol to "lock" a value once a majority has agreed.

## Scenario: Why we need unique IDs
Imagine Server A and Server B both use Round 10:
1.  Server A sends `Prepare(10)` to Acceptor 1. A1 promises.
2.  Server B sends `Prepare(10)` to Acceptor 2. A2 promises.
3.  Server A sends `Accept(10, "Value A")` to A1 and A2.
4.  **Problem**: A2 says: "I already promised Round 10 (from Server B), so I can't accept your Round 10." 
5.  If Server A and B use exactly the same ID, the acceptors cannot distinguish between them, leading to a deadlock where nobody can progress. 
6.  **Fix**: By using `(10, ServerA)` vs `(10, ServerB)`, the nodes know exactly which proposal is "newer" and which one to reject.

## Scenario: Dueling Proposers (Liveness Issue)
This is why Paxos is safe (never chooses two values) but not always live (might never choose one).

1.  **Proposer 1** prepares Round 10.
2.  **Proposer 2** prepares Round 20 before Proposer 1 can finish Phase 2.
3.  **Acceptors** reject Proposer 1's `Accept(10)` because they promised Round 20.
4.  **Proposer 1** sees the failure and immediately prepares Round 30.
5.  **Acceptors** now reject Proposer 2's `Accept(20)` because they promised Round 30.
6.  **Result**: They keep "stepping on each other's toes" forever.
7.  **The Fix**: Use a **Stable Leader** (Multi-Paxos) or **Randomized Backoff** so one proposer gets enough time to finish both phases.

## Core Invariant(s) (The "Rules" of Paxos)
Paxos relies on these safety properties:

### 1. The Quorum Intersection Property
Any two majorities (quorums) **must overlap** by at least one node.
- This overlap is the "link" that carries information from a previous successful round to a new round.

### 2. The P2 Rule (The Value Choice Rule)
> *If a proposal with value $v$ is chosen, then every higher-numbered proposal that is chosen has value $v$.*

- **How it's enforced**: In Phase 2, a proposer **cannot** pick its own value if it learns that any acceptor in its Phase 1 quorum has already accepted a value. It must "adopt" the value from the **highest-numbered previous round** (highest Ballot ID) it learned about.
- **Example**: 
	- Proposer (Ballot 10) contacts Acceptors A, B, and C.
	- **Acceptor A** says: "I accepted 'Value X' in Ballot 5."
	- **Acceptor B** says: "I accepted 'Value Y' in Ballot 8."
	- **Acceptor C** says: "I haven't accepted anything."
	- **The Result**: The Proposer **must** adopt **Value Y** (because 8 is the highest ballot number). It doesn't matter that Value Y only had one vote; the rule is about the *newest* attempt (highest ID), not the *most popular* one.
- **The result**: Once a majority chooses $v$, any future proposer will be forced to see $v$ in its Phase 1 (because its majority will intersect with the majority that chose $v$) and will propose $v$ again in Phase 2. This "locks" the value forever.

### 3. The Promise Invariant
> *Once an acceptor sends a `Promise(n)`, it can never accept any proposal with a number $n' < n$.*

- This prevents "time travel" where an old proposer could overwrite a newly agreed-upon value.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Multi-Paxos|Continue to Multi-Paxos]]
