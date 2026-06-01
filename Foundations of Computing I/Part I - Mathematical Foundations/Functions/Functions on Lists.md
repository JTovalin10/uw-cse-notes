# CSE 311: Functions on Lists

Recursive **functions** defined on the [[List of Integers|List of Integers]] type. Each function has one equation for the basis (`nil`) and one for the recursive step (`a :: L`), mirroring the recursive definition of the List type. This is the list analogue of [[Functions on a Set of Strings|functions on a set of strings]].

## Length

$$\text{len}(\text{nil}) := 0$$
$$\text{len}(a \mathbin{::} L) := \text{len}(L) + 1 \quad \text{for any } L \in \text{List},\ a \in \mathbb{Z}$$

## Concatenation

$$\text{concat}(\text{nil},\ R) := R \quad \text{for any } R \in \text{List}$$
$$\text{concat}(a \mathbin{::} L,\ R) := a \mathbin{::} \text{concat}(L,\ R) \quad \text{for any } R \in \text{List},\ a \in \mathbb{Z}$$

## Related

- [[List of Integers|List of Integers]]
- [[Lists|Lists]]
- [[Foundations of Computing I/Part II - Formal Reasoning/Proof Techniques/Structural Induction|Structural Induction]]
- [[Functions on a Set of Strings|Functions on a Set of Strings]]
- [[Foundations of Computing I/Part I - Mathematical Foundations/Functions/Functions|Functions]]
- [[What is a Set|What is a Set]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $\text{len}$ | List length / `.size()` |
| $\text{concat}$ | List concatenation / `+` / `extend` |
