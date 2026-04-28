# CSE 311: Scope of Quantifiers

The **scope** of a quantifier determines which variables it binds and over what part of the formula it applies. Binding the same variable in different parts of a formula is not the same as binding it once across the whole formula.

$$\exists x(P(x) \land Q(x)) \quad \neq \quad (\exists x\, P(x)) \land (\exists x\, Q(x))$$

- **Left-hand side**: asserts that $P(x)$ and $Q(x)$ hold for the *same* $x$.
- **Right-hand side**: $P(x)$ and $Q(x)$ each have their own (potentially different) witness for $x$.

## Nested Quantifiers

Bound variable names don't matter:
$$\forall x \exists y P(x, y) \equiv \forall a \exists b P(a, b)$$

Positions of quantifiers of the *same type* can sometimes change without changing meaning:
$$\forall x \forall y P(x, y) \equiv \forall y \forall x P(x, y)$$

However, **order is important** for mixed quantifiers:
- $\forall x \exists y P(x, y)$: For every $x$, we can find a specific $y$ (the $y$ can depend on the $x$).
- $\exists y \forall x P(x, y)$: We can find ONE $y$ that works for every $x$ (the $y$ must be the same for all $x$).

## Related

- [[What are Quantifiers]]
- [[What is a Predicate]]
- [[Translating Predicates with Quantifiers]]
