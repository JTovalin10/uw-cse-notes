# CSE 311: Truth Tables

For each column, use $2^{n-1}$ to determine the T/F placement, where $n$ is the column's position from the right (starting at 1).

- Example: $a = 2^{2-1} = 2$, so T appears every 2 rows; $b = 2^{1-1} = 1$, so T alternates every row.

| a   | b   |
| --- | --- |
| T   | T   |
| T   | F   |
| F   | T   |
| F   | F   |

## Implication

With implication ($p \rightarrow q$), $p$ is called the "premise" and $q$ is called the "conclusion". It is true when $p$ and $q$ are true, and is vacuously true when $p$ is false.

Other ways to express $p \rightarrow q$:
- $p$ implies $q$
- if $p$, then $q$
- $q$ if $p$
- $p$ only if $q$
- $p$ is sufficient for $q$
- $q$ is necessary for $p$

### Converse, Contrapositive, and Inverse

- **Converse**: $q \rightarrow p$
- **Contrapositive**: $\neg q \rightarrow \neg p$
- **Inverse**: $\neg p \rightarrow \neg q$

The **contrapositive** of a conditional has the same truth value as the original statement ($p \rightarrow q \equiv \neg q \rightarrow \neg p$). The **converse** and **inverse** do not necessarily have the same truth value as the original implication.

## Related

- [[Tautologies]]
- [[Logical Equivalence(s)]]
- [[Normal Form]]
- [[Boolean Algebra]]
