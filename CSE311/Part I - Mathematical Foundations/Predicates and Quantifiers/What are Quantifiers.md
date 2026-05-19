# CSE 311: Quantifiers

A **quantifier** turns a [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|predicate]] (which has no truth value on its own) into a proposition (which does) by stating *how many* elements of the domain satisfy it.

- $\forall x, P(x)$ — "for every $x$, $P$ of $x$"
	- The **universal quantifier** asserts that $P(x)$ holds for *all* $x$ in the domain.
- $\exists x, P(x)$ — "there exists an $x$ such that $P$ of $x$"
	- The **existential quantifier** asserts that there is *at least one* $x$ in the domain for which $P(x)$ holds.

The two quantifiers are duals of each other under negation, as captured by [[CSE311/Part I - Mathematical Foundations/Logic/DeMorgans Laws|De Morgan's Laws]].

## Related

- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|What is a Predicate]]
- [[CSE311/Part I - Mathematical Foundations/Logic/DeMorgans Laws|DeMorgans Laws]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/Scope of Quantifiers|Scope of Quantifiers]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/Translating Predicates with Quantifiers|Translating Predicates with Quantifiers]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Inference Rules for Quantifiers|Inference Rules for Quantifiers]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Universal quantifier ($\forall$) | "for all" / `all()` |
| Existential quantifier ($\exists$) | "there exists" / `any()` |
