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

**Key insight**: the puzzle fails entirely if the teacher does not announce *"someone has mud."* Even if every child can already see at least one muddy forehead, the announcement creates *common knowledge* of $k \geq 1$ — without it, no child can reason about what others know (e.g., they don't know that others know that someone is muddy).

### Differences from Distributed Systems
- **Synchronicity**: The puzzle is synchronous; rounds advance in lockstep.
- **Communication**: Real servers can talk; children cannot.
- **Observation**: Children "see" state; servers must use message passing.

## Kinds of Knowledge

These levels are ordered from weakest to strongest:

- $D_G(\phi)$ — **distributed knowledge**: if you pooled all knowledge in $G$, you could derive $\phi$. (Weakest)
- $S_G(\phi)$ — **someone knows**: at least one node in group $G$ knows $\phi$.
- $K_i(\phi)$ — **individual knowledge**: node $i$ knows $\phi$. (Axiom: $K_i \phi \rightarrow \phi$)
- $E_G(\phi)$ — **everyone knows**: every node in $G$ knows $\phi$.
- $E_G^k(\phi)$ — **k-th order everyone knows**: ("everyone knows")$^k$ of $\phi$.
- $C_G(\phi)$ — **common knowledge**: $\phi$ is common knowledge in $G$. (Strongest)

$$C_G(\phi) \equiv \bigwedge_{k=1}^{\infty} E_G^k(\phi)$$

### Iterated Knowledge Case Study (k=2)
With Alice and Bob, and $m = \text{"someone is muddy"}$:
- **Before the teacher speaks**:
    - $E_G m$ holds: Both see a muddy forehead.
    - $E_G^2 m$ **fails**: Alice doesn't know if she is muddy. She considers it possible that Bob is the *only* muddy child, in which case Bob would see no mud and wouldn't know $m$.
- **After the announcement**: The teacher's public announcement creates $C_G m$ instantly.

### Evolution of a Protocol
Distrubted protocols "climb" this hierarchy over time:
1.  **$D_G \phi \rightsquigarrow S_G \phi$ (Gathering)**: Gathering distributed info to a single node.
2.  **$K_i \phi \rightsquigarrow E_G \phi$ (Publishing)**: One node broadcasts a fact (e.g., a View Server announcing a new view).

## Impossibility of Coordinated Attack

**Theorem**: Gaining common knowledge is impossible over an unreliable network. If $C_G \phi$ holds at any point, it must have held at the very beginning.

Setup:
- Two armies (A and B) want to coordinate an attack.
- Communication via unreliable messengers.
- Both must attack together to win.

### Proof (Indistinguishable Executions)
1.  Assume a correct protocol $P$ exists.
2.  Consider an execution where the last message (A $\to$ B) is dropped.
3.  A cannot distinguish between "delivered" and "dropped" (no feedback).
4.  Since A acts the same, B must also attack to stay coordinated.
5.  This implies the last message was useless. Induction reduces the protocol to 0 messages.
6.  **Result**: Coordination cannot depend on information gathered during the execution.

## Consensus

**Consensus** is the problem of getting all nodes to agree on a single value.

- **Majority voting** — nodes propose values; the majority value is chosen. Ensures *something* gets decided, but correctness depends on assumptions about failures
- **Impossibility** — consensus under asynchronous conditions with even one crash failure is impossible (the FLP impossibility result follows the same structure as coordinated attack)

## Related

- [[CSE452/Clocks/Time and Virtual Clocks|Time and Virtual Clocks]] — happens-before ordering; a prerequisite for reasoning about what nodes can know
- [[CSE452/Clocks/System State|System State]] — stable properties and invariants in distributed systems
- [[CSE452/RPC/Fault Model|Fault Model]] — the failure model that makes coordination hard
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — a practical protocol that works around coordination limits
