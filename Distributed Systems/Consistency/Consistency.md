# CSE452: Consistency

A **consistency model** is a contract between a distributed system and the programmer. It answers the question: *What executions of a replicated state machine are correct?* This file is the navigation hub for all consistency topics — each subtopic is covered in depth in its own file.

## Core Topics

### [[Theoretical Foundations|Theoretical Foundations]]
The mathematical laws and trade-offs of distributed systems.
- **Strength Hierarchy**: From Strict to Eventual consistency.
- **[[Theoretical Foundations#2. The CAP Theorem|CAP Theorem]]**: The trade-off between Consistency, Availability, and Partition Tolerance.
- **[[Theoretical Foundations#3. The PACELC Theorem|PACELC Theorem]]**: Latency vs. Consistency during normal operation.
- **Quorums and Split Brain**: How majority voting maintains integrity.

### [[Strong Consistency Models|Strong Consistency Models]]
The "gold standard" of consistency where the system behaves like a single sequential machine.
- **[[Linearizability|Linearizability]]**: Real-time ordering and atomic visibility.
- **[[Strong Consistency Models#3. Sequential Consistency|Sequential Consistency]]**: Total ordering respecting program order.
- **Proofs**: Linearization points and precedence graphs.

### [[Weak Consistency Models|Weak Consistency Models]]
High-performance models that allow divergence for the sake of availability.
- **[[Weak Consistency Models#Eventual Consistency|Eventual Consistency]]**: Convergence over time.
- **[[Weak Consistency Models#Causal Consistency|Causal Consistency]]**: Tracking happens-before dependencies.
- **Conflict Resolution**: Last-Writer-Wins (LWW) and its risks.
- **[[Weak Consistency Models#4. Conflict-Free Replicated Data Type (CRDT)|CRDTs]]**: G-Counters, PN-Counters, and commutative merge operations.

### [[Architectural Consistency|Architectural Consistency]]
Physical implementations of consistency in hardware and caching.
- **[[Architectural Consistency#Memory Consistency Model (MCM)|Memory Consistency]]**: x86-64 TSO and Acquire/Release semantics.
- **Distributed Cache Coherence**: Write-through, directory-based invalidation, and timed leases.

### [[Fast Reads in Multi-Paxos|Fast Reads in Multi-Paxos]]
Optimizations that trade consistency for read latency in [[Multi-Paxos|Multi-Paxos]].
- **Snapshot Reads**: Stale but consistent-prefix reads with per-client monotonicity.
- **Eventually Consistent Reads**: The weakest, fully local read model.

---

## Glossary of Models
Definitions are inlined within their respective topic files for better context:
- [[Theoretical Foundations#Strict Consistency|Strict Consistency]]
- [[Linearizability|Linearizability]]
- [[Strong Consistency Models#3. Sequential Consistency|Sequential Consistency]]
- [[Weak Consistency Models#Causal Consistency|Causal Consistency]]
- [[Weak Consistency Models#FIFO (PRAM) Consistency|FIFO (PRAM) Consistency]]
- [[Weak Consistency Models#Processor Consistency|Processor Consistency]]
- [[Weak Consistency Models#Eventual Consistency|Eventual Consistency]]
- [[Theoretical Foundations#2. The CAP Theorem|CAP Theorem]]
- [[Theoretical Foundations#3. The PACELC Theorem|PACELC Theorem]]
- [[Architectural Consistency#Memory Consistency Model (MCM)|Memory Consistency Model (MCM)]]

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Consistency Model** | Consistency contract / data-store guarantee |
| **Strength Hierarchy** | Consistency-model lattice |

---

## Related
- [[Logical Clocks|Logical Clocks]] — the happens-before relation underlying causal consistency
- [[Paxos|Paxos Consensus]] — the protocol that implements strong consistency
- [[Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — the communication layer beneath any consistency model
