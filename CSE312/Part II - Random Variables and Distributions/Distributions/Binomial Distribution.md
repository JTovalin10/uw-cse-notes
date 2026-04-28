# Binomial Distribution

A random variable $X$ representing the number of successes in $n$ independent Bernoulli trials, each with probability $p$ of success.

**Notation:** $X \sim \text{Bin}(n, p)$

**Probability Mass Function (PMF):**
$$p_X(k) = \binom{n}{k} p^k (1 - p)^{n - k} \quad \text{for } k \in \{0, 1, \dots, n\}$$

**Expectation:**
$$\mathbb{E}[X] = np$$

**Variance:**
$$\text{Var}(X) = np(1 - p)$$
