# CSE 311: Functions on Lists

Recursive functions defined on the [[List of Integers]] type.

## Length

$$\text{len}(\text{nil}) := 0$$
$$\text{len}(a \mathbin{::} L) := \text{len}(L) + 1 \quad \text{for any } L \in \text{List},\ a \in \mathbb{Z}$$

## Concatenation

$$\text{concat}(\text{nil},\ R) := R \quad \text{for any } R \in \text{List}$$
$$\text{concat}(a \mathbin{::} L,\ R) := a \mathbin{::} \text{concat}(L,\ R) \quad \text{for any } R \in \text{List},\ a \in \mathbb{Z}$$

## Related

- [[List of Integers]]
- [[Lists]]
- [[Structural Induction]]
- [[Functions on a Set of Strings]]
- [[Functions]]
- [[What is a Set]]
