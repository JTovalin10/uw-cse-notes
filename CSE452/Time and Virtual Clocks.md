# CSE452: Time and Virtual Clocks

## Time in Distributed Systems

In a distributed system, **time** answers the question: *when are things true?* Unlike a single machine where a global clock ticks, distributed systems have no shared clock — each machine has its own local clock that drifts at its own rate. This makes reasoning about ordering and simultaneity a fundamental challenge.

---

## Properties of System State

### Invariants

An **invariant** is a property that is always true throughout every execution of the system. All invariants are stable properties (see below).

Examples from Primary-Backup:
- A client has at most one outstanding request at a time (a request is sent but no reply has been received, tracked using the client's sequence number)
- The sequence number saved by the server for each client is **monotonically increasing** (per client)
- All request messages in the network have a sequence number at most 1 greater than the server's saved sequence number for that client
- After state transfer completes in a given view, the backup has all the state the primary has — specifically, in the highest-numbered view the system has been in
  - With view changes you can arrive at another view number with the same backup and primary
- If the view server is in view $n+1$, then the primary of view $n$ completed state transfer in view $n$
  - If the system is not in view $n+1$, this is vacuously true (the antecedent is false)

### Stable Properties

A **stable property** is one that, once true, remains true for the rest of the execution. Formally, it is an implication:

$$p \rightarrow q$$

where $p$ being false makes the statement vacuously true — a property that hasn't become true yet is not violated. The key constraint is: a stable property **cannot go from true to false**.

Examples:
- Once a client ID is in the server's AMO (At-Most-Once) table, it stays there forever
- The client `c` is in the server's AMO application state
- There is a primary in the View Server's current (highest) view
- Once a server actually dies (not just the View Server's belief about it), it does not come back

### Unstable Properties

An **unstable property** is one that can become false after being true.

Example:
- "View $V$ has a backup" — whether this is stable or unstable depends on precise definition:
  - "View $V$ ever had a backup" is stable (once true, always true — views are immutable records)
  - "The current view has a backup" is unstable (the backup can fail, removing it from the current view)

The distinction matters when writing correctness proofs: you can always rely on stable properties once established, but must re-check unstable ones.

---

## Simultaneity and Event Ordering

### The Happens-Before Relation

In distributed systems, we cannot rely on physical clocks to determine the order of events across machines. Instead, we use the **happens-before** relation, written $e_1 \rightarrow e_2$, which captures causality.

$e_1$ happens before $e_2$ ($e_1 \rightarrow e_2$) if any of the following hold:
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

- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — invariants used to prove correctness of primary-backup
- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — each rule maintains a key invariant about system state
- [[CSE452/Primary-Backup/View Server|View Server]] — view transitions and invariants about which servers are alive
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — message ordering and sequence numbers connect to happens-before reasoning
- [[CSE452/RPC/Fault Model|Fault Model]] — dropped/delayed messages affect happens-before ordering across machines
