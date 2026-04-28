# Continuous Uniform Distribution

A continuous random variable $X$ representing a uniformly random real number between $a$ and $b$.

**Notation:** $X \sim \text{Unif}(a, b)$

**Probability Density Function (PDF):**
$$f_X(k) = \begin{cases} \frac{1}{b - a} & \text{if } a \le k \le b \\ 0 & \text{otherwise} \end{cases}$$

**Cumulative Distribution Function (CDF):**
$$F_X(k) = \begin{cases} 0 & \text{if } k < a \\ \frac{k - a}{b - a} & \text{if } a \le k \le b \\ 1 & \text{if } k \ge b \end{cases}$$

**Expectation:**
$$\mathbb{E}[X] = \frac{a + b}{2}$$

**Variance:**
$$\text{Var}(X) = \frac{(b - a)^2}{12}$$
