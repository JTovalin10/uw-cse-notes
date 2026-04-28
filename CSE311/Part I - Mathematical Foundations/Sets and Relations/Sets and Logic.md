# CSE 311: Sets and Logic

Sets and predicates are two sides of the same coin — every set defines a predicate, and every predicate defines a set.

- **Building predicates from sets**: every set $S$ defines a predicate $P(x) := x \in S$
- **Building sets from predicates**: given a predicate $P(x)$, we can define $S := \{x : P(x)\}$

## The Meta Theorem

Translate any Propositional Logic equivalence into an "$=$" relationship between sets by replacing:
- $\lor$ with $\cup$
- $\land$ with $\cap$
- $\neg$ with $^C$ (complement)

**Example:**
$\neg(A \lor B) \equiv \neg A \land \neg B$ becomes $(A \cup B)^C = A^C \cap B^C$

This correspondence means that reasoning about set membership is equivalent to reasoning about truth values of predicates, so logical tools (conjunction, disjunction, negation, quantifiers) apply directly to set operations.

## Related

- [[What is a Set]]
- [[What is a Predicate]]
- [[Operations on Sets]]
