# CSE 312: Hypergeometric Distribution

A **hypergeometric distribution** is a [[Random Variables|random variable]] $X$ representing the number of successful items drawn from a population of size $N$ that contains $K$ successful items, when $n$ items are drawn **without replacement**.

**Notation:** $X \sim \text{HypGeo}(N, K, n)$

**Probability Mass Function (PMF):**
$$p_X(k) = \frac{\binom{K}{k}\binom{N - K}{n - k}}{\binom{N}{n}}$$

The numerator counts ways to pick $k$ successes from the $K$ successful items and $n-k$ failures from the $N-K$ remaining items; the denominator counts all ways to draw $n$ items.

**Expectation:**
$$\mathbb{E}[X] = n\frac{K}{N}$$

**Variance:**
$$\text{Var}(X) = n \frac{K}{N} \frac{N - K}{N} \frac{N - n}{N - 1}$$

The extra factor $\frac{N-n}{N-1}$ compared to the [[Binomial Distribution|binomial]] variance is the *finite population correction*: drawing without replacement makes the draws dependent, which reduces variance.

## Related
- [[Binomial Distribution]]
- [[Number of Subsets Formula]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Hypergeometric Distribution** → standard statistics term; sampling **without replacement**, in contrast to the binomial's sampling **with replacement**. The factor $\frac{N-n}{N-1}$ is the "finite population correction (FPC)."
