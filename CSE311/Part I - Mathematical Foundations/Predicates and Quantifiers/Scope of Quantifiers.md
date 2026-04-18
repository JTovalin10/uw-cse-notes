# CSE 311: Scope of Quantifiers

The **scope** of a quantifier determines which variables it binds and over what part of the formula it applies. Binding the same variable in different parts of a formula is not the same as binding it once across the whole formula.

$$\exists x(P(x) \land Q(x)) \quad \neq \quad (\exists x\, P(x)) \land (\exists x\, Q(x))$$

- **Left-hand side**: asserts that $P(x)$ and $Q(x)$ hold for the *same* $x$.
- **Right-hand side**: $P(x)$ and $Q(x)$ each have their own (potentially different) witness for $x$.

## Related

- [[What are Quantifiers]]
- [[What is a Predicate]]
- [[Translating Predicates with Quantifiers]]
