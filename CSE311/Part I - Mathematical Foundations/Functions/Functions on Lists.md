# CSE 311: Functions on Lists

Recursive **functions** defined on the [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|List of Integers]] type. Each function has one equation for the basis (`nil`) and one for the recursive step (`a :: L`), mirroring the recursive definition of the List type. This is the list analogue of [[CSE311/Part I - Mathematical Foundations/Functions/Functions on a Set of Strings|functions on a set of strings]].

## Length

$$\text{len}(\text{nil}) := 0$$
$$\text{len}(a \mathbin{::} L) := \text{len}(L) + 1 \quad \text{for any } L \in \text{List},\ a \in \mathbb{Z}$$

## Concatenation

$$\text{concat}(\text{nil},\ R) := R \quad \text{for any } R \in \text{List}$$
$$\text{concat}(a \mathbin{::} L,\ R) := a \mathbin{::} \text{concat}(L,\ R) \quad \text{for any } R \in \text{List},\ a \in \mathbb{Z}$$

## Related

- [[CSE311/Part I - Mathematical Foundations/Data Structures/List of Integers|List of Integers]]
- [[CSE311/Part I - Mathematical Foundations/Data Structures/Lists|Lists]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Structural Induction|Structural Induction]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions on a Set of Strings|Functions on a Set of Strings]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions|Functions]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/What is a Set|What is a Set]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $\text{len}$ | List length / `.size()` |
| $\text{concat}$ | List concatenation / `+` / `extend` |
