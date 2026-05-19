# CSE 312: Geometric Distribution

A **geometric distribution** is a [[Random Variables|random variable]] $X$ representing the number of independent trials needed until the first success, where each trial has success probability $p$.

**Notation:** $X \sim \text{Geo}(p)$

**Probability Mass Function (PMF):**
$$p_X(k) = (1 - p)^{k - 1}p \quad \text{for } k \in \{1, 2, 3, \dots\}$$

The factor $(1-p)^{k-1}$ is the probability of $k-1$ consecutive failures, and the final $p$ is the success on trial $k$.

**Expectation:**
$$\mathbb{E}[X] = \frac{1}{p}$$

**Variance:**
$$\text{Var}(X) = \frac{1 - p}{p^2}$$

## Properties

Geometric random variables are **memoryless**:
$$\mathbb{P}(X \ge s + t \mid X \ge s) = \mathbb{P}(X \ge t)$$

### Simplified Explanation

Memorylessness means past failures give you no information about the future. If you have already failed $s$ times, the number of additional trials still needed is distributed exactly as if you were starting fresh — the process does not "remember" how long you have been waiting.

## Related
- [[Bernoulli Distribution]]
- [[Negative Binomial Distribution]]
- [[Exponential Random Variable]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Geometric Distribution** → standard statistics term. Note a competing convention counts the number of *failures before* the first success ($k \in \{0,1,2,\dots\}$); this course counts the *trial of* the first success ($k \in \{1,2,3,\dots\}$).
- The discrete-time **memoryless** property is the discrete analogue of the [[Exponential Random Variable|exponential]]'s continuous-time memorylessness.
