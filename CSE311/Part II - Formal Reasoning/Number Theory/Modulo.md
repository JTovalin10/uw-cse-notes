# CSE 311: Modular Arithmetic

## Formal Definition

#Definition **Modulo**: For $a, b, m \in \mathbb{Z}$ with $m > 0$, we write $a \equiv_m b$ to mean that $a$ and $b$ are **congruent modulo** $m$.

## Simplified Explanation

Modulo is like a clock — whenever a value reaches $m$ it wraps back to $0$. Two numbers are congruent mod $m$ if they land on the same spot on that clock.

By the definition of congruence:
$$a \equiv_m b \quad \Rightarrow \quad m \mid a - b \quad \text{(Definition of congruence)}$$

Further, by the definition of [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Divides|Divides]], this means:
$$m \mid a - b \quad \Rightarrow \quad a - b = mk, \quad \exists\, k \in \mathbb{Z}$$

**Note**: When $b$ is negative, we add $m$ repeatedly until the result is positive.

Example:
$$5 \equiv_3 -8 \quad \Rightarrow \quad 5 \equiv_3 -8 + 3k \quad \text{(In this case } k = 3 \text{, which gives: } 5 \equiv_3 1\text{)}$$

## Properties of Modular Arithmetic

Let $a, b, c, d$ and $m$ be integers with $m > 0$.

- **Basic Property**: $a \equiv_m b$ if and only if $a \bmod m = b \bmod m$.
- **Addition Property**: If $a \equiv_m b$ and $c \equiv_m d$, then $a + c \equiv_m b + d$.
- **Multiplication Property**: If $a \equiv_m b$ and $c \equiv_m d$, then $ac \equiv_m bd$.
- **Transitivity**: If $a \equiv_m b$ and $b \equiv_m c$, then $a \equiv_m c$.

Solving congruences of the form $ay \equiv_m b$ for $y$ requires a [[CSE311/Part II - Formal Reasoning/Number Theory/Extended Euclid|multiplicative inverse]], which is found with the Extended Euclidean Algorithm.

## Related

- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/Divides|Divides]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/Division Theorem|Division Theorem]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/Extended Euclid|Extended Euclid]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/N-Bit Integer Representation|N-Bit Integer Representation]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Congruence ($a \equiv_m b$) | Modular equality |
| $a \bmod m$ | Modulo operator / `a % m` |
| Modular arithmetic | Clock arithmetic / arithmetic mod n |