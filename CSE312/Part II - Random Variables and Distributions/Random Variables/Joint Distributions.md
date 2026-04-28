# CSE 312: Joint Distributions

When dealing with multiple random variables that are not necessarily independent, we use joint distributions to model their behavior together.

## Joint PMF
For two discrete random variables $X, Y$, their joint probability mass function (PMF) is:
$$p_{X,Y}(x, y) = \mathbb{P}(X = x \cap Y = y)$$

If $X$ and $Y$ are independent, then their joint PMF is the product of their marginals:
$$p_{X,Y}(x, y) = p_X(x)p_Y(y)$$

## Marginal Distributions
To find the distribution of just $X$ from the joint PMF, we use the law of total probability to "marginalize out" $Y$:
$$p_X(x) = \sum_{y} p_{X,Y}(x, y)$$

## Joint Expectation
For a function of two random variables $g(X,Y)$, the expected value is:
$$\mathbb{E}[g(X,Y)] = \sum_{x \in \Omega_X} \sum_{y \in \Omega_Y} g(x,y) \cdot p_{X,Y}(x,y)$$

## Conditional Expectation
The expectation of $X$ given that event $E$ has occurred:
$$\mathbb{E}[X|E] = \sum_{x \in \Omega_X} x \cdot \mathbb{P}(X = x|E)$$
$$\mathbb{E}[X|Y=y] = \sum_{x \in \Omega_X} x \cdot \mathbb{P}(X = x|Y = y)$$

**Law of Total Expectation (LTE):**
Let $A_1, A_2, \ldots, A_k$ be a partition of the sample space:
$$\mathbb{E}[X] = \sum_{i=1}^n \mathbb{E}[X|A_i]\mathbb{P}(A_i)$$
For discrete RVs $X, Y$:
$$\mathbb{E}[X] = \sum_{y \in \Omega_Y} \mathbb{E}[X|Y=y]\mathbb{P}(Y=y)$$

## Continuous Joint Distributions
Everything we saw for discrete has a continuous analogue:
- Replace PMF with PDF: $f_{X,Y}(x, y)$
- Replace sums with integrals: 
  - **Marginal PDF:** $f_X(x) = \int_{-\infty}^{\infty} f_{X,Y}(x,y) dy$

## Covariance
Covariance measures how much $X$ and $Y$ "vary together" linearly.
$$\text{Cov}(X,Y) = \mathbb{E}[(X - \mathbb{E}[X])(Y - \mathbb{E}[Y])] = \mathbb{E}[XY] - \mathbb{E}[X]\mathbb{E}[Y]$$

- If $X$ and $Y$ are independent, $\text{Cov}(X,Y) = 0$. (Note: $\text{Cov}(X,Y)=0$ does *not* imply independence).
- $\text{Var}(X+Y) = \text{Var}(X) + \text{Var}(Y) + 2\text{Cov}(X,Y)$

## Related
- [[Discrete Random Variables]]
- [[Continuous Random Variable]]
- [[Expectation]]
- [[Variance]]