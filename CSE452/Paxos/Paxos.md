# CSE452: Paxos

**Paxos** is a general algorithm used to get a group of nodes (a distributed system) to share a goal and reach consensus on a single value or a sequence of operations.

## Log-Based State Machine Replication (SMR)
- Uses an odd number of nodes that communicate with each other.
- Each node maintains a **Log**, which is a sequence of elements representing operations the node knows about.
- **Slot**: An index into a log.
- **Goal**: Have nodes agree on the order of operations in the log. An operation is not added to the "one true log" until consensus is reached.
- **Result**: New requests can be added to the log and processed in parallel once agreed upon.

## MultiPaxos
**MultiPaxos** builds on the core Paxos algorithm to decide values for an entire sequence of log slots rather than just a single decision.

## Single Decree Paxos
The **Consensus Problem** involves a group of nodes agreeing on a single decision (a value proposed by one of the nodes).

### Correctness Requirements
1. **Validity**: The chosen value must have been proposed by a node.
2. **Agreement**: At most one value can be chosen (safety).
3. **Integrity**: No node thinks a value was chosen unless it actually was.

### Roles
While often mapped to physical nodes, roles are distinct functional entities:
- **Proposers**: Propose values by starting a new **Ballot** with a round number $r$. They first communicate with acceptors (1a message) to learn about any values from previous rounds.
- **Acceptors**: Vote on proposals. A **Majority** (more than half) of acceptors must agree for a value to be chosen. They respond with a 1b message containing a summary of their previous votes.
- **Learners**: Learn the final results by waiting for a majority of 2b messages in the same round.

### Ballots (Rounds)
- **Ballot Number**: A monotonically increasing identifier.
- Each ballot has a proposed value, and acceptors vote to accept it.
- Ballot numbers are unique to each proposer (e.g., using a pair of `(IP, sequence_number)` or round-robin allocation).

### Phases
#### Phase 1 (Prepare)
1. **Proposer**: Picks a round number $r$ and sends a **1a(r)** (Prepare) message to all acceptors.
2. **Acceptor**: Responds with a **1b(r, summary)** (Promise) message.
   - The summary indicates if they have already voted in a previous round and, if so, what that value was.

#### Phase 2 (Accept)
1. **Proposer**: Waits for a majority of 1b messages.
   - If all summaries are null, the proposer can propose any value (e.g., a client command).
   - If previous values exist, the proposer must pick the value from the highest-numbered previous round.
2. **Proposer**: Sends a **2a(r, v)** (Accept Request) message to all acceptors.
3. **Acceptor**: Sends a **2b(r, v)** (Accepted) message to the learners if they choose to vote for this round.

## Chosen
- **Chosen(r, v)**: A majority of acceptors have sent 2b(r, v) messages to the learner for a specific round.
- **Chosen(v)**: There exists some round $r$ such that `Chosen(r, v)`.

---

## Related
- [[CSE452/RPC/Deterministic State Machine|Deterministic State Machine]] — Paxos is used to order commands for a DSM
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — an alternative (simpler) approach to replication
- [[CSE452/RPC/Remote Procedure Call (RPC)|Remote Procedure Call (RPC)]] — the underlying communication mechanism
- [[CSE451/Threads/Deadlocks|CSE451: Deadlocks]] — consensus algorithms like Paxos help avoid distributed deadlocks or split-brain scenarios
