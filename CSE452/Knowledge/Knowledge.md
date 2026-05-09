# CSE452: Knowledge in Distributed Systems

How much can a node in a distributed system *know*, and what kinds of knowledge can be gained through communication? This question, developed formally by Halpern and Moses (1990), underlies the most fundamental impossibility results in distributed systems. The answer is surprising: in an asynchronous network where messages can be lost, achieving the strongest form of knowledge — **common knowledge** — is provably impossible. This single fact explains why consensus, coordinated failover, and atomic commitment are so hard.

---

## The Muddy Foreheads Puzzle

The **Muddy Foreheads Puzzle** is a classic thought experiment that makes the abstract notion of common knowledge concrete and viscerally understandable. It is not just a curiosity — it is a direct analogue to the coordination problems in distributed systems.

### Setup

- $n$ children sit in a circle; $k$ of them have mud on their forehead, where $1 \leq k \leq n$.
- Children can see every other child's forehead, but **cannot see their own**.
- Crucially, children do not know the value of $k$.
- A teacher announces publicly: *"At least one of you has mud on your forehead."*
- Each round, the teacher asks: *"Raise your hand if you know you have mud."* A wrong raise means the class loses.

**Result**: the class wins in exactly $k$ rounds — all $k$ muddy children raise their hands simultaneously on round $k$ and only on round $k$.

### Why the Puzzle Works: Inductive Reasoning

The reasoning is a precise induction on $k$.

**Base case ($k = 1$):** The single muddy child looks around and sees zero other muddy children. They hear the teacher's announcement that at least one child is muddy. Since they see no others with mud, they conclude by elimination: *"It must be me."* They raise their hand on round 1. Children with clean foreheads see one muddy child, so they wait — they cannot yet conclude anything about themselves.

**Inductive step ($k \geq 2$):** Consider a muddy child $A$. $A$ sees $k - 1$ other muddy children. $A$ reasons: *"If I don't have mud, then the others see only $k - 1$ muddy children total, and by the inductive hypothesis they would have raised their hands on round $k - 1$."* Rounds 1 through $k - 1$ pass without anyone raising a hand. This silence is itself informative — it tells $A$ that their assumption was wrong. The only consistent conclusion is: $A$ also has mud. On round $k$, all $k$ muddy children simultaneously reach this conclusion and raise their hands.

### The Critical Role of the Announcement

**Key insight**: the puzzle fails entirely if the teacher does not make the public announcement.

Suppose $k = 2$: Alice and Bob both have mud. Even before the announcement:
- Alice sees Bob's mud and knows $k \geq 1$.
- Bob sees Alice's mud and knows $k \geq 1$.
- But does Alice know that Bob knows $k \geq 1$? Alice does not know whether she herself has mud. She considers the world where she is clean — in that world, Bob sees no mud, so Bob would not know $k \geq 1$.

So although *everyone* already knows $k \geq 1$ before the announcement, it is **not** common knowledge that $k \geq 1$. The announcement does not tell anyone a new fact — Alice already knew at least one person had mud. What the announcement does is **publicly establish** that everyone knows it, that everyone knows that everyone knows it, and so on to infinite depth. This is the definition of common knowledge, and it is what makes coordinated action possible.

This is the key lesson: common knowledge cannot be created by each node individually observing the same fact. It requires a **public, simultaneous, observable act** — and in a network where messages can be lost, such acts are impossible.

### Differences from Distributed Systems

| Property | Muddy Foreheads Puzzle | Distributed Systems |
|---|---|---|
| **Timing** | Synchronous; rounds advance in lockstep | Asynchronous; messages arrive at unpredictable times |
| **Communication** | Children cannot directly talk | Nodes communicate via message passing |
| **Observation** | Children directly see each other's state | Nodes must explicitly exchange messages to learn remote state |
| **Failures** | No failures modeled | Nodes crash; messages are dropped, duplicated, or delayed |

The synchronous round structure is what makes the puzzle solvable. Remove it, and you get the asynchronous case studied in distributed systems — where, as we will see, common knowledge becomes impossible.

---

## Kinds of Knowledge

The following hierarchy formalizes what a node or group of nodes can "know." These levels are ordered from weakest to strongest and are critical for reasoning about what coordination is achievable.

Let $G$ be a group of nodes and $\phi$ be a proposition about system state.

| Notation | Name | Meaning |
|---|---|---|
| $D_G(\phi)$ | **Distributed knowledge** | If you pooled all knowledge in $G$, the group could collectively derive $\phi$. No single node may know $\phi$ alone. |
| $S_G(\phi)$ | **Someone knows** | At least one node in $G$ knows $\phi$. |
| $K_i(\phi)$ | **Individual knowledge** | Node $i$ knows $\phi$. Satisfies the truth axiom: $K_i(\phi) \rightarrow \phi$. |
| $E_G(\phi)$ | **Everyone knows** | Every node in $G$ knows $\phi$. |
| $E_G^k(\phi)$ | **$k$-th order everyone knows** | ("Everyone knows")$^k$ of $\phi$. $E_G^2(\phi)$ means everyone knows that everyone knows $\phi$. |
| $C_G(\phi)$ | **Common knowledge** | $\phi$ is common knowledge in $G$. The strongest level. |

The hierarchy is strict: each level implies the weaker ones but not the stronger ones. $E_G(\phi)$ (everyone knows) does not imply $C_G(\phi)$ (common knowledge).

### Formal Definition of Common Knowledge

$$C_G(\phi) \equiv \bigwedge_{k=1}^{\infty} E_G^k(\phi)$$

Common knowledge is the infinite conjunction of all levels of iterated everyone-knows. $\phi$ is common knowledge if and only if everyone knows it, everyone knows that everyone knows it, everyone knows that everyone knows that everyone knows it, and so on without bound.

### Simplified Explanation

Common knowledge is "it's out in the open." Everyone knows it, knows that others know it, knows that others know that others know it — to infinite depth. There is no point in the chain where someone might be unsure whether someone else knows.

### Why the Infinite Conjunction Matters: The $k = 2$ Case

With just two nodes — Alice ($A$) and Bob ($B$) — and proposition $m$ = "someone is muddy":

**Before the teacher speaks:**
- $E_G m$ holds: Both see a muddy forehead. Everyone knows $m$ is true.
- $E_G^2 m$ **fails**: Alice knows Bob has mud. But does Alice know that Bob knows $m$? Alice does not know if she herself has mud. She considers the possibility that she is clean. In that hypothetical world, Bob sees only clean foreheads and would not know $m$. So Alice cannot conclude that Bob knows $m$. Therefore $E_G^2 m$ is false.

Since $E_G^2 m$ fails, $C_G m$ fails. The infinite conjunction is broken at $k = 2$.

**After the announcement:**
The teacher's public proclamation is heard simultaneously by all children in the same instant. This creates $C_G m$ at once — not by adding new propositional facts, but by creating a shared, publicly observable event that everyone knows everyone witnessed.

### The Knowledge Axioms

The knowledge operators obey several important axioms (from the Halpern-Moses epistemic logic framework):

- **Truth**: $K_i(\phi) \rightarrow \phi$ — if node $i$ knows $\phi$, then $\phi$ is true. Knowledge is veridical; you cannot "know" a false proposition.
- **Positive introspection**: $K_i(\phi) \rightarrow K_i(K_i(\phi))$ — if you know something, you know that you know it.
- **Negative introspection**: $\neg K_i(\phi) \rightarrow K_i(\neg K_i(\phi))$ — if you don't know something, you know that you don't know it.
- **Distribution**: $K_i(\phi \rightarrow \psi) \rightarrow (K_i(\phi) \rightarrow K_i(\psi))$ — knowledge distributes over implication.

These axioms define what it means to be a rational epistemic agent, and they govern how the muddy foreheads induction works at each step.

---

## How Protocols Climb the Knowledge Hierarchy

Distributed protocols are, at their core, procedures for **elevating knowledge** from weaker to stronger forms. Two fundamental operations dominate:

1. **Gathering ($D_G \phi \rightsquigarrow S_G \phi$)**: Collecting distributed information to a single node. Example: a coordinator in a two-phase commit collects votes from all participants. Before gathering, the answer is distributed (each node holds part of the truth). After gathering, one node has the full picture. This does not yet achieve $E_G \phi$ because the other nodes do not yet know the outcome.

2. **Publishing ($K_i \phi \rightsquigarrow E_G \phi$)**: One node broadcasts a fact to the group. Example: the [[CSE452/Primary-Backup/View Server|View Server]] announces a new view — once all nodes receive the announcement, $E_G \phi$ holds for that view change fact. However, a broadcast over an unreliable network only achieves $E_G \phi$ if delivery is guaranteed. With possible message loss, some nodes may not receive the broadcast, so not even $E_G \phi$ is guaranteed.

Notice that no combination of gathering and publishing in an unreliable network can achieve $C_G \phi$ — the impossibility result below explains exactly why.

---

## Impossibility of Coordinated Attack

The **Coordinated Attack Problem** (also called the **Two Generals Problem**) is a direct application of the knowledge hierarchy to distributed systems. It proves that common knowledge is impossible to achieve over an unreliable network.

**Theorem**: If $C_G \phi$ holds at any point during an execution over an unreliable channel, then $\phi$ must have been common knowledge at the very start — before any messages were sent. In other words, **communication over an unreliable channel cannot create new common knowledge**.

### Setup

- Two armies, $A$ and $B$, wish to coordinate an attack.
- If both attack simultaneously, they win. If only one attacks, they lose disastrously.
- The only communication channel is via **unreliable messengers** — a messenger may be captured (message dropped) at any time, and the sender receives no indication of delivery.
- Both generals must decide: **attack** or **retreat**.

### Proof by Indistinguishable Executions

This proof uses the standard technique of **indistinguishable executions** — two executions look identical from one node's perspective but have different outcomes, so no protocol can be correct in both.

1. Assume for contradiction that a correct protocol $P$ exists — one that achieves coordinated attack despite unreliable communication.

2. Consider a run of $P$ in which $n$ messages are sent and all are delivered. Both generals attack. This run must exist by assumption (otherwise the protocol never coordinates).

3. Now consider a run that is identical except the final message (say $A \to B$) is dropped. From $A$'s perspective, these two runs are **indistinguishable** — $A$ sent the message in both, and $A$ receives no acknowledgement either way. Therefore $A$ must make the same decision in both runs: $A$ attacks.

4. Since $A$ attacks in the run where the last message was dropped, $B$ must also attack (otherwise the protocol fails). But $B$ has not received the last message. From $B$'s perspective, the run where the last message was dropped is indistinguishable from a run where no message arrived at all.

5. By induction, we can drop messages one at a time from the end. At each step, the behavior of one general is fixed (they cannot distinguish whether the message was received), forcing the other's behavior. Eventually we reach a run with zero messages, but both generals still attack.

6. But in the zero-message run, no information has been exchanged. The decision to attack was fixed before any communication. This means the protocol is **trivial** — it does not actually depend on communication.

7. A trivial protocol cannot be correct in general: if both generals always attack regardless of communication, they will also attack when the other has failed and cannot attack, leading to a loss. Contradiction.

**Conclusion**: No correct protocol exists. Coordinated attack over an unreliable channel is impossible.

### Formal Definition

The formal statement: for any execution $\alpha$ of any protocol $P$ over an unreliable channel, and any fact $\phi$ about the execution, $C_G(\phi)$ at time $t$ implies $C_G(\phi)$ at time $0$. Communication over unreliable channels is **informationally inert** with respect to common knowledge.

### Simplified Explanation

You cannot ever be sure the other side got your message. So you cannot be sure they know you're ready to attack. And they cannot be sure you know they're ready. This uncertainty has no bottom — it recurses forever. The only way to guarantee coordination would be infinitely many confirmations, which is impossible. Common knowledge cannot be created by sending messages that might be dropped.

### Connection to Knowledge Theory

The proof directly mirrors the impossibility of creating $C_G \phi$ over an unreliable channel. At the moment of attack, both generals must have common knowledge that both are attacking. But as the proof shows, no finite sequence of messages over an unreliable channel can ever establish that infinite chain of mutual knowledge. The last message is always unacknowledged; the penultimate message cannot confirm the last one was received; and so on.

This is why the [[CSE452/Primary-Backup/Primary Backup|Primary-Backup]] protocol does not try to achieve perfect coordination — it tolerates the impossibility by using the [[CSE452/Primary-Backup/View Server|View Server]] as an approximate arbiter, accepting the possibility of brief unavailability rather than attempting to achieve common knowledge among replicas.

---

## Consensus and the FLP Impossibility Result

**Consensus** is the problem of getting all nodes in a distributed system to agree on a single value. It is perhaps the most studied problem in distributed systems, and its difficulty is a direct consequence of the knowledge hierarchy.

### The Problem Formally

A consensus protocol must satisfy:
- **Validity**: Every decided value was proposed by some node.
- **Agreement**: No two nodes decide on different values.
- **Integrity**: A node decides at most once.
- **Termination** (liveness): Every correct node eventually decides.

### Approaches to Consensus

**Majority voting**: each node proposes a value; the value with a strict majority of votes is chosen. This ensures *something* gets decided (as long as a majority of nodes participate), but it requires a synchronous model or additional rounds to handle concurrent proposals and failures correctly.

**Leader-based**: one node collects proposals, picks a value, and broadcasts the decision. Simple, but the leader is a single point of failure — if the leader crashes mid-protocol, the decision may never be reached. See [[CSE452/Paxos/Paxos|Paxos]] for the solution to this problem.

### FLP Impossibility

**Theorem (Fischer, Lynch, Paterson 1985)**: In a purely asynchronous distributed system where even one process may crash, there is no deterministic protocol that guarantees consensus (satisfies all four properties, including termination) in all executions.

The structure of the FLP proof mirrors the coordinated attack proof exactly:
1. Assume a correct protocol $P$ exists.
2. There must be a "bivalent" initial configuration — one where the protocol has not yet been forced to a particular outcome.
3. From any bivalent configuration, the adversary can delay or drop the right message to keep the system in a bivalent state indefinitely — preventing any node from safely deciding.
4. By choosing which messages to delay, the adversary can always maintain ambiguity. No node can distinguish "the other node is slow" from "the other node has crashed."

This is the asynchronous analogue of the coordinated attack impossibility: because a slow node is indistinguishable from a crashed node, a node can never have common knowledge that "all other nodes have made the same decision." Any protocol that terminates can be tricked into producing incorrect results by the adversary who controls message timing.

### Formal Definition

Formally: in a purely asynchronous model, for any deterministic protocol $P$ and any execution $\alpha$, if one process may fail, then there exists an admissible execution $\alpha'$ in which $P$ does not terminate. No protocol satisfies both Agreement and Termination in all admissible executions.

### Simplified Explanation

In an async system, "this node hasn't responded" always means "maybe it crashed, or maybe it's just slow." You can never tell the difference. So you can never safely declare consensus, because the silent node might come back and disagree. The only way to be safe is to keep waiting — but then you never terminate. Safety and liveness are fundamentally at odds under asynchrony with failures.

### Practical Implications

FLP does not mean consensus is useless — it means consensus under *pure* asynchrony with crashes is impossible. Real systems escape FLP by:
- Assuming **partial synchrony** (messages eventually arrive within a time bound). Under this assumption, [[CSE452/Paxos/Paxos|Paxos]] and [[CSE452/Paxos/Multi-Paxos|Multi-Paxos]] achieve consensus in the common case.
- Using **failure detectors** (oracles that provide eventually-accurate information about which nodes are alive). A perfect failure detector collapses the problem to the synchronous case.
- Accepting **probabilistic termination** rather than guaranteed termination.

---

## Summary: The Knowledge Hierarchy and Protocol Design

The knowledge hierarchy provides a precise vocabulary for analyzing what coordination is achievable:

| Goal | Knowledge Required | Achievable? |
|---|---|---|
| One node has the answer | $K_i(\phi)$ | Yes — gather information locally |
| All nodes have the answer | $E_G(\phi)$ | Yes — broadcast (with reliable delivery) |
| All nodes know others have the answer | $E_G^2(\phi)$ | Only with reliable, synchronous delivery |
| Common knowledge | $C_G(\phi)$ | No — impossible over unreliable channels |

This table explains the design space of distributed protocols. Systems that appear to "coordinate" (e.g., Paxos, primary-backup, two-phase commit) do not actually achieve $C_G(\phi)$ — they achieve weaker guarantees and use majority quorums, view servers, or timeouts to approximate coordination while remaining safe. See [[CSE452/Paxos/Paxos Invariants|Paxos Invariants]] for how Paxos achieves safety despite only guaranteeing majority overlap, not common knowledge.

---

## Related

- [[CSE452/Clocks/Logical Clocks|Logical Clocks]] — the happens-before relation is the prerequisite for reasoning about what events a node can have known; a node cannot know an event occurred unless it is causally downstream of a message from the source
- [[CSE452/Clocks/System State|System State]] — stable properties and invariants in distributed systems; the distinction between stable and unstable properties mirrors the distinction between facts that are common knowledge vs. facts that are only transiently known
- [[CSE452/RPC/Fault Model|Fault Model]] — the failure model (dropped and delayed messages, crash-stop nodes) is precisely what makes common knowledge impossible to achieve
- [[CSE452/Primary-Backup/Primary Backup|Primary-Backup Replication]] — a practical protocol that works around coordination limits by using a view server to approximate common knowledge of the system's configuration
- [[CSE452/Primary-Backup/View Server|View Server]] — the view server's role is to be the single node that "publishes" view changes, performing the $K_i \phi \rightsquigarrow E_G \phi$ step; it cannot achieve $C_G \phi$ but approximates it under normal operation
- [[CSE452/Paxos/Paxos|Paxos]] — the industrial-strength consensus protocol that escapes FLP by assuming partial synchrony and using majority quorums
- [[CSE452/Paxos/Paxos Invariants|Paxos Invariants]] — how Paxos maintains safety without requiring common knowledge among all acceptors
- [[CSE452/RPC/Introduction to DS|Introduction to Distributed Systems]] — the broader context of why distributed systems are hard and what problems they solve

**Academic Sources**: Halpern, J. and Moses, Y. (1990). "Knowledge and Common Knowledge in a Distributed Environment." *Journal of the ACM*, 37(3), 549–587. Fischer, M., Lynch, N., and Paterson, M. (1985). "Impossibility of Distributed Consensus with One Faulty Process." *Journal of the ACM*, 32(2), 374–382.
