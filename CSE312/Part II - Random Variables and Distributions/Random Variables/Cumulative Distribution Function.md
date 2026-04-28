# CSE 312: Cumulative Distribution Function (CDF)

#Definition The **CDF** (Cumulative Distribution Function) gives the probability that $X \leq x$:

$$F_X(x) = \sum_{i \leq x} p_X(i)$$

Best used for making conditional probability calculations.

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
