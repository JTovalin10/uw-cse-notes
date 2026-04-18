# CSE 312: Cumulative Distribution Function (CDF)

#Definition The **CDF** (Cumulative Distribution Function) gives the probability that $X \leq x$:

$$F_X(x) = \sum_{i \leq x} p_X(i)$$

Best used for making conditional probability calculations.

## Example

$$F_X(x) = \begin{cases} 0 & \text{if } x < 3 \\ x/3 & \text{if } 3 \leq x < 20 \\ 0 & \text{otherwise} \end{cases}$$

## Related
- [[Probability Mass Function]]
- [[Discrete Random Variables]]
- [[Continuous Random Variable]]
