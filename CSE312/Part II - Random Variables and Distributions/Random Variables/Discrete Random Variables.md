# CSE 312: Discrete Random Variables

#Definition A **discrete random variable** takes on a countable set of values. The probability of an event being 0 is the same as it being impossible.

- Relative Chances
	- PMF: $p_X(k) = P(X = k)$
- Events
	- Sum over the PMF to get probability
- Convert from CDF to PMF
	- Look for "breakpoints" in the CDF to recover the PMF
- Convert PMF to CDF
	- Sum up the PMF to get the CDF

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
