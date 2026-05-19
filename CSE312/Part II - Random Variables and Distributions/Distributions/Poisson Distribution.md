# CSE 312: Poisson Distribution

A **Poisson distribution** is a [[Random Variables|random variable]] $X$ used to model the number of incidents occurring in a fixed interval of time or space, when incidents happen independently and the average number of incidents in that interval is $\lambda$.

**Notation:** $X \sim \text{Poi}(\lambda)$

**Probability Mass Function (PMF):**
$$p_X(k) = \frac{\lambda^k e^{-\lambda}}{k!} \quad \text{for } k \in \mathbb{N}$$

**Expectation:**
$$\mathbb{E}[X] = \lambda$$

**Variance:**
$$\text{Var}(X) = \lambda$$

A defining feature is that the mean and variance are both equal to $\lambda$.

## Relationship to Binomial

The Poisson is a limit of the [[Binomial Distribution|binomial distribution]] as $n \to \infty$ and $p \to 0$ such that $np = \lambda$ stays constant. This is why it models rare events counted over a large number of opportunities.

## Related
- [[Binomial Distribution]]
- [[Exponential Random Variable]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Poisson Distribution** → standard statistics term; a stream of events whose counts are Poisson and whose gaps are [[Exponential Random Variable|exponential]] is called a "Poisson process."
