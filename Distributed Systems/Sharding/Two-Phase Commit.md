# Distributed Systems: Two-Phase Commit

## Multi-Key Transaction Motivation

The problem 2PC solves begins with the structure of a **sharded key-value store**: the store is partitioned across many **[[Sharding|shards]]**, each managed by its own [[Multi-Paxos|Paxos group]]. This design scales writes horizontally — each group handles its shard independently. However, a transaction that touches keys on multiple different shards cannot be handled by any single group acting alone.

Consider a meeting scheduler: three schedules — Tom's, Mike's, and Zack's — may live on different shards. The client must atomically book all three at 11am or book none. If only two succeed, the data is inconsistent.

```
x = get(tom's schedule)
y = get(mike's schedule)
z = get(zack's schedule)
if (x.freeAt(11) && y.freeAt(11) && z.freeAt(11)) {
    put(tom's schedule, x.busy(11))
    put(mike's schedule, y.busy(11))
    put(zack's schedule, z.busy(11))
}
```

The application logic runs on the **client**. The client issues RPCs to the storage layer to start/end the transaction and perform read/write (put/get) operations. The KV store acquires and releases locks and executes the put/get operations — the store stays simple and application logic can change without modifying the storage layer.

Two cases arise:
- **Simple case**: all keys on the same shard (same Paxos group) — the group handles the transaction entirely by itself.
- **More complicated case**: keys on different shards (different Paxos groups) — this is where Two-Phase Commit is necessary.

---

## Single-Shard Transaction Walkthrough

Before the cross-group case, consider the single-shard case where all keys belong to one Paxos group. The Leader handles the entire transaction; the Acceptors Paxos-replicate each log entry so the transaction is durable across failures.

**Example**: A bank transfer — move $100 from checking to savings (both on the same shard).

```
x = read(checking_bal)
if (x > 100) {
    y = read(savings_bal)
    write(checking_bal, x - 100)
    write(savings_bal, y + 100)
}
```

As the client issues RPCs, the Leader appends entries to the Paxos log and replicates them to the Acceptors before acting:

```
LOG:
  1. A: Transaction start
  2. A: Lock(R, checking_bal)        ← read lock acquired on first read
  3. A: Lock(R, savings_bal)         ← read lock acquired on second read
  4. A: Lock(W, checking_bal)        ← upgrade to write lock
  5. A: Write(checking_bal, 100)     ← stage tentative value
  6. A: Lock(W, savings_bal)         ← write lock on second key
  7. A: Write(savings_bal, 100)      ← stage tentative value
  8. A: Commit                       ← make all writes durable
  9. A: Unlock(checking_bal)
 10. A: Unlock(savings_bal)
```

Each entry is Paxos-replicated to the Acceptors before execution. This means that even if the Leader fails mid-transaction, a new Leader can reconstruct the exact transaction state from the log and either complete or abort it correctly.

Three complications arise even within a single shard:

- **Leader failure**: A new leader must be elected. The Acceptors have a prefix of the log but may be behind — the new leader must drive in-flight entries to chosen before resuming.
- **Concurrent transactions**: Other transactions may be running simultaneously. Every lock acquisition must check compatibility against all currently held locks.
- **Partial replication at Acceptors**: Some log entries may be known to the leader but not yet replicated to a majority. A recovering leader must catch these up before making new progress.

---

## ShardStore and Paxos Architecture

![[ShardStore and PaxosServer.png]]

A core constraint of the **[[Sharded Key-Value Server|ShardStoreServer]]** is that no server may communicate directly with another ShardStoreServer without first obtaining consensus from its own [[Multi-Paxos|PaxosServer]] sub-node. This enforces the invariant that the Paxos log is the single source of truth for all state changes — a server that acts on its own risks diverging from the rest of the group.

Every operation is executed in two steps:

1. **Get consensus**: Propose the operation to the local Paxos layer and wait for it to be **CHOSEN**.
2. **Execute**: Once the operation is CHOSEN in the log, execute it on the ShardStoreServer's local state.

### Inside-Out Paxos Application

The ShardStoreServer is an **inside-out Paxos application**. In a standard AMO setup, Paxos sits below the application and the application is an `AMOApplication`. Here, the relationship is inverted: the ShardStoreServer owns the Paxos sub-node and uses it internally to decide what operations to run on itself.

- The **ShardStoreServer is not an `AMOApplication`**. Its state lives directly in the fields of the `ShardStoreServer` class, not inside an AMO wrapper.
- When an operation arrives, the server checks the Paxos log:
  - If the slot is already **CHOSEN**, execute the operation.
  - If not yet chosen, insert the operation into the log and drive it to CHOSEN.
  - If the operation was already executed, calling the method again returns the cached CHOSEN result.

```mermaid
sequenceDiagram
    participant C as Client
    participant SS as ShardStoreServer
    participant P as PaxosServer (sub-node)

    C->>SS: RPC (e.g., Put / Get / Swap)
    SS->>P: Propose command to Paxos log
    P-->>SS: Notify: CHOSEN at slot N
    SS->>SS: Execute operation on local state
    SS-->>C: Return result
```

---

## Cross-Group Transactions

![[Shard Paxos Cluster.png]]

Single-key operations are handled within one Paxos replica group. However, multi-key operations like `swap(k1, k2)` become problematic when `k1` and `k2` live in **different groups**. The goal is to maintain [[Linearizability|Linearizability]] — the swap must appear to happen atomically at a single instant, with no interleaved operations from other clients visible between its two halves.

### Naive Protocol

The intuitive approach is for the group receiving the client request to drive the operation by directly messaging the other group.

**Walkthrough for `swap(k1, k2)`** (where `k1` is owned by Group 1, `k2` by Group 2):

1. Client sends `swap(k1, k2)` to Group 1.
2. Group 1 reaches internal consensus via Paxos.
3. Group 1 reads `v1 = get(k1)` and sends `swap(k1, k2, k1=v1)` to Group 2.
4. Group 2 adds the operation to its own Paxos log.
5. Group 2 reads `v2 = get(k2)`, writes `k2 = v1`, and replies with `swapreply(k1, k2, k2=v2)`.
6. Group 1 receives the reply, writes `k1 = v2`, and sends `swapOK` to the client.

This protocol only works under perfect network conditions with no failures or concurrency. In practice, it breaks in multiple ways.

```mermaid
sequenceDiagram
    participant C as Client
    participant G1 as Group 1 (k1)
    participant G2 as Group 2 (k2)

    C->>G1: swap(k1, k2)
    G1->>G1: Paxos consensus
    G1->>G2: swap(k1, k2, k1=v1)
    G2->>G2: Paxos log
    G2-->>G1: swapreply(k1, k2, k2=v2)
    G1->>G1: write k1=v2
    G1-->>C: swapOK
```

### Issues with the Naive Protocol

![[APpend Swap issues.png]]

The root problem is that the swap executes over an extended **region of time**. Group 1 and Group 2 commit their halves at different moments, and any operation from another client that arrives during this window can land between the two halves, breaking linearizability. There are five distinct failure modes:

**Issue 1: Dropped Reply — Lost Value**

If the `swapreply` message from Group 2 is dropped, Group 1 never learns the value of `k2`. The value is effectively lost with no way to recover it.

- **Mitigation**: Group 2 keeps the reply in a retransmission buffer until it receives a `swapReplyAck` from Group 1 confirming delivery.

**Issue 2: Concurrent Swap Requests — Non-Linearizable Interleaving**

If two clients issue swap operations simultaneously, their respective operations can interleave inside the Paxos logs of both groups, producing a combined execution history that cannot be explained by any single linearizable ordering.

**Issue 3: Operations in the Middle of a Swap — Non-Linearizable**

A non-swap operation (e.g., `append(k2, x)`) from another client can commit inside Group 2's log at any point during the swap window — after Group 1 has read `k1` but before Group 2 has written `k2`. The result is a state that is inconsistent with the swap appearing atomic.

**Issue 4: Uncoordinated Participant — Group 2 Does Not Block**

Group 2 has no knowledge that a swap affecting its keys is in progress. From its perspective, it is free to accept and commit other operations on `k2` at any time. There is no mechanism to prevent Group 2 from serving conflicting requests during the swap.

**Issue 5: Premature Execution at the Coordinator**

The originating group (Group 1) may commit its own half of the swap — writing the new value of `k1` — immediately after sending the request to Group 2, before Group 2 has confirmed. If Group 2 then fails or aborts, the system is left in a split state where one group has committed and the other has not.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Two-Phase Commit (2PC)** | Two-Phase Commit — also called Atomic Commitment Protocol (ACP) |
| **Prepare Phase** | Voting Phase |
| **Execute Phase** | Commit Phase |
| **Transaction Coordinator** | Transaction Manager (TM) |
| **ShardKV Group (participant)** | Resource Manager (RM) |
| **Distributed Lock** | Pessimistic Write Lock |
| **Paxos CHOSEN** | Committed to the replicated log |

---

## Related

- [[Transactions|Transactions (2PC)]] — hub linking all 2PC components
- [[Phases and Roles|Phases and Roles]] — Phase 1/2 mechanics and reconfiguration interactions
- [[Locking and Deadlock|Locking and Deadlock]] — locking discipline and deadlock avoidance
- [[Vanilla 2PC vs Paxos Commit|Vanilla 2PC vs Paxos Commit]] — why the coordinator must be a Paxos group, not a single node
- [[Log Operations|Log Operations]] — the six log entry types and their semantics
- [[MultiPut Walkthrough|MultiPut Walkthrough]] — concrete trace of a successful 2PC execution
- [[Failure Scenarios|Failure Scenarios]] — lock contention and coordinator timeout
- [[Sharding|Sharding Overview]] — architecture of the ShardMaster and replica groups
- [[Sharded Key-Value Server|Sharded Key-Value Server]] — ShardStoreServer internals and the sub-node Paxos pattern
- [[Linearizability|Linearizability]] — the consistency guarantee 2PC is designed to preserve
- [[Multi-Paxos|Multi-Paxos]] — the consensus layer used within each replica group
