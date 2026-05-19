# CSE 311: Translating Predicates with Quantifiers

Tips for translating English statements into predicate logic, using [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|predicates]] and [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What are Quantifiers|quantifiers]]:

1. Notice **"domain restriction"** patterns — words like "all cats" or "some integer" restrict which elements the quantifier ranges over. Capture these as an antecedent (for $\forall$) or a conjunction (for $\exists$).
2. **Avoid unnecessary variable names** — only introduce a variable when it needs to be referred to later in the formula.
3. **You can drop "all" and "there is"** when the quantifier symbol already makes the meaning clear.

The reason domain restriction uses an antecedent for $\forall$ but a conjunction for $\exists$ is the same asymmetry that appears in [[CSE311/Part I - Mathematical Foundations/Logic/DeMorgans Laws|De Morgan's Laws]] for quantifiers.

## Related

- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What is a Predicate|What is a Predicate]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/What are Quantifiers|What are Quantifiers]]
- [[CSE311/Part I - Mathematical Foundations/Predicates and Quantifiers/Scope of Quantifiers|Scope of Quantifiers]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Domain restriction | Guard / bounded quantification |
| Antecedent | Precondition / `if` guard |
