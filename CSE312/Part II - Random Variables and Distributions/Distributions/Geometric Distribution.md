# Geometric Distribution

A random variable $X$ representing the number of independent trials needed until the first success, where each trial has success probability $p$.

**Notation:** $X \sim \text{Geo}(p)$

**Probability Mass Function (PMF):**
$$p_X(k) = (1 - p)^{k - 1}p \quad \text{for } k \in \{1, 2, 3, \dots\}$$

**Expectation:**
$$\mathbb{E}[X] = \frac{1}{p}$$

**Variance:**
$$\text{Var}(X) = \frac{1 - p}{p^2}$$

**Properties:**
- Geometric random variables are **memoryless**: $\mathbb{P}(X \ge s + t \mid X \ge s) = \mathbb{P}(X \ge t)$
