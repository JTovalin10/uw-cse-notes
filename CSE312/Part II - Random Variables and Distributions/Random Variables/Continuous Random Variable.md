# CSE 312: Continuous Random Variables

#Definition A **continuous random variable** takes on values over a continuous range. All impossible events have probability 0, but the inverse isn't true — an event can have probability 0 and still be possible.

- Relative Chances
	- **PDF** (**Probability Density Function**): $f_X(k)$ gives the chance relative to $f_X(k')$
- Events
	- Integrate over the PDF to get probability
- Convert from CDF to PDF
	- Take the derivative of the CDF
- Convert PDF to CDF
	- Integrate the PDF

## Expectation

$$E[X] = \int_{-\infty}^{\infty} z \cdot f_X(z) \, dz$$

$$E[g(X)] = \int_{-\infty}^{\infty} g(z) \cdot f_X(z) \, dz$$

## Variance

$$Var(X) = E[X^2] - E[X]^2 = \int_{-\infty}^{\infty} (z - E[X])^2 \cdot f_X(z) \, dz$$

## Related
- [[Discrete Random Variables]]
- [[Cumulative Distribution Function]]
- [[Normal Random Variable]]
- [[Expectation]]
- [[Variance]]
