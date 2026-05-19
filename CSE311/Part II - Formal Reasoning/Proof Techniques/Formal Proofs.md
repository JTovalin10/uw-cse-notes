# CSE 311: Formal Proof Rules

A **formal proof** derives a conclusion by chaining together **inference rules** — small, mechanically-checkable steps. Each rule below either *eliminates* a connective (extracting information from a known fact) or *introduces* one (building a new fact). These are the propositional rules; the quantifier versions appear in [[CSE311/Part II - Formal Reasoning/Proof Techniques/Inference Rules for Quantifiers|Inference Rules for Quantifiers]].

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

## Latin Rules

#Definition **Principium Contradictionis**:
Given $\neg A$ and $A$, we can conclude a contradiction ($F$).
$$
\neg A; A \quad \Rightarrow \quad F
$$

#Definition **Reductio Ad Absurdum**:
If assuming $A$ leads to a contradiction ($F$), we can conclude $\neg A$.
$$
A \Rightarrow F \quad \Rightarrow \quad \neg A
$$

#Definition **Ex Falso Quodlibet**:
From a contradiction ($F$), we can conclude anything ($A$).
$$
F \quad \Rightarrow \quad A
$$

#Definition **Ad Litteram Verum**:
We can always conclude True ($T$).
$$
\quad \Rightarrow \quad T
$$

## Related

- [[CSE311/Part I - Mathematical Foundations/Logic/Logical Equivalence(s)|Logical Equivalence(s)]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Induction|Induction]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Proof by Calculation|Proof by Calculation]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Formal and Informal|Formal and Informal]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Inference Rules for Quantifiers|Inference Rules for Quantifiers]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Inference rule | Rule of inference / natural deduction rule |
| Modus Ponens | Implication elimination |
| Reductio Ad Absurdum | Proof by contradiction |
| Ex Falso Quodlibet | Principle of explosion |