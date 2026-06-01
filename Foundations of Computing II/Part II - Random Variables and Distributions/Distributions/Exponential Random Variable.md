# CSE 312: Exponential Random Variable

An **exponential random variable** is a [[Continuous Random Variable|continuous random variable]] $X$ representing the waiting time until the first occurrence of an event, when events occur continuously and independently at a constant average rate $\lambda$.

**Notation:** $X \sim \text{Exp}(\lambda)$

**Probability Density Function (PDF):**
$$f_X(k) = \begin{cases} \lambda e^{-\lambda k} & \text{if } k \ge 0 \\ 0 & \text{otherwise} \end{cases}$$

**Cumulative Distribution Function (CDF):**
$$F_X(k) = \begin{cases} 1 - e^{-\lambda k} & \text{if } k \ge 0 \\ 0 & \text{otherwise} \end{cases}$$

**Expectation:**
$$\mathbb{E}[X] = \frac{1}{\lambda}$$

**Variance:**
$$\text{Var}(X) = \frac{1}{\lambda^2}$$

## Properties

Exponential random variables are **memoryless** in continuous time:
$$\mathbb{P}(X \ge s + t \mid X \ge s) = \mathbb{P}(X \ge t)$$

### Simplified Explanation

Having already waited $s$ units of time tells you nothing about how much longer you must wait. The remaining wait is distributed exactly as a fresh wait — the process does not age. The exponential is the continuous-time counterpart of the [[Geometric Distribution|geometric distribution]], which has the same memoryless property in discrete time.

## Related
- [[Continuous Random Variable]]
- [[Geometric Distribution]]
- [[Poisson Distribution]]
- [[Cumulative Distribution Function]]

## Industry Standard Terms

- **Exponential Random Variable** → standard statistics term; it models the inter-arrival times of a "Poisson process," and $\lambda$ is the "rate parameter."
