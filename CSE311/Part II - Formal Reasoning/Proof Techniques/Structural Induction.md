# CSE 311: Structural Induction

**Structural induction** is a proof technique used to prove that a property $P(x)$ holds for every element $x$ in a [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Recursive Definition of Sets|recursively defined set]] $S$. Rather than inducting on integers (as in [[CSE311/Part II - Formal Reasoning/Proof Techniques/Induction|mathematical induction]]), we induct on the structure of the elements themselves, following the same recursive rules used to define $S$.

**To prove $\forall x \in S,\ P(x)$:**

**Base Case**: Show that $P(u)$ is true for all specific elements $u$ of $S$ mentioned in the Basis step of the recursive definition.

**Induction Hypothesis**: Assume that $P$ is true for some arbitrary values of each of the existing named elements mentioned in the Recursive step.

**Induction Step**: Prove that $P(w)$ holds for each of the **new elements** $w$ constructed in the Recursive step, using the named elements for which the Induction Hypothesis was assumed.

**Conclude**: That $\forall x \in S,\ P(x)$.

Structural induction is the natural way to prove facts about [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|lists]], [[CSE311/Part I - Mathematical Foundations/Data Structures/Rooted Binary Tree Definition|rooted binary trees]], the [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Set of Strings|set of strings]] $\Sigma^*$, and any other [[CSE311/Part I - Mathematical Foundations/Data Structures/Inductive Data Types|inductive data type]] — including the recursive [[CSE311/Part I - Mathematical Foundations/Functions/Functions on Lists|functions]] defined over them.

## Related

- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Recursive Definition of Sets|Recursive Definition of Sets]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Induction|Induction]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Strong Induction|Strong Induction]]
- [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|List of Integers]]
- [[CSE311/Part I - Mathematical Foundations/Data Structures/Rooted Binary Tree Definition|Rooted Binary Tree Definition]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions on Lists|Functions on Lists]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Structural induction | Structural induction / recursion induction |
| Base case | Basis element case |
| Induction step | Constructor case |
