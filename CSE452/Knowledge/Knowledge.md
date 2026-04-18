# CSE452: Knowledge in Distributed Systems

How much can a node in a distributed system *know*, and what kinds of knowledge can be gained through communication? This question underlies fundamental impossibility results in distributed systems.

## Muddy Foreheads Puzzle

A classic puzzle that formalizes the role of **common knowledge**.

Setup:
- $n$ children sit in a circle; $k$ of them have mud on their forehead ($k \leq n$)
- Children cannot see their own forehead but can see everyone else's
- The children do not know $k$
- The teacher announces: *"Someone has mud on their forehead"*
- Each round, the teacher asks children to raise their hand if they know they have mud — raising incorrectly means the class loses

**Result**: the class wins in exactly $k$ rounds.

Reasoning:
- The teacher's announcement establishes $k \geq 1$ as **common knowledge**
- Each child can see $k - 1$ muddy foreheads (they cannot see their own)
- For $k = 1$: the one muddy child sees zero others with mud, so they immediately know they have mud
- For $k \geq 2$: each muddy child waits — if $k - 1$ rounds pass without anyone raising, it means the $k - 1$ others also couldn't deduce their status, which implies the observer also has mud
- On round $k$, all $k$ muddy children can deduce their status and raise their hands

**Key insight**: the puzzle fails entirely if the teacher does not announce *"someone has mud."* Even if every child can already see at least one muddy forehead, the announcement creates *common knowledge* of $k \geq 1$ — without it, no child can reason about what others know.

## Kinds of Knowledge

These levels are ordered from weakest to strongest:

- $k_i(\phi)$ — **individual knowledge**: node $i$ knows $\phi$
  - Axiom: $k_i(\phi) \rightarrow \phi$ (you cannot know something false)
- $S_G(\phi)$ — **someone knows**: at least one node in group $G$ knows $\phi$
- $D_G(\phi)$ — **distributed knowledge**: if you pooled all knowledge in $G$, you could derive $\phi$
  - This is weaker than everyone knowing; it means the knowledge is spread across nodes
  - Example (muddy foreheads): each child knows everyone else's forehead but not their own — together they know everything, but individually each is missing one piece
- $E_G(\phi)$ — **everyone knows**: every node in $G$ knows $\phi$
- $E_G^k(\phi)$ — **k-th order everyone knows**: ("everyone knows")$^k$ of $\phi$
- $C_G(\phi)$ — **common knowledge**: $\phi$ is common knowledge in $G$

$$C_G(\phi) \equiv \bigwedge_{k=1}^{\infty} E_G^k(\phi)$$

Common knowledge means: everyone knows $\phi$, everyone knows everyone knows $\phi$, and so on infinitely.

### Knowledge Hierarchy

$$D_G(\phi) \rightarrow S_G(\phi)$$
$$K_i(\phi) \rightarrow E_G(\phi) \quad \text{(if all nodes know it)}$$

**Gaining common knowledge through message passing is impossible** in an asynchronous system with unreliable communication.

## Impossibility of Coordinated Attack

A concrete impossibility result that follows from the impossibility of common knowledge.

Setup:
- Two armies on separate hills want to coordinate an attack on a village in the valley
- They can only communicate via messengers who must pass through the village (unreliable — messengers can be captured)
- Both armies must attack simultaneously to succeed; attacking alone means defeat

**Result**: no finite exchange of messages can guarantee coordination.

Proof sketch (by induction on message count):
- Consider the last message sent; the sender cannot know whether it was received
- If that message is dropped, the sender may still attack (having decided to send it), but the receiver will not — uncoordinated attack
- Removing the last message does not change the argument: the second-to-last message is now "last," and the same reasoning applies
- By induction, no finite message sequence works

This is equivalent to saying that common knowledge of *"we will attack at time T"* cannot be established over an unreliable network.

## Consensus

**Consensus** is the problem of getting all nodes to agree on a single value.

- **Majority voting** — nodes propose values; the majority value is chosen. Ensures *something* gets decided, but correctness depends on assumptions about failures
- **Impossibility** — consensus under asynchronous conditions with even one crash failure is impossible (the FLP impossibility result follows the same structure as coordinated attack)

## Related

- [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] — happens-before ordering; a prerequisite for reasoning about what nodes can know
- [[CSE452/Clocks/System State|System State]] — stable properties and invariants in distributed systems
- [[CSE452/RPC/Fault Model|Fault Model]] — the failure model that makes coordination hard
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — a practical protocol that works around coordination limits
