# CSE452: Six Rules of Primary-Backup

---

## Message Flow Overview

| Actor       | Sends                                                                  | Receives                      |
| ----------- | ---------------------------------------------------------------------- | ----------------------------- |
| Client      | Request to primary; `getview` to view server                           | View reply from view server   |
| Primary     | Forward request to backup; ping to view server                         | Forward ACK from backup       |
| Backup      | Forward ACK to primary; ping to view server                            | Forward request from primary  |
| View Server | View reply to client; view to primary and backup; request to idle pool | Pings from primary and backup |

---

## The Six Rules

### Rule 1 — Primary must wait for backup to ACK before executing and replying to client

- The primary forwards a request to the backup **before** executing it
- The primary executes only **after** receiving an ACK from the backup
- This guarantees the backup is never more than one command behind the primary

**Why this matters:**
- Without forwarding before executing: if the primary changes or the view changes mid-operation, the new primary may not have the latest state, causing **stale reads**
- Specifically: if the primary executes first and then fails, the backup (now new primary) will be missing that operation

### Rule 2 — Backup must accept forward requests only from the current-view primary

- The backup checks that the forwarding request is coming from whoever is designated primary in its current view
- Prevents a stale or deposed primary from writing to the backup

**Challenge:** How does the backup know which view the message is from? The forwarding message must include the sender's view number so the backup can verify it matches.

### Rule 3 — The primary in view $i+1$ must have been the backup or primary in view $i$

- A server promoted from the **idle pool** may have an empty or stale application state
- Only the primary or backup in the previous view are guaranteed to have the most up-to-date state
- Therefore, a newly elected primary must have been in the previous view — it cannot be a brand-new idle server

**Why this matters:** If an idle server (with no state) became primary, it would serve incorrect data. This rule ensures continuity of state across view changes.

### Rule 4 — Non-primary servers must reject client requests

- Clients are not guaranteed to know the current primary — they may contact any node
- Any node may also be running on an **outdated view** and incorrectly believe it is primary
- Servers must only process and respond to client requests if they believe they are the current primary

**Why this matters:** Without this rule, a deposed primary or a backup could serve stale or inconsistent data. Rejecting ensures the client retries with the correct primary.

### Rule 5 — The view server cannot advance to view $i+1$ until it receives an ACK from the primary of view $i$

- See [[CSE452/Primary-Backup/State Machine Replication (State Transfer)|State Transfer]] for the full mechanics
- When the primary ACKs the new view, it signals that **state transfer to the new backup is complete** — the backup is fully up to date

**Why this matters:**
- Without this rule, the view server could advance the view before the new backup has the correct application state
- The ACK acts as a completion signal: the primary will not acknowledge the new view until the new backup has received and applied the full state transfer

**Challenge:** The prerequisite for sending the ACK is completing the entire state transfer, which may take time. During this window the system is in a transitional state.

### Rule 6 — Every client operation must be entirely before or entirely after a state transfer — never during

- Applying a client operation *while* a state transfer is in progress risks overwriting values mid-transfer, leaving the backup in an inconsistent state
- The primary must serialize operations and state transfers: finish the transfer, then resume processing requests (or vice versa)

**Why this matters:** A partial state transfer combined with in-flight writes can corrupt the backup's state, defeating the purpose of replication.

---

## Related

- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — full overview of the primary-backup model, view server, and state transfer
- [[CSE452/Primary-Backup/State Machine Replication (State Transfer)|State Transfer]] — mechanics of transferring state to a newly promoted backup
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — how failure detection triggers view changes
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why operations must be safe to re-execute during recovery
