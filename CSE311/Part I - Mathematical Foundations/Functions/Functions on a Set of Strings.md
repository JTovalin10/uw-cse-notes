# CSE 311: Functions on a Set of Strings

Recursive functions defined on $\Sigma^*$ (see [[Set of Strings]]).

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

- [[Set of Strings]]
- [[Strings]]
- [[Functions on Lists]]
- [[Structural Induction]]
- [[Functions]]
