# CSE 312: Continuous Random Variables

#Definition A **continuous random variable** takes on values over a continuous range. All impossible events have probability 0, but the inverse isn't true — an event can have probability 0 and still be possible (this is the key contrast with [[Discrete Random Variables|discrete random variables]]).

- **Relative chances** — the **Probability Density Function (PDF)** $f_X(k)$ gives the chance of $k$ relative to another point $f_X(k')$. A PDF is a density, not a probability, so it can exceed 1.
- **Events** — integrate over the PDF to get the probability of an event.
- **Convert from CDF to PDF** — take the derivative of the [[Cumulative Distribution Function]].
- **Convert PDF to CDF** — integrate the PDF.

## Expectation

$$E[X] = \int_{-\infty}^{\infty} z \cdot f_X(z) \, dz$$

$$E[g(X)] = \int_{-\infty}^{\infty} g(z) \cdot f_X(z) \, dz$$

## Variance

$$Var(X) = E[X^2] - E[X]^2 = \int_{-\infty}^{\infty} (z - E[X])^2 \cdot f_X(z) \, dz$$

## Related
- [[Discrete Random Variables]]
- [[Cumulative Distribution Function]]
- [[Normal Random Variable]]
- [[Continuous Uniform Distribution]]
- [[Exponential Random Variable]]
- [[Expectation]]
- [[Variance]]

## Industry Standard Terms

- **Continuous Random Variable** → standard statistics term; its PDF is the "probability density function." The fact that single points have probability 0 is described by saying the distribution is "absolutely continuous."

