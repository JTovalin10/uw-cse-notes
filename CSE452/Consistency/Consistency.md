# CSE452: Consistency

A **consistency model** is a contract between a distributed system and the programmer. It answers the question: *What executions of a replicated state machine are correct?*

## The Core Concept
Consistency is a predicate $f(\text{execution}) \rightarrow \{\text{True, False}\}$. It defines which observed results are legal under the promised semantics. Without a consistency model, a programmer cannot reason about the correctness of their concurrent or distributed code.

## 1. Categories of Consistency
This is a breakdown based on **where** the consistency is enforced and the architecture involved.

### [[CSE452/Consistency/Memory Consistency|Memory Consistency]] (The Foundation)
The contract between the hardware (CPU/RAM) and the software.
- **Problem**: Out-of-Order execution by hardware.
- **Solution**: Memory Barriers (Fences) and TSO.

### [[CSE452/Consistency/Linearizability and Sequential Consistency|Distributed Consistency]] (The Global)
The contract between multiple replicated nodes across a network.
- **Strong Models**: [[CSE452/Consistency/Definitions/Linearizability|Linearizability]], [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential Consistency]].
- **Weak Models**: [[CSE452/Consistency/Definitions/Causal Consistency|Causal]], [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual]].

### [[CSE452/Consistency/CAP Theorem and Partitions|Theoretical Limits]] (The Laws)
The mathematical trade-offs required by any distributed system.
- **CAP Theorem**: Consistency vs. Availability during partitions.
- **PACELC**: Latency vs. Consistency during normal operation.

---

## 2. The Strength Hierarchy
The "Strength" of a model is defined by the set of legal executions it allows. A **Stronger** model is a **Subset** of a **Weaker** model.

$$\text{Strict} \subset \text{Linearizable} \subset \text{Sequential} \subset \text{Causal} \subset \text{FIFO} \subset \text{Eventual}$$

- **Strong Models (Left)**: ([[CSE452/Consistency/Definitions/Strict Consistency|Strict]], [[CSE452/Consistency/Definitions/Linearizability|Linearizable]], [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential]]) Provide the most guarantees but have the highest latency and lowest availability.
- **Weak Models (Right)**: ([[CSE452/Consistency/Definitions/Causal Consistency|Causal]], [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO]], [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual]]) Provide fewer guarantees but offer the highest performance and "always-on" availability.

---

## Why This Matters
As a distributed systems engineer, you are constantly deciding: **Is it better to be wrong (AP/Weak) or silent (CP/Strong)?**
- **[[CSE452/Consistency/Linearizability and Sequential Consistency|Strong Consistency]]**: Easy to program, but high latency and low availability.
- **[[CSE452/Consistency/Definitions/Eventual Consistency|Weak/Eventual Consistency]]**: High performance and availability, but the programmer must handle data conflicts and "stale" reads manually.

---

## Glossary of Consistency Models
These **models** are the specific technical "contracts" or rulesets that define legal system behavior:
- [[CSE452/Consistency/Definitions/Strict Consistency|Strict Consistency]] — The theoretical ideal.
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] — Strongest practical model.
- [[CSE452/Consistency/Definitions/Sequential Consistency|Sequential Consistency]] — Total order, no real-time.
- [[CSE452/Consistency/Definitions/Causal Consistency|Causal Consistency]] — Happens-before tracking.
- [[CSE452/Consistency/Definitions/FIFO Consistency|FIFO / PRAM Consistency]] — Per-process ordering.
- [[CSE452/Consistency/Definitions/Processor Consistency|Processor Consistency]] — Weakest ordering model.
- [[CSE452/Consistency/Definitions/Eventual Consistency|Eventual Consistency]] — Convergence over time.
- [[CSE452/Consistency/Definitions/CAP Theorem|CAP Theorem]] — Availability trade-off.
- [[CSE452/Consistency/Definitions/PACELC Theorem|PACELC Theorem]] — Latency trade-off.

## Related
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — establishing "Happens-Before"
- [[CSE452/Paxos/Paxos|Paxos]] — implementing strong consistency
