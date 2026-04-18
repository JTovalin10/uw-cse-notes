# CSE 311: Modular Arithmetic

#Definition **Modulo**: For $a, b, m \in \mathbb{Z}$ with $m > 0$, we write $a \equiv_m b$ to mean that $a$ and $b$ are **congruent modulo** $m$.

Modulo is like a clock — whenever $b$ reaches $m$ it wraps back to $0$.

By the definition of congruence:
$$a \equiv_m b \quad \Rightarrow \quad m \mid a - b \quad \text{(Definition of congruence)}$$

Further, by the definition of [[Divides]], this means:
$$m \mid a - b \quad \Rightarrow \quad a - b = mk, \quad \exists\, k \in \mathbb{Z}$$

**Note**: When $b$ is negative, we add $m$ repeatedly until the result is positive.

Example:
$$5 \equiv_3 -8 \quad \Rightarrow \quad 5 \equiv_3 -8 + 3k \quad \text{(In this case } k = 3 \text{, which gives: } 5 \equiv_3 1\text{)}$$

## Related

[[Divides]] · [[Extended Euclid]] · [[N-Bit Integer Representation]]