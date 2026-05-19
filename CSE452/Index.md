# CSE452 — Distributed Systems

Principles of building correct and fault-tolerant distributed systems.

---

## Topics

### Foundations
- [[CSE452/RPC/Introduction to DS|Introduction to Distributed Systems]] — what a DS is, why build one, fundamental challenges (coherence, partial failures, concurrency)
- [[CSE452/RPC/Fault Model|Fault Model]] — catalog of failures to plan for: crashes, dropped/delayed/duplicate messages; fail-stop vs. Byzantine
- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — happens-before relation, concurrent events, partial ordering of events
- [[CSE452/Clocks/Lamport Clock Algorithm|Lamport Clock Algorithm]] — logical timestamps and the clock condition
- [[CSE452/Clocks/Vector Clock Algorithm|Vector Clock Algorithm]] — capturing causality and detecting concurrent events
- [[CSE452/Clocks/Vector Clock Pruning|Vector Clock Pruning]] — scalability trade-offs and loss of precision when truncating vector clocks
- [[CSE452/Clocks/System State|System State]] — stable/unstable properties, invariants, and correctness proofs in primary-backup
- [[CSE452/Knowledge/Knowledge|Knowledge in Distributed Systems]] — individual/common/distributed knowledge, muddy foreheads puzzle, impossibility of coordinated attack, consensus and FLP

### Consistency
- [[CSE452/Consistency/Consistency|Consistency]] — the core contract and navigation hub linking to all consistency models
- [[CSE452/Consistency/Theoretical Foundations|Theoretical Foundations]] — the strength hierarchy, CAP Theorem, PACELC Theorem, quorums, and split brain
- [[CSE452/Consistency/Strong Consistency Models|Strong Consistency Models]] — linearizability, sequential consistency, total ordering, and proofs
- [[CSE452/Consistency/Weak Consistency Models|Weak Consistency Models]] — eventual/causal/FIFO consistency, LWW, and CRDTs
- [[CSE452/Consistency/Architectural Consistency|Architectural Consistency]] — hardware memory models (TSO), distributed cache coherence, and leases
- [[CSE452/Consistency/Definitions/Linearizability|Linearizability]] — the strongest single-object consistency model
- [[CSE452/Consistency/Fast Reads in Multi-Paxos|Fast Reads in Multi-Paxos]] — snapshot reads and eventually consistent reads as read-latency optimizations

### Remote Procedure Call
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — protocol definition, request/response mechanics, sequence numbers, at-least-once / at-most-once / exactly-once semantics

### Replication
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — the formal model: same commands in same order → same state on all replicas
- [[CSE452/Primary-Backup/Primary Backup|Primary Backup Replication]] — primary orders requests, backup executes, view server tracks roles, state transfer, split brain
- [[CSE452/Primary-Backup/View Server|View Server]] — single source of truth for current view; ping-based failure detection, view transitions, ACK requirement
- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — the six correctness rules governing message ordering, view acceptance, and state transfer
- [[CSE452/Primary-Backup/State Machine Replication (State Transfer)|State Transfer]] — copying full application state to a new backup, idempotence, and serialization with client requests
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — detecting failure and transferring roles between nodes
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why some operations are safe to repeat and others are not
- [[CSE452/Primary-Backup/Why Not Just Use TCP|Why Not Just Use TCP]] — TCP's limitations under failures

### Consensus (Paxos)
- [[CSE452/Paxos/Paxos|Paxos Overview]] — reaching consensus in a distributed system with faulty nodes
- [[CSE452/Paxos/Single Paxos|Single Decree Paxos]] — the core algorithm for reaching agreement on one value
- [[CSE452/Paxos/Single-PaxosComponents/Roles|Paxos Roles]] — Proposer, Acceptor, and Learner
- [[CSE452/Paxos/Single-PaxosComponents/Protocol|The Paxos Protocol]] — the step-by-step 1a/1b/2a/2b message logic
- [[CSE452/Paxos/Single-PaxosComponents/Majority Overlap|Majority Overlap]] — why Phase 1 needs a majority
- [[CSE452/Paxos/Single-PaxosComponents/Safety and Scenarios|Safety and Scenarios]] — what "chosen" means and worked safety scenarios
- [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] — building a replicated state machine using a sequence of Paxos instances
- [[CSE452/Paxos/Multi-PaxosComponents/Leader Election|Multi-Paxos Leader Election]] — steady-state mechanics, leases, and rejection logic
- [[CSE452/Paxos/Multi-PaxosComponents/Log|Multi-Paxos Log]] — slot pointers, log merging, garbage collection, and snapshots
- [[CSE452/Paxos/Multi-PaxosComponents/Failure Detection|Multi-Paxos Failure Detection]] — heartbeat mechanics and election timers
- [[CSE452/Paxos/Multi-PaxosComponents/Holes in the Log|Holes in the Log]] — proposing No-Ops to fill gaps left by a failed leader
- [[CSE452/Paxos/Paxos Invariants|Paxos Invariants and Design]] — safety properties and the design principles of the Paxos protocol
- [[CSE452/Paxos/Ballot IDs|Paxos Ballot IDs]] — the role of proposal numbers in ensuring progress and safety

### Scalability
- [[CSE452/Sharding/Sharding|Sharding]] — horizontal scaling, ShardMaster architecture, linearizable handovers, and cross-group transactions
- [[CSE452/Sharding/Shard Master|Shard Master]] — Join/Leave/Move/Query operations and the deterministic rebalancing algorithm
- [[CSE452/Sharding/Sharded Key-Value Server|Sharded Key-Value Server]] — ShardStoreServer internals, the inside-out Paxos sub-node pattern, and client routing
- [[CSE452/Sharding/Reconfiguration|Reconfiguration]] — the shard handoff protocol, AMO state transfer, and in-order processing
- [[CSE452/Sharding/Transactions|Transactions (2PC)]] — Two-Phase Commit protocol, distributed locking, deadlock avoidance, and reconfiguration interactions
- [[CSE452/Sharding/Two-Phase Commit|Two-Phase Commit: Motivation]] — the naive swap protocol, its five failure modes, and why 2PC is the fix

### Sharding Definitions
- [[CSE452/Sharding/Definitions/Shard|Shard]] — the unit of partitioning
- [[CSE452/Sharding/Definitions/Replica Group|Replica Group]] — a fault-tolerant cluster serving a set of shards
- [[CSE452/Sharding/Definitions/ShardMaster|ShardMaster]] — the fault-tolerant configuration metadata service
- [[CSE452/Sharding/Definitions/Configuration|Configuration]] — the numbered shard-to-group mapping metadata

### Case Studies
- [[CSE452/Case Studies/Big Table|Big Table]] — Google's structured-data storage system: the Google stack, the 3D data model, tablets/SSTables/memtable, and the append-only tablet log
- [[CSE452/Case Studies/Reading Papers|Reading Papers]] — how to approach the research papers studied in this course

---

## Related Courses
- [[CSE461/CSE461 Index|CSE461 — Computer Networks]] — networking fundamentals underlying distributed systems
- [[CSE444/Index|CSE444 — Advanced Database Systems]] — distributed databases, replication in the database context
- [[CSE451/CSE451 Index|CSE451 — Operating Systems]] — concurrency primitives, synchronization
