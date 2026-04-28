# Hypergeometric Distribution

A random variable $X$ representing the number of successful items drawn from a population of size $N$ that contains $K$ successful items, when $n$ items are drawn **without replacement**.

**Notation:** $X \sim \text{HypGeo}(N, K, n)$

**Probability Mass Function (PMF):**
$$p_X(k) = \frac{\binom{K}{k}\binom{N - K}{n - k}}{\binom{N}{n}}$$

**Expectation:**
$$\mathbb{E}[X] = n\frac{K}{N}$$

**Variance:**
$$\text{Var}(X) = n \frac{K}{N} \frac{N - K}{N} \frac{N - n}{N - 1}$$
