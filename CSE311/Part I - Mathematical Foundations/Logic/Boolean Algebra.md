# CSE 311: Boolean Algebra

**Boolean algebra** uses a compact **notation** to express logical operators, treating logic as an algebra of $+$ and $\cdot$. The following equivalences show how standard logic symbols map to Boolean algebra symbols:

- $\neg p \quad \equiv \quad p'$ — negation is written as a prime.
- $p \land q \quad \equiv \quad p \cdot q$ — conjunction (AND) behaves like multiplication.
- $p \lor q \quad \equiv \quad p + q$ — disjunction (OR) behaves like addition.

This product/sum analogy is why many [[CSE311/Part I - Mathematical Foundations/Logic/Logical Equivalence(s)|logical equivalences]] (identity, domination, distributive) look like ordinary arithmetic identities.

## Related

- [[CSE311/Part I - Mathematical Foundations/Logic/Logical Equivalence(s)|Logical Equivalence(s)]]
- [[CSE311/Part I - Mathematical Foundations/Logic/DeMorgans Laws|DeMorgans Laws]]
- [[CSE311/Part I - Mathematical Foundations/Logic/Digital Circuits|Digital Circuits]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Boolean algebra | Boolean logic |
| $p'$ (negation) | NOT / `!` / `~` |
| $p \cdot q$ | AND / `&&` / `&` |
| $p + q$ | OR / `||` / `|` |
