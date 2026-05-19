# CSE 311: Set of Strings ($\Sigma^*$)

The **set of strings** $\Sigma^*$ over the [[CSE311/Part II - Formal Reasoning/Automata and Languages/Strings|alphabet]] $\Sigma$ is defined recursively, following the basis-plus-recursive-step pattern of a [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Recursive Definition of Sets|recursive set definition]].

- Example: $\{0,1\}^*$ contains all binary strings:
	- $0, 1, 01, 10, 11, 000, 001, \ldots$

$$\Sigma^* \text{ is defined as:}$$
$$\text{Basis: } \varepsilon \in \Sigma^* \quad (\varepsilon \text{ is the empty string "")}$$
$$\text{Recursion: if } w \in \Sigma^* \text{ and } a \in \Sigma,\ \text{then } wa \in \Sigma^*$$

The recursion says: take any existing string $w$ and append any character $a$ from the alphabet — the result $wa$ is also in $\Sigma^*$.

A **language** is any subset of $\Sigma^*$, and [[CSE311/Part II - Formal Reasoning/Automata and Languages/Regular Expressions|regular expressions]] describe particular such subsets. Recursive functions over $\Sigma^*$ are covered in [[CSE311/Part I - Mathematical Foundations/Functions/Functions on a Set of Strings|Functions on a Set of Strings]].

## Related

- [[CSE311/Part II - Formal Reasoning/Automata and Languages/Strings|Strings]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Recursive Definition of Sets|Recursive Definition of Sets]]
- [[CSE311/Part II - Formal Reasoning/Automata and Languages/Regular Expressions|Regular Expressions]]
- [[CSE311/Part I - Mathematical Foundations/Functions/Functions on a Set of Strings|Functions on a Set of Strings]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $\Sigma^*$ (set of strings) | Kleene closure / Kleene star of the alphabet |
| Subset of $\Sigma^*$ | Formal language |
| $\varepsilon$ (empty string) | `""` |
