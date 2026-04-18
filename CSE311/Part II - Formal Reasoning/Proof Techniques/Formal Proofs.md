# CSE 311: Formal Proof Rules

#Definition **Elim Or**:
Since we know $A \lor B$ is true, we determine which disjunct holds.
$$
\text{A holds, thus:} \quad A \lor B \quad \text{Elim Or} \Rightarrow A
$$
$$
\text{Not A holds, thus:} \quad A \lor B \quad \text{Elim Or} \Rightarrow B
$$

#Definition **Elim And**:
Since we know both conjuncts hold, we can extract either one.
$$
A \land B \quad \Rightarrow A
$$
$$
A \land B \quad \Rightarrow B
$$

#Definition **Intro And**:
To introduce a conjunction $P \land G$, we must prove both $P$ and $G$ are true independently.
$$
\text{Given G:} \quad P \Rightarrow P \land G
$$
$$
\text{Given G:} \quad P \Rightarrow G \land P
$$

#Definition **Intro Or**:
If we know $P$ is true, we can introduce any disjunction involving $P$, since the disjunction will always be true.
$$
P \Rightarrow P \lor Q
$$
$$
P \Rightarrow Q \lor P
$$

#Definition **Modus Ponens**:
Given $P \rightarrow Q$, if we know $P$ is true, then $Q$ is true.

#Definition **Direct Proof**:
To prove $P \Rightarrow Q$, assume $P$ and then show $Q$ follows. This corresponds to the logical implication $P \rightarrow Q$.
$$
P \Rightarrow Q \quad = \quad P \rightarrow Q
$$

#Definition **Equivalent**:
If we are given $A \equiv B$ and we know $B$ holds, then $A$ holds as well (and vice versa).

#Definition **Cases**:
If we have $A \lor B$, $A \rightarrow C$, and $B \rightarrow C$, we can conclude $C$.
$$
A \lor B;\quad A \rightarrow C;\quad B \rightarrow C \quad \Rightarrow \quad C
$$

## Related

- [[Logical Equivalence(s)]]
- [[Induction]]
- [[Proof by Calculation]]
- [[Formal and Informal]]