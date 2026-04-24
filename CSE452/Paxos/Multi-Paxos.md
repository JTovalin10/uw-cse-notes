# Multi-Paxos

**Multi-Paxos** builds on the core Single Decree Paxos algorithm to decide values for an entire sequence of log slots rather than just a single decision.
## What is a Log?

In a distributed system, a **Log** is an ordered sequence of commands. Think of it as a list of "to-do" items for a database or state machine.

- **The Goal**: Every server in the cluster should have an identical copy of the log. 
	- conceptually, a "global log"
- **Consistency**: If Server A executes the log `[Set X=1, Set Y=2]`, but Server B executes `[Set Y=2, Set X=1]`, they might end up with different data. The log ensures every node does the exact same thing in the exact same order.
- **Slots (Indices)**: Each position in the log is called a **Slot**. Conceptually, there is an infinite number of slots. 
	- the order of deciisions is not the same as the order of execution. we can insert something into slot 3 despite 1 and 2 being empty. but we cannot execute 3 until 1 and 2 is complete.
    - Slot 1: `PUT "Apple" = 5`
    - Slot 2: `PUT "Banana" = 10`
    - Slot 3: `DELETE "Apple"`
- **Replicated State Machine (RSM)**: This is the actual application (like a SQL database). It reads the commands from the log one-by-one and executes them. Because Paxos ensures every server's log is identical, every server's database will stay perfectly in sync.
## Basic Idea of MultiPaxos (unoptimized)
- run [[Single Paxos]] in each slot
- client broadcast request to all servers
	- find an empty slot and propose the request
- wait for prefix of log to be chosen
	- once you get it, you execute the request and then respond to the client
- has multiple rounds of unncessary communication between nodes due to responeds
## Messages
As each node acts all as roles, they must broafcast each message and "send it to itself"
- 1a
	- $1a(s = slot num, r=(seqnum, address))$
- 1b
	- $1b(s=slot num, r(seqnum, address), old vote)$
- 2a
	- 2a(s=slot num, r = (seqnum, address), request)
- 2b
	- we dont need to include the value as the proposer knows what won
	- 2b(s = slot num. r = (seqnum, server address))
## Distinguished Proposer Optimization (Leader Election)
Running two full phases (Prepare and Accept) for every single log slot is slow. Multi-Paxos optimizes this by electing a **Leader**.

1.  **Leader Election**: A proposer runs Phase 1 (Prepare) for **all future slots** at once using a single ballot number.
	1. once we collect the majority of request we are the leader
	2. combine phase 1 across all slots
	3. delete the slot data from 1a/1b messages. pretend the 1a message is for all slots. 1b then becomes a summary of our voting in all slots (this is finite as we tell it the highest round number and value for each previous voting rounds). we combine round number by the end of this phase
		1. 1a(r = (seqnum, address))
		2. 1b(r=(seqnum, address), summary={slot: (roundnum, vote)})
	4. we save one round trip as we save the time it takes to get our slot
	5. round numbers are tied to election cycles
2.  **Steady State**: Once an acceptor promises to that leader, the leader can skip Phase 1 for subsequent slots. It only needs to run Phase 2 (Accept) to propose new values.
	1. 2a round numbers are not combined here
		1. same as above
3.  **Failure**: If the leader fails, a new proposer will eventually time out and try to become the leader by running Phase 1 with a higher ballot number.
## Heartbeats
- leader tells followers that they are still up
- client requests can take the place of heartbeats
- if there are no client requests then we send a heartbeat so followers know we are still alive
- followers set a timer to check if they've heard from the leader recently
- if they dont hear from the leader then they should try to become the leader
## Roles in Multi-Paxos
In most practical implementations:
- Every server acts as a **Proposer**, **Acceptor**, and **Learner**.
- One server is designated the **Distinguished Proposer** (Leader).
- Clients send requests to the Leader.
- The Leader assigns the request to the next available slot and initiates Phase 2.

## Key Differences from Single Paxos
- **Roles**: all nodes play all roles
- **Ballots**: ballots are pairs (seqnum, server id). Ordering them in lexicographic order
	- higher seqnum wins and if they are equal then higher server id wins
	- Single Paxos this was optimal
- **Multiple Instances**: One Paxos instance per log index.
- **Phase 1 Elision**: Only the leader runs Phase 1; everyone else just accepts (Phase 2).
- **Log Gaps**: If a slot fails to reach consensus (e.g., due to message loss), the log may have "holes" that must be filled before the state machine can execute subsequent commands.

---
- [[CSE452/Paxos/Paxos|Back to Paxos Overview]]
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Paxos Invariants|In-depth: Ballot IDs and Invariants]]
