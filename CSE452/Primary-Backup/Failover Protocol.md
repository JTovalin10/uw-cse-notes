# CSE452: Failover Protocol

## What is Failover?

**Failover** is the process of replacing one node in a role (primary or backup) with another node — conceptually, transferring the role to a new machine. If the primary fails, the backup takes over as the new primary.

---

## Why Failover is Hard

The fundamental problem: **you cannot know with certainty that a node has failed**.

When a node becomes unreachable, there are two possible explanations:
1. The **machine** has crashed.
2. The **network** has failed (the machine is still running but we can't communicate with it).

These two scenarios are indistinguishable from the outside. Acting on a false assumption causes problems:
- If you promote a new primary while the old primary is still running, you get a **split brain** — two machines both acting as primary simultaneously, causing diverging state.

---

## Failover Process

The ideal process:
1. **Detect** that a failure has likely occurred (via heartbeat timeouts or similar).
2. **Decide** whether to failover (use approximate failure detection — see [[CSE452/Primary-Backup/Primary Backup#Approximate Failure Detection|Approximate Failure Detection]]).
3. **Execute** the view change: update the [[CSE452/Primary-Backup/View Server|View Server]], perform state transfer to the new backup if needed.

Because detection is imperfect, systems accept the risk of false positives and design protocols (like the View Server) to handle the edge cases safely.

---

## Related
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — the full replication protocol that failover supports
- [[CSE452/RPC/Fault Model|Fault Model]] — the types of failures that trigger failover
- [[CSE452/Primary-Backup/Why not just use TCP|Why Not Just Use TCP]] — why TCP cannot substitute for an application-level failover protocol
- [[CSE451/Processes/Process/Process Management.md]] — OS-level process management and failure handling
