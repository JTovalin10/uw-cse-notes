# CSE 312: Variance

#Definition The **variance** of a [[Random Variables|random variable]] $X$ measures how spread out its values are around the mean (its [[Expectation|expected value]]):
$$Var(X) = \sum_w P(w)(X(w) - E[X])^2 = E[X^2] - (E[X])^2$$

The two forms are equal: the first is the literal "average squared distance from the mean," and the second, $E[X^2] - (E[X])^2$, is the algebraically simplified version that is usually faster to compute.

Furthermore, if $X$ and $Y$ are [[Independence|independent]] then:
$$Var(X + Y) = Var(X) + Var(Y)$$

When $X$ and $Y$ are *not* independent, this picks up a [[Covariance|covariance]] term: $Var(X + Y) = Var(X) + Var(Y) + 2\,Cov(X, Y)$.

Some facts about Variance:
- $Var(X + c) = Var(X)$
- $Var(aX) = a^2 \cdot Var(X)$

## Related
- [[Random Variables]]
- [[Expectation]]
- [[Standard Deviation]]
- [[Covariance]]

## Industry Standard Terms

- **Variance** $Var(X)$ → "second central moment"; often written $\sigma^2$. The identity $Var(X) = E[X^2] - (E[X])^2$ is the "computational formula for variance."

