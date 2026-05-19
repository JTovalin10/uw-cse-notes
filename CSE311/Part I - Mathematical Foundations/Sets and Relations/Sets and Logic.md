# CSE 311: Sets and Logic

[[CSE311/Part I - Mathematical Foundations/Sets and Relations/What is a Set|Sets]] and [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|predicates]] are two sides of the same coin — every set defines a predicate, and every predicate defines a set.

- **Building predicates from sets**: every set $S$ defines a predicate $P(x) := x \in S$
- **Building sets from predicates**: given a predicate $P(x)$, we can define $S := \{x : P(x)\}$

## The Meta Theorem

Translate any Propositional Logic equivalence into an "$=$" relationship between sets by replacing:
- $\lor$ with $\cup$
- $\land$ with $\cap$
- $\neg$ with $^C$ (complement)

**Example:**
$\neg(A \lor B) \equiv \neg A \land \neg B$ becomes $(A \cup B)^C = A^C \cap B^C$

This correspondence means that reasoning about set membership is equivalent to reasoning about truth values of predicates, so logical tools (conjunction, disjunction, negation, quantifiers) apply directly to [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Operations on Sets|set operations]].

## Related

- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/What is a Set|What is a Set]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|What is a Predicate]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Operations on Sets|Operations on Sets]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Set-builder $\{x : P(x)\}$ | List/set comprehension |
| Predicate $P(x) := x \in S$ | Membership test |
| The Meta Theorem | Set-logic duality |
