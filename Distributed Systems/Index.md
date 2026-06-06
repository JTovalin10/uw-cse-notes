# CSE452 — Distributed Systems

Principles of building correct and fault-tolerant distributed systems.

---

## Topics

### Foundations
- [[Introduction to DS|Introduction to Distributed Systems]] — what a DS is, why build one, fundamental challenges (coherence, partial failures, concurrency)
- [[Fault Model|Fault Model]] — catalog of failures to plan for: crashes, dropped/delayed/duplicate messages; fail-stop vs. Byzantine
- [[Logical Clocks|Logical Clocks]] — happens-before relation, concurrent events, partial ordering of events
- [[Lamport Clock Algorithm|Lamport Clock Algorithm]] — logical timestamps and the clock condition
- [[Vector Clock Algorithm|Vector Clock Algorithm]] — capturing causality and detecting concurrent events
- [[Vector Clock Pruning|Vector Clock Pruning]] — scalability trade-offs and loss of precision when truncating vector clocks
- [[System State|System State]] — stable/unstable properties, invariants, and correctness proofs in primary-backup
- [[Knowledge|Knowledge in Distributed Systems]] — individual/common/distributed knowledge, muddy foreheads puzzle, impossibility of coordinated attack, consensus and FLP

### Consistency
- [[Consistency|Consistency]] — the core contract and navigation hub linking to all consistency models
- [[Theoretical Foundations|Theoretical Foundations]] — the strength hierarchy, CAP Theorem, PACELC Theorem, quorums, and split brain
- [[Strong Consistency Models|Strong Consistency Models]] — linearizability, sequential consistency, total ordering, and proofs
- [[Weak Consistency Models|Weak Consistency Models]] — eventual/causal/FIFO consistency, LWW, and CRDTs
- [[Architectural Consistency|Architectural Consistency]] — hardware memory models (TSO), distributed cache coherence, and leases
- [[Linearizability|Linearizability]] — the strongest single-object consistency model
- [[Fast Reads in Multi-Paxos|Fast Reads in Multi-Paxos]] — snapshot reads and eventually consistent reads as read-latency optimizations

### Remote Procedure Call
- [[Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — protocol definition, request/response mechanics, sequence numbers, at-least-once / at-most-once / exactly-once semantics

### Replication
- [[Deterministic State Machine|Deterministic State Machine]] — the formal model: same commands in same order → same state on all replicas
- [[Primary Backup|Primary Backup Replication]] — primary orders requests, backup executes, view server tracks roles, state transfer, split brain
- [[View Server|View Server]] — single source of truth for current view; ping-based failure detection, view transitions, ACK requirement
- [[Six Rules of Primary Backup|Six Rules of Primary-Backup]] — the six correctness rules governing message ordering, view acceptance, and state transfer
- [[State Machine Replication (State Transfer)|State Transfer]] — copying full application state to a new backup, idempotence, and serialization with client requests
- [[Failover Protocol|Failover Protocol]] — detecting failure and transferring roles between nodes
- [[Idempotence|Idempotence]] — why some operations are safe to repeat and others are not
- [[Why Not Just Use TCP|Why Not Just Use TCP]] — TCP's limitations under failures

### Consensus (Paxos)
- [[Paxos|Paxos Overview]] — reaching consensus in a distributed system with faulty nodes
- [[Single Paxos|Single Decree Paxos]] — the core algorithm for reaching agreement on one value
- [[Roles|Paxos Roles]] — Proposer, Acceptor, and Learner
- [[Protocol|The Paxos Protocol]] — the step-by-step 1a/1b/2a/2b message logic
- [[Majority Overlap|Majority Overlap]] — why Phase 1 needs a majority
- [[Safety and Scenarios|Safety and Scenarios]] — what "chosen" means and worked safety scenarios
- [[Multi-Paxos|Multi-Paxos]] — building a replicated state machine using a sequence of Paxos instances
- [[Leader Election|Multi-Paxos Leader Election]] — steady-state mechanics, leases, and rejection logic
- [[Log|Multi-Paxos Log]] — slot pointers, log merging, garbage collection, and snapshots
- [[Failure Detection|Multi-Paxos Failure Detection]] — heartbeat mechanics and election timers
- [[Holes in the Log|Holes in the Log]] — proposing No-Ops to fill gaps left by a failed leader
- [[Paxos Invariants|Paxos Invariants and Design]] — safety properties and the design principles of the Paxos protocol
- [[Ballot IDs|Paxos Ballot IDs]] — the role of proposal numbers in ensuring progress and safety

### Scalability
- [[Sharding|Sharding]] — horizontal scaling, ShardMaster architecture, linearizable handovers, and cross-group transactions
- [[Shard Master|Shard Master]] — Join/Leave/Move/Query operations and the deterministic rebalancing algorithm
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — ShardStoreServer internals, the inside-out Paxos sub-node pattern, and client routing
- [[Reconfiguration|Reconfiguration]] — the shard handoff protocol, AMO state transfer, and in-order processing
- [[Transactions|Transactions (2PC)]] — hub linking all Two-Phase Commit components
- [[Two-Phase Commit|Two-Phase Commit: Motivation]] — the naive swap protocol, its five failure modes, and why 2PC is the fix
- [[Phases and Roles|2PC Phases and Roles]] — coordinator/participant roles, Phase 1/2 mechanics, reconfiguration interactions
- [[Locking and Deadlock|2PC Locking and Deadlock]] — read/write locks, abort-on-conflict, retry differentiation
- [[Vanilla 2PC vs Paxos Commit|Vanilla 2PC vs Paxos Commit]] — the blocking problem and how Paxos Commit solves it
- [[Log Operations|2PC Log Operations]] — the six log entry types (BEGIN, LOCK, PREPARE-COMMIT, COMMIT, ABORT) with semantics
- [[MultiPut Walkthrough|2PC MultiPut Walkthrough]] — step-by-step trace of a successful cross-group MultiPut
- [[Failure Scenarios|2PC Failure Scenarios]] — lock contention (PrepareNotOK) and coordinator timeout with log traces

### Sharding Definitions
- [[Shard|Shard]] — the unit of partitioning
- [[Replica Group|Replica Group]] — a fault-tolerant cluster serving a set of shards
- [[ShardMaster|ShardMaster]] — the fault-tolerant configuration metadata service
- [[Configuration|Configuration]] — the numbered shard-to-group mapping metadata

### Case Studies
- [[Key Takeaways|Key Takeaways in Performance and Durability]] — summary of recurring strategies for building high-performance, durable distributed systems
- [[Google File System (GFS)|Google File System (GFS)]] — a scalable distributed file system for large data-intensive applications
- [[MapReduce|MapReduce]] — a data-parallel programming model (map + reduce) for large datasets: the mapping, shuffle, and reduce/output phases, with the GFS locality optimization
- [[Big Table|Big Table]] — Google's structured-data storage system: the Google stack, the 3D data model, tablets/SSTables/memtable, and the append-only tablet log
- [[Dynamo|Dynamo]] — Amazon's highly available, eventually consistent key-value store
- [[Bitcoin|Bitcoin]] — a peer-to-peer electronic cash system that solves double-spending with proof-of-work and a decentralized timestamp server
- [[Case Studies/TensorFlow|TensorFlow]] — Google's distributed ML framework: dataflow graphs, compute-bound training, GPU data parallelism, and weak-consistency fault tolerance
- [[Reading Papers|Reading Papers]] — how to approach the research papers studied in this course

---

## Related Courses
- [[CSE461 Index|CSE461 — Computer Networks]] — networking fundamentals underlying distributed systems
- [[Database Internals/Index|CSE444 — Advanced Database Systems]] — distributed databases, replication in the database context
- [[CSE451 Index|CSE451 — Operating Systems]] — concurrency primitives, synchronization
