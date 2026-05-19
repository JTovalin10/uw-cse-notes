# CSE 311: De Morgan's Laws

**De Morgan's Laws** describe how negation distributes across conjunction and disjunction: negating an AND turns it into an OR of negations, and vice versa. The same pattern carries over from [[CSE311/Part I - Mathematical Foundations/Logic/Boolean Algebra|propositional logic]] to [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What are Quantifiers|quantifiers]].

## Propositional Logic

$$\neg (p \land q) \quad \equiv \quad \neg p \lor \neg q$$
$$\neg (p \lor q) \quad \equiv \quad \neg p \land \neg q$$

## Quantifiers

$$\neg \forall x P(x) \quad \equiv \quad \exists x \neg P(x)$$
$$\neg \exists x P(x) \quad \equiv \quad \forall x \neg P(x)$$

### With Domain Restriction

De Morgan's Laws respect domain restrictions by leaving them in place and only negating the other parts:
$$\neg \exists x (P(x) \land R(x)) \quad \equiv \quad \forall x (P(x) \rightarrow \neg R(x))$$
$$\neg \forall x (P(x) \rightarrow R(x)) \quad \equiv \quad \exists x (P(x) \land \neg R(x))$$

The quantifier versions follow the same intuition: "not everything satisfies $P$" is the same as "something fails $P$", and "nothing satisfies $P$" is the same as "everything fails $P$". The set-theoretic counterpart appears in [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Operations on Sets|Operations on Sets]].

## Related

- [[CSE311/Part I - Mathematical Foundations/Logic/Logical Equivalence(s)|Logical Equivalence(s)]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What are Quantifiers|What are Quantifiers]]
- [[CSE311/Part I - Mathematical Foundations/Logic/Boolean Algebra|Boolean Algebra]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Operations on Sets|Operations on Sets]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| De Morgan's Laws | De Morgan duality |
| Domain restriction | Guard / filter condition |
