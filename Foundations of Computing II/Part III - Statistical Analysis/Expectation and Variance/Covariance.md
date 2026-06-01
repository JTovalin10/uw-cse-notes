# CSE 312: Covariance

#Definition **Covariance** measures how two [[Random Variables|random variables]] vary together — if $X$ turns out "big," how likely is it that $Y$ will also be "big"?
$$\text{Cov}(X, Y) = \mathbb{E}[(X - \mathbb{E}[X])(Y - \mathbb{E}[Y])] = \mathbb{E}[XY] - \mathbb{E}[X]\mathbb{E}[Y]$$

If $X$ and $Y$ are [[Independence|independent]], then $\text{Cov}(X, Y) = 0$. The converse does **not** hold — a covariance of 0 does not imply independence, only the absence of a *linear* relationship.

## Related
- [[Variance]]
- [[Expectation]]
- [[Independence]]
- [[Joint Expectation]]
- [[Joint Distributions]]

## Industry Standard Terms

- **Covariance** $\text{Cov}(X,Y)$ → standard statistics term; normalizing it by the product of standard deviations gives the "correlation coefficient." $\text{Cov}(X,X) = \text{Var}(X)$.

