# CSE 311: Division Theorem

## Formal Definition

#Definition The **Division Theorem** states: for integers $a$ and $b$ with $b > 0$, there exist *unique* integers $q$ and $r$ with $0 \le r < b$ such that:
$$a = qb + r$$

- $q$ is called the **quotient** ($q = a \text{ div } b$).
- $r$ is called the **remainder** ($r = a \bmod b$).

## Simplified Explanation

Dividing $a$ by $b$ always yields exactly one whole-number quotient and exactly one leftover remainder, and that remainder is always between $0$ and $b - 1$.

The remainder $r$ is what [[Modulo|modular arithmetic]] is built on, and when $r = 0$ we have exactly the [[Divides|divides]] relationship $b \mid a$.

## Related

- [[Modulo|Modulo]]
- [[Divides|Divides]]
- [[GCD|GCD]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Division Theorem | Euclidean division / division algorithm |
| Quotient ($a \text{ div } b$) | Integer division / `a // b` |
| Remainder ($a \bmod b$) | Modulo / `a % b` |
