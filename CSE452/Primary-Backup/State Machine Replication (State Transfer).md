# CSE452: State Transfer

**State transfer** is the process of copying the full application state from the current primary to a newly promoted backup so it can participate in replication.

---

## Why, When, and How

**Why do we state transfer?**
- To bring a new backup (formerly an **idle server**) up to date with the current application state.
- An idle server has an empty or stale state and cannot safely serve as backup without first receiving the full current state.

**When do we state transfer?**
- When the primary receives a new view that contains a new backup (i.e., the backup slot has changed).
- The primary is responsible for initiating the transfer as soon as it recognizes the new backup.

**How does it work?**
- The primary sends its entire application state (e.g., the full key-value store) to the new backup in a single message.
- The new backup installs the state and ACKs the primary.
- The primary then ACKs the view server, signaling that the transition is complete (see [[CSE452/Primary-Backup/Six Rules of Primary Backup#Rule 5 — The view server cannot advance to view i 1 until it receives an ACK from the primary of view i|Rule 5]]).

---

## Key Challenges

### Pings during transfer

- During a state transfer, the primary could stop sending pings to the [[CSE452/Primary-Backup/View Server|View Server]].
- However, it is safer for the primary to **continue pinging** with the old view number to avoid being incorrectly declared dead.
- The backup can also receive **duplicate or late** state transfer messages — for example, if the primary retransmits due to a dropped ACK.

### Idempotence of state transfer

- The backup's state should be overwritten **at most once per view change**.
- If the state transfer ACK is dropped and the primary retransmits, the backup must recognize the duplicate and not re-apply the transfer — but it **should still ACK** the retransmitted message to unblock the primary.
- Rule: execute a state transfer exactly once per view; always acknowledge retransmits without re-applying.

### Serialization with client requests

- Client operations must not be processed during a state transfer (see [[CSE452/Primary-Backup/Six Rules of Primary Backup#Rule 6 — Every client operation must be entirely before or entirely after a state transfer — never during|Rule 6]]).
- Otherwise, writes applied during transfer could be overwritten by the incoming state, or the transferred state could overwrite in-progress writes.

---

## Related

- [[CSE452/Primary-Backup/Six Rules of Primary Backup|Six Rules of Primary-Backup]] — rules governing when and how state transfer must occur
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — full model overview including idle pool and view transitions
- [[CSE452/Primary-Backup/Idempotence|Idempotence]] — why state transfer messages must be safe to receive more than once
- [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]] — failure detection that triggers a state transfer
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — basis for state machine replication
