# CSE452: Time and Virtual Clocks

## Time in Distributed Systems

In a distributed system, **time** answers the question: *when are things true?* Unlike a single machine where a global clock ticks, distributed systems have no shared clock — each machine has its own local clock that drifts at its own rate. This makes reasoning about ordering and simultaneity a fundamental challenge.

---

## Simultaneity and Event Ordering

### The Happens-Before Relation

In distributed systems, we cannot rely on physical clocks to determine the order of events across machines. Instead, we use the **happens-before** relation, written $e_1 \rightarrow e_2$, which captures causality.

$e_1$ happens before (doesnt mean the english meaning) $e_2$ ($e_1 \rightarrow e_2$) if any of the following hold:
1. $e_1$ and $e_2$ occur on the **same machine**, and $e_1$ occurs first in that machine's local execution order
2. $e_1$ is the **sending** of a message and $e_2$ is the **receipt** of that same message
3. **Transitivity**: there exists some $e_3$ such that $e_1 \rightarrow e_3$ and $e_3 \rightarrow e_2$

The happens-before relation is a **partial order** — it is irreflexive, asymmetric, and transitive, but not every pair of events is ordered.

### Concurrent Events

Two events $e_1$ and $e_2$ are **concurrent** (written $e_1 \parallel e_2$) if neither happens before the other:

$$e_1 \parallel e_2 \iff \neg(e_1 \rightarrow e_2) \land \neg(e_2 \rightarrow e_1)$$

Concurrent events have no causal relationship — neither influenced the other. The system cannot determine which occurred "first" in any meaningful sense.

**Why this matters**: when two events are concurrent, any ordering assigned to them is arbitrary. Distributed protocols must either avoid conflicts between concurrent events (e.g., by locking) or be designed to tolerate them (e.g., eventual consistency).



---

## Related

- [[CSE452/Clocks/System State|System State]] — stable/unstable properties, invariants, and correctness proofs in primary-backup
- [[CSE452/Clocks/Virtual + Vector Clocks|Virtual and Vector Clocks]] — Lamport clock algorithm, logical timestamps, clock condition
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — invariants used to prove correctness of primary-backup
- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — each rule maintains a key invariant about system state
- [[CSE452/Primary-Backup/View Server|View Server]] — view transitions and invariants about which servers are alive
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — message ordering and sequence numbers connect to happens-before reasoning
- [[CSE452/RPC/Fault Model|Fault Model]] — dropped/delayed messages affect happens-before ordering across machines
