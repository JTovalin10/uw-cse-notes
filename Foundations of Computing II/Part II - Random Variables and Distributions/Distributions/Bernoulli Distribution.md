# CSE 312: Bernoulli Distribution

A **Bernoulli distribution** is an [[Indicator Random Variable|indicator random variable]] $X$ representing a single trial with probability $p$ of success. $X = 1$ if the trial succeeds, $X = 0$ if it fails.

**Notation:** $X \sim \text{Ber}(p)$

**Probability Mass Function (PMF):**
$$p_X(1) = p$$
$$p_X(0) = 1 - p$$

**Expectation:**
$$\mathbb{E}[X] = p$$

**Variance:**
$$\text{Var}(X) = p(1 - p)$$

The Bernoulli is the simplest non-trivial distribution and serves as the building block for the [[Binomial Distribution]] (a sum of $n$ independent Bernoulli trials).

## Related
- [[Indicator Random Variable]]
- [[Binomial Distribution]]
- [[Geometric Distribution]]
- [[Probability Mass Function]]

## Industry Standard Terms

- **Bernoulli Distribution** → standard statistics term; a single Bernoulli trial is also called a "Bernoulli experiment." Identical to an indicator/0-1 random variable.
