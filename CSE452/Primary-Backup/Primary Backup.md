# CSE452: Primary-Backup Replication

## Handling Node Failure

To tolerate node failures, every critical operation must be executable by any surviving machine. The approach is **replication**:
- If one machine fails, another holds the same data and can take over
- Replicas must stay **identical** — if they diverge, the system is broken

The key insight from [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]]: execute the **same operations in the same order** on both replicas and they will remain identical.

### Single-Client Approach
With only one client, the client can attach a **sequence number** to each request and the replicas use it to agree on order. But this breaks with multiple clients.

---

## Primary-Backup Model

**Primary-Backup** handles multiple clients by designating one replica as authoritative for ordering:

- **Primary (P)**: in charge of ordering all client requests; decides the order; forwards requests to the backup with its own sequence number
- **Backup (B)**: executes requests in the order the primary dictates; sends an ACK back to the primary

Each client still tracks its own seqnum; the primary also maintains a global seqnum for backup coordination.

### Request Flow

```
C_1 --req_A--> P_n --req + seqnum--> B_m
                 <--------ACK---------
                 (P executes, then responds)
C_2 --req_B--> P_n
```

1. Client sends request to P
2. P forwards the request (with its seqnum) to B
3. B executes the request, then ACKs P
4. P executes the request
5. P sends the response back to the client

Note: B executes *before* P to ensure B is never ahead of P. This ordering guarantees that if P fails after sending to B, B has already applied the operation.

---

## View Server

A **view** defines the current roles and is the authoritative assignment of who does what:

$$\text{view}_n = (\text{primary}_n,\ \text{backup}_n,\ n)$$

where $n$ is the monotonically increasing **view number**.

The **View Server (VS)** is a separate, assumed-reliable server that maintains the current view. All replicas and clients contact the VS to learn the current view.

### How the View Server Detects Failures

- Servers **ping** the View Server periodically (e.g., every 100ms) to signal they are alive
- The View Server sets a **timeout**: if it has not received a ping from a server within the timeout window, it considers that server dead
- This is an approximation — a slow server may be falsely declared dead (see [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]])

### View Transitions

When the View Server detects a failure, it creates a new view with an incremented view number:

| Event | New View |
|-------|----------|
| Primary $P_n$ fails | $B_n$ becomes $P_{n+1}$; an idle server becomes $B_{n+1}$ |
| Backup $B_n$ fails | An idle server becomes $B_{n+1}$; $P_n$ remains primary |
| No backup available | Primary continues alone (degraded mode) |

### View Acknowledgment Rule

A server **must acknowledge** (ack) a new view before it can act in the role assigned by that view:
- A server that does not ack a view cannot become primary or backup for that view
- This ensures that the new primary has explicitly accepted its role before handling requests

### Key Invariant

At most one server should be acting as primary at any time. The View Server enforces this by being the single authority on view membership — no server should accept client writes unless it believes it is the primary for the **current** view.

---

## Idle Pool and State Transfer

To recover from failures, a pool of **idle servers** stands by:

- When a failure is detected, an idle server is promoted to backup (or primary)
- **Problem**: the new server has no data

### State Transfer
The existing primary must transfer all its state (e.g., the entire key-value store) to the new backup:
- Send the entire state in a single message (feasible when the dataset is small)
- The new backup must ACK the transfer before joining the view

### Failure Scenarios

| Failure | Response |
|---------|----------|
| Old primary fails | Old backup becomes new primary; idle server becomes new backup |
| Old backup fails | Idle server becomes new backup; primary transfers state to it |

### Telling Everyone About the New View
All clients and replicas must be notified of the new P and B identities. This is the job of the View Server.

---

## Approximate Failure Detection

It is **impossible** to know with certainty whether a remote machine has failed or is just slow/unreachable (see [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]]). Instead, systems use **best-effort** failure detection:

- A machine can be considered down when it is actually up
- A machine can be considered up when it is actually down
- Run a protocol to *estimate* failure and act accordingly

**Common approach**: primary monitors backup and backup monitors primary via periodic heartbeats.

---

## Split Brain Problem

The **split brain problem** occurs when two subsystems each believe they are the authoritative whole system and operate independently. This leads to **diverging state** — both sides accept writes, resulting in two inconsistent "versions" of the data with no way to reconcile them.

**Concrete scenario**: a network partition separates P and B from each other. B cannot hear P (it thinks P failed) and P cannot hear B (it thinks B failed). If both promote themselves to primary, both will accept writes → split brain.

### How the View Server Mitigates Split Brain

- The View Server is the single source of truth for the current view
- A server should only act as primary if it is the primary **in the current view** as reported by the View Server
- A server should stop accepting client requests if it cannot reach the View Server (because it cannot confirm it is still the current primary)

**Limitation**: the View Server itself is a single point of failure. If the VS goes down, the system cannot make view changes. This is acceptable in lab settings but production systems require a replicated consensus service (e.g., ZooKeeper, etcd, Raft) to replace the View Server.

---

## Related
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — the mechanics of detecting failure and switching roles
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — why same-order execution keeps replicas identical
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why some operations must be safe to repeat
- [[CSE452/Primary-Backup/Why not just use TCP|Why Not Just Use TCP]] — TCP's limitations in the face of failures
- [[CSE452/RPC/Fault Model|Fault Model]] — what failures primary-backup is designed to tolerate
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — how P and B communicate over the network
