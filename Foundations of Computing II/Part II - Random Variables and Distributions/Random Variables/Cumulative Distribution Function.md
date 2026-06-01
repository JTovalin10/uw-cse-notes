# CSE 312: Cumulative Distribution Function (CDF)

#Definition The **Cumulative Distribution Function (CDF)** gives the probability that $X \leq x$:

$$F_X(x) = \sum_{i \leq x} p_X(i)$$

For a discrete random variable, the CDF is the running sum of the [[Probability Mass Function]] up to and including $x$. It is best used for making [[Conditional Probability|conditional probability]] calculations.

## Properties of CDF
- Defined for all inputs $x \in \mathbb{R}$.
- It is a **non-decreasing** function.
- The values are bounded by probabilities: $0 \leq F_X(x) \leq 1$.
- $\lim_{x \to -\infty} F_X(x) = 0$
- $\lim_{x \to \infty} F_X(x) = 1$

## Example

$$F_X(x) = \begin{cases} 0 & \text{if } x < 3 \\ x/3 & \text{if } 3 \leq x < 20 \\ 1 & \text{if } x \geq 20 \end{cases}$$

## Related
- [[Probability Mass Function]]
- [[Discrete Random Variables]]
- [[Continuous Random Variable]]

## Industry Standard Terms

- **Cumulative Distribution Function (CDF)** → standard statistics term, also called the "distribution function." The complement $1 - F_X(x)$ is the "survival function" or "tail distribution."

