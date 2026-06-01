# CSE 311: Divisibility

## Formal Definition

#Definition $a \mid b$ (read "$a$ **divides** $b$") means there exists an integer $k$ such that $b = ak$.
$$a \mid b \quad \Rightarrow \quad b = ak, \quad \exists k \in \mathbb{Z}$$

## Simplified Explanation

$a$ divides $b$ if $b$ is an exact integer multiple of $a$ with no remainder left over.

Example:
$$2 \mid 10 \quad \Rightarrow \quad 10 = 2k \quad \text{(k = 5 is the solution)}$$

Divisibility is the foundation for [[Modulo|modular arithmetic]] (congruence is defined as $m \mid a - b$), the [[Division Theorem|Division Theorem]], and the [[GCD|GCD]].

## Related

- [[Modulo|Modulo]]
- [[Division Theorem|Division Theorem]]
- [[GCD|GCD]]
- [[Extended Euclid|Extended Euclid]]
- [[What is a Set|What is a Set]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $a \mid b$ (divides) | Divisibility / `b % a == 0` |
| Exact integer multiple | Even division / no remainder |
