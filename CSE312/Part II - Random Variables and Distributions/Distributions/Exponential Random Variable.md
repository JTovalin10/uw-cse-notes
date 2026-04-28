# Exponential Random Variable

A continuous random variable $X$ representing the waiting time until the first occurrence of an event, when the events occur continuously and independently at a constant average rate $\lambda$.

**Notation:** $X \sim \text{Exp}(\lambda)$

**Probability Density Function (PDF):**
$$f_X(k) = \begin{cases} \lambda e^{-\lambda k} & \text{if } k \ge 0 \\ 0 & \text{otherwise} \end{cases}$$

**Cumulative Distribution Function (CDF):**
$$F_X(k) = \begin{cases} 1 - e^{-\lambda k} & \text{if } k \ge 0 \\ 0 & \text{otherwise} \end{cases}$$

**Expectation:**
$$\mathbb{E}[X] = \frac{1}{\lambda}$$

**Variance:**
$$\text{Var}(X) = \frac{1}{\lambda^2}$$

**Properties:**
- Exponential random variables are **memoryless** in continuous time: $\mathbb{P}(X \ge s + t \mid X \ge s) = \mathbb{P}(X \ge t)$
