# CSE 312: Binomial Distribution

A **binomial distribution** is a [[Random Variables|random variable]] $X$ representing the number of successes in $n$ independent [[Bernoulli Distribution|Bernoulli]] trials, each with probability $p$ of success.

**Notation:** $X \sim \text{Bin}(n, p)$

**Probability Mass Function (PMF):**
$$p_X(k) = \binom{n}{k} p^k (1 - p)^{n - k} \quad \text{for } k \in \{0, 1, \dots, n\}$$

The [[Number of Subsets Formula|binomial coefficient]] $\binom{n}{k}$ counts which of the $n$ trials are the successful ones, and $p^k(1-p)^{n-k}$ is the probability of any one such arrangement.

**Expectation:**
$$\mathbb{E}[X] = np$$

**Variance:**
$$\text{Var}(X) = np(1 - p)$$

Because a binomial variable is a sum of $n$ independent Bernoulli variables, its expectation and variance follow directly from [[Linearity of Expectation]] and the additivity of [[Variance]] for independent random variables.

## Related
- [[Bernoulli Distribution]]
- [[Negative Binomial Distribution]]
- [[Poisson Distribution]]
- [[Hypergeometric Distribution]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Binomial Distribution** → standard statistics term; the $n$ independent trials are called a "binomial experiment" or "Bernoulli process."
