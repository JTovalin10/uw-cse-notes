# CSE452: Paxos Roles

In **Single Decree Paxos**, nodes take on specific roles to reach consensus on a single value.

- **[[Proposer]]**: Drives the protocol. Picks ballot numbers and proposes values.
- **[[Acceptor]]**: Votes on proposals. The fixed set of acceptors collectively holds the state.
- **[[Learner]]**: Detects when a value has been chosen and reports it.

In most practical implementations (like [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]]), a single node may act as all three roles simultaneously.

---
- [[CSE452/Paxos/Single Paxos|Back to Single Paxos]]
- [[CSE452/Paxos/Single-PaxosComponents/Protocol|The Paxos Protocol]]
