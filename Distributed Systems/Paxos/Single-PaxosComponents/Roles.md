# Distributed Systems: Paxos Roles

In **Single Decree Paxos**, nodes take on specific roles to reach consensus on a single value.

- **Proposer**: Drives the protocol. Picks ballot numbers and proposes values.
- **Acceptor**: Votes on proposals. The fixed set of acceptors collectively holds the state.
- **Learner**: Detects when a value has been chosen and reports it.

In most practical implementations (like [[Multi-Paxos|Multi-Paxos]]), a single node may act as all three roles simultaneously.

---

## Industry Standard Terms

| CSE452 Term | Industry / Standard Term |
| :--- | :--- |
| **Proposer** | Proposer / leader candidate |
| **Acceptor** | Acceptor / voter |
| **Learner** | Learner / observer |

---

## Related
- [[Single Paxos|Single Decree Paxos]] — the algorithm these roles participate in
- [[Protocol|The Paxos Protocol]] — the messages each role sends and receives
