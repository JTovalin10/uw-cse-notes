# Distributed Systems: Course Summary

## Why Build a Distributed System

- **Reliability** — make unreliable components reliable via replication: [[Distributed Systems/Primary-Backup/Primary Backup|primary-backup]], [[Distributed Systems/Paxos/Paxos|Paxos]]
- **Performance / throughput** — partitioning via [[Distributed Systems/Sharding/Sharding|sharding]]

## Challenges

- **Correctness** — edge cases kill you
  - Think in terms of events and the order in which messages arrive; make no assumptions about ordering
  - Look for testing strategies that simulate the network in a controlled way to explore different flows of execution
- **Partial failure** — individual machines or network links can fail while the rest of the system keeps running; you must accept that failure is normal
- **Concurrency** — multiple machines operate concurrently, making coordination and ordering problems unavoidable

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Replication** | Redundancy / high availability |
| **Partitioning / Sharding** | Horizontal partitioning / data sharding |
| **Partial Failure** | Independent component failure |

---

## Related

- [[Distributed Systems/RPC/Introduction to DS|Introduction to Distributed Systems]] — the broader context of why distributed systems are hard
- [[Distributed Systems/RPC/Fault Model|Fault Model]] — the formal catalog of failures
- [[Distributed Systems/Paxos/Paxos|Paxos]] — consensus to tolerate failures
- [[Distributed Systems/Sharding/Sharding|Sharding]] — partitioning for performance
