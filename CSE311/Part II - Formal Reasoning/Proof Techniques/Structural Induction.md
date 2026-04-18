# CSE 311: Structural Induction

**Structural induction** is a proof technique used to prove that a property $P(x)$ holds for every element $x$ in a recursively defined set $S$. Rather than inducting on integers, we induct on the structure of the elements themselves, following the same recursive rules used to define $S$.

**To prove $\forall x \in S,\ P(x)$:**

**Base Case**: Show that $P(u)$ is true for all specific elements $u$ of $S$ mentioned in the Basis step of the recursive definition.

**Induction Hypothesis**: Assume that $P$ is true for some arbitrary values of each of the existing named elements mentioned in the Recursive step.

**Induction Step**: Prove that $P(w)$ holds for each of the **new elements** $w$ constructed in the Recursive step, using the named elements for which the Induction Hypothesis was assumed.

**Conclude**: That $\forall x \in S,\ P(x)$.

## Related

- [[Recursive Definition of Sets]]
- [[Induction]]
- [[Strong Induction]]
- [[List of Integers]]
- [[Rooted Binary Tree Definition]]
- [[Functions on Lists]]
