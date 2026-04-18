# CSE 312: Variance

#Definition The **variance** of a random variable $X$ measures how spread out its values are around the mean:
$$Var(X) = \sum_w P(w)(X(w) - E[X])^2 = E[X^2] - (E[X])^2$$

Furthermore, if $X$ and $Y$ are independent then:
$$Var(X + Y) = Var(X) + Var(Y)$$

Some facts about Variance:
- $Var(X + c) = Var(X)$
- $Var(aX) = a^2 \cdot Var(X)$

## Related
- [[Random Variables]]
- [[Expectation]]
- [[Standard Deviation]]
- [[Covariance]]
