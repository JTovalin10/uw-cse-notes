# CSE 311: Divisibility

## Formal Definition

#Definition $a \mid b$ (read "$a$ **divides** $b$") means there exists an integer $k$ such that $b = ak$.
$$a \mid b \quad \Rightarrow \quad b = ak, \quad \exists k \in \mathbb{Z}$$

## Simplified Explanation

$a$ divides $b$ if $b$ is an exact integer multiple of $a$ with no remainder left over.

Example:
$$2 \mid 10 \quad \Rightarrow \quad 10 = 2k \quad \text{(k = 5 is the solution)}$$

Divisibility is the foundation for [[CSE311/Part II - Formal Reasoning/Number Theory/Modulo|modular arithmetic]] (congruence is defined as $m \mid a - b$), the [[CSE311/Part II - Formal Reasoning/Number Theory/Division Theorem|Division Theorem]], and the [[CSE311/Part II - Formal Reasoning/Number Theory/GCD|GCD]].

## Related

- [[CSE311/Part II - Formal Reasoning/Number Theory/Modulo|Modulo]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/Division Theorem|Division Theorem]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/GCD|GCD]]
- [[CSE311/Part II - Formal Reasoning/Number Theory/Extended Euclid|Extended Euclid]]
- [[CSE311/Part I - Mathematical Foundations/Sets and Relations/What is a Set|What is a Set]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| $a \mid b$ (divides) | Divisibility / `b % a == 0` |
| Exact integer multiple | Even division / no remainder |
