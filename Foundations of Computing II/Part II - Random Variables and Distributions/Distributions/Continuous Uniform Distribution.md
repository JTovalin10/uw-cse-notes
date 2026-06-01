# CSE 312: Continuous Uniform Distribution

A **continuous uniform distribution** is a [[Continuous Random Variable|continuous random variable]] $X$ representing a uniformly random real number between $a$ and $b$ — all values in the interval are equally likely.

**Notation:** $X \sim \text{Unif}(a, b)$

**Probability Density Function (PDF):**
$$f_X(k) = \begin{cases} \frac{1}{b - a} & \text{if } a \le k \le b \\ 0 & \text{otherwise} \end{cases}$$

The density is constant over the interval; its height $\frac{1}{b-a}$ is chosen so that the total area under the PDF equals 1.

**Cumulative Distribution Function (CDF):**
$$F_X(k) = \begin{cases} 0 & \text{if } k < a \\ \frac{k - a}{b - a} & \text{if } a \le k \le b \\ 1 & \text{if } k \ge b \end{cases}$$

The [[Cumulative Distribution Function|CDF]] rises linearly across the interval, which is the integral of the constant PDF.

**Expectation:**
$$\mathbb{E}[X] = \frac{a + b}{2}$$

**Variance:**
$$\text{Var}(X) = \frac{(b - a)^2}{12}$$

## Related
- [[Discrete Uniform Distribution]]
- [[Continuous Random Variable]]
- [[Cumulative Distribution Function]]

## Industry Standard Terms

- **Continuous Uniform Distribution** → standard statistics term, also called the "rectangular distribution" because of the flat (rectangular) shape of its PDF.
