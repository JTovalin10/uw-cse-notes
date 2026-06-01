# CSE 311: Functions on a Set of Strings

Recursive **functions** defined on $\Sigma^*$, the [[Set of Strings|set of strings]] over an alphabet. Each function has one equation for the basis (the empty string $\varepsilon$) and one for the recursive step (a string $wa$ ending in character $a$), mirroring the recursive definition of $\Sigma^*$. This is the string analogue of [[Functions on Lists|functions on lists]].

## Length

$$\text{len}(\varepsilon) := 0$$
$$\text{len}(wa) := \text{len}(w) + 1 \quad \text{for } w \in \Sigma^*,\ a \in \Sigma$$

## Concatenation

$$x \bullet \varepsilon := x \quad \text{for } x \in \Sigma^*$$
$$x \bullet wa := (x \bullet w)a \quad \text{for } x \in \Sigma^*,\ a \in \Sigma$$

## Reversal

$$\varepsilon^R := \varepsilon$$
$$(wa)^R := a \bullet w^R \quad \text{for } w \in \Sigma^*,\ a \in \Sigma$$

## Number of Occurrences of Character $c$

$$\#_c(\varepsilon) := 0$$
$$\#_c(wc) := \#_c(w) + 1 \quad \text{for } w \in \Sigma^*$$
$$\#_c(wa) := \#_c(w) \quad \text{for } w \in \Sigma^*,\ a \in \Sigma,\ a \neq c$$

## Related

- [[Set of Strings|Set of Strings]]
- [[Strings|Strings]]
- [[Functions on Lists|Functions on Lists]]
- [[Foundations of Computing I/Part II - Formal Reasoning/Proof Techniques/Structural Induction|Structural Induction]]
- [[Foundations of Computing I/Part I - Mathematical Foundations/Functions/Functions|Functions]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $\text{len}$ | String length / `.length` |
| $\bullet$ (concatenation) | String concatenation / `+` |
| $w^R$ (reversal) | `reverse()` |
| $\#_c$ | Character count / `count(c)` |
