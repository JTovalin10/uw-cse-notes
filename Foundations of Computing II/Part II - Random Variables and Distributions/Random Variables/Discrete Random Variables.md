# CSE 312: Discrete Random Variables

#Definition A **discrete random variable** takes on a countable set of values. For a discrete random variable, the probability of an event being 0 is the same as it being impossible.

- **Relative chances** — the **[[Probability Mass Function]] (PMF)** gives $p_X(k) = P(X = k)$.
- **Events** — sum over the PMF to get the probability of an event.
- **Convert from CDF to PMF** — look for "breakpoints" in the [[Cumulative Distribution Function]] to recover the PMF.
- **Convert PMF to CDF** — sum up the PMF to get the CDF.

## Expectation

$$E[X] = \sum_{w} X(w) \cdot p_X(w)$$

$$E[g(X)] = \sum_{w} g(X(w)) \cdot p_X(w)$$

## Variance

$$Var(X) = E[X^2] - E[X]^2$$

## Related
- [[Continuous Random Variable]]
- [[Probability Mass Function]]
- [[Cumulative Distribution Function]]
- [[Expectation]]
- [[Variance]]

## Industry Standard Terms

- **Discrete Random Variable** → standard statistics term; its PMF is sometimes called the "discrete density."

