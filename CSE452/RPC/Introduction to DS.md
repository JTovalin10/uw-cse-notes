# CSE452: Introduction to Distributed Systems

## What is a Distributed System?

A **distributed system (DS)** is:
1. Multiple machines working together
   - Introduces **concurrency** across machines
2. Connected by a network
3. Designed to be **fault tolerant** — the system continues operating correctly despite individual component failures

## Why Build a Distributed System?

- **Horizontal scaling**: add more computers to handle more load
- **Vertical scaling**: make a single computer more powerful (limited and expensive)
- **Redundancy / Replication (Fault Tolerance)**: multiple machines keep copies of the same data — if one fails, another can take over
- **Performance**: place data and computation near users; use [[CSE461/Application/Caching|caching]] to reduce latency

## How Hard is it to Build a Distributed System?

Building a correct DS is fundamentally difficult:

- **Coherence**: maintaining consistent state across replicas is hard — updates must be propagated correctly to all copies
- **Partial failures**: individual machines or network links can fail independently while the rest of the system keeps running; you must accept that failure is normal
- **Concurrency**: multiple machines operate concurrently, making coordination and ordering problems unavoidable

---

## Related
- [[CSE452/RPC/Fault Model|Fault Model]] — catalog of failures a DS must tolerate
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — how machines communicate across a network
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — one approach to fault-tolerant state replication
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — formal model underlying replication
