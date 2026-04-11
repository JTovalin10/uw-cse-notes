# CSE452: View Server

## What is a View?

A **view** defines the current role assignment — the authoritative declaration of which server is primary, which is backup, and what the current view number is:

$$\text{view}_n = (\text{primary}_n,\ \text{backup}_n,\ n)$$

where $n$ is a monotonically increasing **view number**. Views are analogous to sequence numbers — each view change increments $n$, producing a total order over all role assignments the system has ever had.

---

## The View Server

The **View Server (VS)** is a separate, assumed-reliable server that maintains the current view and acts as the single source of truth for role assignment. All replicas and clients contact the VS to learn who the current primary and backup are.

Responsibilities:
- Determines which server is primary, which is backup, and the current view number
- Advances through a sequence of views (like a sequence number — view numbers only go up)
- Responds to pings from servers and clients, informing them of the current view
  - A server's local view may trail behind; the VS response updates it
- Tracks which servers are alive or dead, transitioning to a new view when the primary or backup fails

**Important**: the View Server is a single point of failure. If the VS goes down, the system cannot make view changes. Production systems replace it with a replicated consensus service (e.g., ZooKeeper, etcd, or Raft).

---

## When Can the View Server Advance to a New View?

The VS can only advance to a new view under specific conditions — it cannot change views arbitrarily:

- **Start-up** (special case): from an initial state with no primary or backup, the VS can transition to the first view
- **General case**: the VS can advance to view $i+1$ only when:
  1. The current view $i$ has been **acknowledged** by the primary of view $i$ (see Rule 5 in [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules]])
  2. A primary or backup has failed (detected via missed pings)

This requirement prevents the VS from racing ahead of state transfers — the primary's ACK signals that the new backup is fully up to date.

---

## Pinging the View Server

Servers maintain liveness with the VS by sending periodic **pings**.

### What a Ping Carries
1. **Confirmation of liveness** — the server is still running
2. **The most recent view the server knows** — the primary uses this to acknowledge the current view

### What the VS Returns
The VS replies to every ping with the **current view** — this is how servers learn about view changes. A server may be on an old view; the reply corrects it.

### How the View Server Detects Failures

- Servers ping the VS periodically (e.g., every 100 ms) to signal they are alive
- The VS sets a **timeout**: if it has not received a ping from a server within the timeout window, it considers that server dead
- This is an approximation — a slow or paused server may be falsely declared dead (see [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]])

---

## View Transitions

When the VS detects a failure (via missed pings), it creates a new view with an incremented view number, subject to the ACK requirement above:

| Event | New View |
|-------|----------|
| Primary $P_n$ fails | Backup becomes new primary; promote an idle server to backup if one is available |
| Backup $B_n$ fails | Promote an idle server to backup; primary transfers state to it |
| Both $P_n$ and $B_n$ fail | Wait — hope one comes back (system is unavailable until then) |
| Primary fails, no backup exists | System unavailable — nothing to promote |
| No idle server available | Primary continues alone in degraded mode (no backup) |

---

## View Acknowledgment Rule

A server **must acknowledge** (ACK) a new view before it can act in the role assigned by that view:

- A server that has not ACK'd a view cannot act as primary or backup for that view
- The primary ACKs a view by pinging the VS with the current view number **after** completing state transfer to the new backup
- This ensures that before any view is considered "live," the new backup is fully up to date

### Key Invariant

At most one server should be acting as primary at any time. The VS enforces this by being the single authority on view membership — no server should accept client writes unless it believes it is the primary in the **current** view.

---

## Idle Pool and State Transfer

To recover from failures, a pool of **idle servers** stands by waiting to be promoted.

When a failure is detected, an idle server is promoted to backup (or primary). The problem: the new server has no data.

### State Transfer

The current primary must transfer all its state (e.g., the entire key-value store) to the new backup before ACKing the new view:
- Send the entire state in a single message (feasible when the dataset is small)
- The new backup installs the state and ACKs the primary
- The primary then ACKs the VS, signaling the transition is complete (see [[CSE452/Primary-Backup/Six Rules of Primary Backup#Rule 5 — The view server cannot advance to view i 1 until it receives an ACK from the primary of view i|Rule 5]])

### Failure Scenarios

| Failure | Response |
|---------|----------|
| Old primary fails | Old backup becomes new primary; idle server becomes new backup (with state transfer) |
| Old backup fails | Idle server becomes new backup; primary transfers state to it |

### Notifying Everyone About the New View

All clients and replicas must learn about new primary and backup identities. This happens automatically through ping responses — the next time a client or server pings the VS, it receives the updated view.

---

## Related

- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — the full primary-backup model that the view server supports
- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — the rules governing view acknowledgment and state transfer
- [[CSE452/Primary-Backup/State Machine Replication (State Transfer)|State Transfer]] — mechanics of transferring state to a newly promoted backup
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — failure detection that triggers view transitions
- [[CSE452/Time and Virtual Clocks|Time and Virtual Clocks]] — invariants about view state and what is stable vs. unstable
