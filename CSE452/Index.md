# CSE452 — Distributed Systems

Principles of building correct and fault-tolerant distributed systems.

---

## Topics

### Foundations
- [[CSE452/RPC/Introduction to DS|Introduction to Distributed Systems]] — what a DS is, why build one, fundamental challenges (coherence, partial failures, concurrency)
- [[CSE452/RPC/Fault Model|Fault Model]] — catalog of failures to plan for: crashes, dropped/delayed/duplicate messages

### Remote Procedure Call
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — protocol definition, request/response mechanics, sequence numbers, at-least-once / at-most-once / exactly-once semantics

### Replication
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — the formal model: same commands in same order → same state on all replicas
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — primary orders requests, backup executes, view server tracks roles, state transfer, split brain
- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — the six correctness rules governing message ordering, view acceptance, and state transfer
- [[CSE452/Primary-Backup/State Machine Replication (State Transfer)|State Transfer]] — copying full application state to a new backup, idempotence, and serialization with client requests
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — detecting failure and transferring roles between nodes
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why some operations are safe to repeat and others are not
- [[CSE452/Primary-Backup/Why not just use TCP|Why Not Just Use TCP]] — TCP's limitations under failures

---

## Related Courses
- [[CSE461/CSE461 Index|CSE461 — Computer Networks]] — networking fundamentals underlying distributed systems
- [[CSE444/Index|CSE444 — Advanced Database Systems]] — distributed databases, replication in the database context
- [[CSE451/CSE451 Index|CSE451 — Operating Systems]] — concurrency primitives, synchronization
