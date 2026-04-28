# Negative Binomial Distribution

A random variable $X$ representing the number of independent trials needed until exactly $r$ successes are observed, where each trial has success probability $p$.

**Notation:** $X \sim \text{NegBin}(r, p)$

**Probability Mass Function (PMF):**
$$p_X(k) = \binom{k - 1}{r - 1} p^r (1 - p)^{k - r}$$

**Expectation:**
$$\mathbb{E}[X] = \frac{r}{p}$$

**Variance:**
$$\text{Var}(X) = \frac{r(1 - p)}{p^2}$$

**Relationship to Geometric:**
A Negative Binomial random variable is the sum of $r$ independent identically distributed Geometric random variables: $X = Z_1 + \dots + Z_r$ where $Z_i \sim \text{Geo}(p)$.
