# CSE 312: Discrete Uniform Distribution

A **discrete uniform distribution** is a [[Random Variables|random variable]] $X$ representing a uniformly random integer between $a$ and $b$ (inclusive) — every integer in that range is equally likely.

**Notation:** $X \sim \text{Unif}(a, b)$

**Probability Mass Function (PMF):**
$$p_X(k) = \frac{1}{b - a + 1} \quad \text{for } k \in \mathbb{Z}, a \le k \le b$$

There are $b - a + 1$ equally likely values, so each receives probability $\frac{1}{b-a+1}$.

**Expectation:**
$$\mathbb{E}[X] = \frac{a + b}{2}$$

**Variance:**
$$\text{Var}(X) = \frac{(b - a)(b - a + 2)}{12}$$

## Related
- [[Continuous Uniform Distribution]]
- [[Probability Mass Function]]
- [[Sample Space and Events]]

## Industry Standard Terms

- **Discrete Uniform Distribution** → standard statistics term; the equal-likelihood assumption is also called the "principle of indifference" or "Laplace model" of probability.
