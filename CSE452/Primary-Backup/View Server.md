## View Server

A **view** defines the current roles and is the authoritative assignment of who does what:

$$\text{view}_n = (\text{primary}_n,\ \text{backup}_n,\ n)$$

where $n$ is the monotonically increasing **view number**.

The **View Server (VS)** is a separate, assumed-reliable server that maintains the current view. All replicas and clients contact the VS to learn the current view
- determines the primary, backup, and view number
- goes through sequence of views (like a seqnum)
- Responds to servers and clients that ping'd the VS to learn what the actual current view is
	- server/client's view may trail behind
- keep track of who is alive/dead, transitioning to a new view if primary or backup dies

**Note: this creates a single point of failure**
## When can the VS mode on to a new view
- from start-up view (special case) with no primary/backup
	- can transition to initial view
- for any other view (general)
	- when the current view is ack
	- a primary or backup dies
## Receiving and Responding to Pings

![[Receiving and Responding to Pings.png]]when the view server goes pinged  we return the View Response which informs the server of its current view
- the ping contains which view the node is currently on which is helpful for state transfers
1. pinging the view server
	1. confirmation that the server is alive
	2. the most recent view the server knows
		1. primary needs to ack the current view
2. Replying to pings
	1. view server's reply to a ping informs the server of the current view
### How the View Server Detects Failures

- Servers **ping** the View Server periodically (e.g., every 100ms) to signal they are alive
- The View Server sets a **timeout**: if it has not received a ping from a server within the timeout window, it considers that server dead
- This is an approximation — a slow server may be falsely declared dead (see [[CSE452/Primary-Backup/Failover Protocol|Failover Protocol]])

### View Transitions

When the View Server detects a failure, it creates a new view with an incremented view number (assuming current view has been ack'd):

| Event                      | New View                                                                          |
| -------------------------- | --------------------------------------------------------------------------------- |
| Primary $P_n$ fails        | Backup becomes new primary and try to vet anotehr abckup if you can in View i + 1 |
| Backup $B_n$ fails         | New server should become backup or null backup in View i + 1                      |
| Both $P_n$ and $B_n$ fails | Just do nothing and hope tha tit comes back                                       |
| Primary Fails w/o backup   | nothing                                                                           |
| No backup available        | Primary continues alone (degraded mode)                                           |
## Call Flow Diagram
![[Call Flow Diagram.png]]
- View 1 is acknowledged by Server1
	- at point e
		- need to wait for the primary server to ack back with the current view number before considering a view as acknowledged
### Call Flow Diagram Crash
- S1 sends application state to S2 and gets an ack back before Ping(2), acknowledging the view
![[Call Flow Diagram Crash.png]]
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
