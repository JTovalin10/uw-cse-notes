# CSE 311: Set of Strings ($\Sigma^*$)

The **set of strings** $\Sigma^*$ over the [[Strings|alphabet]] $\Sigma$ is defined recursively, following the basis-plus-recursive-step pattern of a [[Recursive Definition of Sets|recursive set definition]].

- Example: $\{0,1\}^*$ contains all binary strings:
	- $0, 1, 01, 10, 11, 000, 001, \ldots$

$$\Sigma^* \text{ is defined as:}$$
$$\text{Basis: } \varepsilon \in \Sigma^* \quad (\varepsilon \text{ is the empty string "")}$$
$$\text{Recursion: if } w \in \Sigma^* \text{ and } a \in \Sigma,\ \text{then } wa \in \Sigma^*$$

The recursion says: take any existing string $w$ and append any character $a$ from the alphabet — the result $wa$ is also in $\Sigma^*$.

A **language** is any subset of $\Sigma^*$, and [[Regular Expressions|regular expressions]] describe particular such subsets. Recursive functions over $\Sigma^*$ are covered in [[Functions on a Set of Strings|Functions on a Set of Strings]].

## Related

- [[Strings|Strings]]
- [[Recursive Definition of Sets|Recursive Definition of Sets]]
- [[Regular Expressions|Regular Expressions]]
- [[Functions on a Set of Strings|Functions on a Set of Strings]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $\Sigma^*$ (set of strings) | Kleene closure / Kleene star of the alphabet |
| Subset of $\Sigma^*$ | Formal language |
| $\varepsilon$ (empty string) | `""` |
