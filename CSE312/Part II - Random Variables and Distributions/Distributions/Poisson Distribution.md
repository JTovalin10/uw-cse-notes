# Poisson Distribution

A random variable $X$ used to model the number of incidents occurring in a fixed interval of time or space, when incidents happen independently and the average number of incidents in that interval is $\lambda$.

**Notation:** $X \sim \text{Poi}(\lambda)$

**Probability Mass Function (PMF):**
$$p_X(k) = \frac{\lambda^k e^{-\lambda}}{k!} \quad \text{for } k \in \mathbb{N}$$

**Expectation:**
$$\mathbb{E}[X] = \lambda$$

**Variance:**
$$\text{Var}(X) = \lambda$$

**Relationship to Binomial:**
The Poisson is a limit of the Binomial distribution as $n \to \infty$ and $p \to 0$ such that $np = \lambda$ stays constant.
