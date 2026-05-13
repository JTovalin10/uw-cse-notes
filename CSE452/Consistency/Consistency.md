# CSE452: Consistency

A **consistency model** is a contract between a distributed system and the programmer. It answers the question: *What executions of a replicated state machine are correct?*

## Core Topics

### [[CSE452/Consistency/Theoretical Foundations|Theoretical Foundations]]
The mathematical laws and trade-offs of distributed systems.
- **Strength Hierarchy**: From Strict to Eventual consistency.
- **[[CSE452/Consistency/Theoretical Foundations#The CAP Theorem|CAP Theorem]]**: The trade-off between Consistency, Availability, and Partition Tolerance.
- **[[CSE452/Consistency/Theoretical Foundations#The PACELC Theorem|PACELC Theorem]]**: Latency vs. Consistency during normal operation.
- **Quorums and Split Brain**: How majority voting maintains integrity.

### [[CSE452/Consistency/Strong Consistency Models|Strong Consistency Models]]
The "gold standard" of consistency where the system behaves like a single sequential machine.
- **[[CSE452/Consistency/Definitions/Linearizability|Linearizability]]**: Real-time ordering and atomic visibility.
- **[[CSE452/Consistency/Strong Consistency Models#Sequential Consistency|Sequential Consistency]]**: Total ordering respecting program order.
- **Proofs**: Linearization points and precedence graphs.

### [[CSE452/Consistency/Weak Consistency Models|Weak Consistency Models]]
High-performance models that allow divergence for the sake of availability.
- **[[CSE452/Consistency/Weak Consistency Models#Eventual Consistency|Eventual Consistency]]**: Convergence over time.
- **[[CSE452/Consistency/Weak Consistency Models#Causal Consistency|Causal Consistency]]**: Tracking happens-before dependencies.
- **Conflict Resolution**: Last-Writer-Wins (LWW) and its risks.
- **[[CSE452/Consistency/Weak Consistency Models#Conflict-Free Replicated Data Type (CRDT)|CRDTs]]**: G-Counters, PN-Counters, and commutative merge operations.

### [[CSE452/Consistency/Architectural Consistency|Architectural Consistency]]
Physical implementations of consistency in hardware and caching.
- **[[CSE452/Consistency/Architectural Consistency#Memory Consistency Model (MCM)|Memory Consistency]]**: x86-64 TSO and Acquire/Release semantics.
- **Distributed Cache Coherence**: Write-through, directory-based invalidation, and timed leases.

---

## Glossary of Models
Definitions are now inlined within their respective topic files for better context:
- [[CSE452/Consistency/Theoretical Foundations#Strict Consistency|Strict Consistency]]
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]]
- [[CSE452/Consistency/Strong Consistency Models#Sequential Consistency|Sequential Consistency]]
- [[CSE452/Consistency/Weak Consistency Models#Causal Consistency|Causal Consistency]]
- [[CSE452/Consistency/Weak Consistency Models#FIFO (PRAM) Consistency|FIFO (PRAM) Consistency]]
- [[CSE452/Consistency/Weak Consistency Models#Processor Consistency|Processor Consistency]]
- [[CSE452/Consistency/Weak Consistency Models#Eventual Consistency|Eventual Consistency]]
- [[CSE452/Consistency/Theoretical Foundations#The CAP Theorem|CAP Theorem]]
- [[CSE452/Consistency/Theoretical Foundations#The PACELC Theorem|PACELC Theorem]]
- [[CSE452/Consistency/Architectural Consistency#Memory Consistency Model (MCM)|Memory Consistency Model (MCM)]]

---

## Related
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]]
- [[CSE452/Paxos/Paxos|Paxos Consensus]]
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]]
