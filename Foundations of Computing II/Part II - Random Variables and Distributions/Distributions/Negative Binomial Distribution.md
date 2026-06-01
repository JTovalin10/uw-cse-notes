# CSE 312: Negative Binomial Distribution

A **negative binomial distribution** is a [[Random Variables|random variable]] $X$ representing the number of independent trials needed until exactly $r$ successes are observed, where each trial has success probability $p$.

**Notation:** $X \sim \text{NegBin}(r, p)$

**Probability Mass Function (PMF):**
$$p_X(k) = \binom{k - 1}{r - 1} p^r (1 - p)^{k - r}$$

The trial $k$ must itself be a success, and the [[Number of Subsets Formula|binomial coefficient]] $\binom{k-1}{r-1}$ counts the ways to place the other $r-1$ successes among the first $k-1$ trials.

**Expectation:**
$$\mathbb{E}[X] = \frac{r}{p}$$

**Variance:**
$$\text{Var}(X) = \frac{r(1 - p)}{p^2}$$

## Relationship to Geometric

A negative binomial random variable is the sum of $r$ independent identically distributed [[Geometric Distribution|geometric]] random variables: $X = Z_1 + \dots + Z_r$ where each $Z_i \sim \text{Geo}(p)$. This is why its expectation and variance are exactly $r$ times those of a single geometric variable.

## Related
- [[Geometric Distribution]]
- [[Binomial Distribution]]
- [[Bernoulli Distribution]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Negative Binomial Distribution** → standard statistics term, also called the "Pascal distribution" when $r$ is a positive integer.
