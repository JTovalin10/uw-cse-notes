# CSE 312: Normal Random Variable

#Definition A **normal random variable** (also called a Gaussian) is a [[Continuous Random Variable|continuous random variable]] with mean $\mu$ and variance $\sigma^2$, written as:

$$X \sim N(\mu, \sigma^2)$$

It has the density:

$$f_X(x) = \frac{1}{\sigma \sqrt{2\pi}} \cdot e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$

## Standardization

In order to **standardize** a normal random variable:

$$X \sim N(\mu, \sigma^2) \rightarrow Y \sim N(0, 1)$$

we use the transformation:

$$Y = \frac{X - \mu}{\sigma}$$

## Expectation and Variance

$$E[X] = \mu$$

$$Var(X) = \sigma^2$$

## Attributes
- The CDF doesn't have a closed form, so we cannot calculate it directly — use a z-table instead.
- It can be shifted left or right by changing $\mu$, and stretched or compressed by changing $\sigma^2$.

The standardized variable $Y \sim N(0,1)$ is exactly what makes z-tables possible: by the [[Central Limit Theorem]], sums of many independent random variables become approximately normal, so a single z-table answers questions about any normal random variable.

## Related
- [[Continuous Random Variable]]
- [[Central Limit Theorem]]
- [[Confidence Intervals]]
- [[Cumulative Distribution Function]]
- [[Expectation]]
- [[Variance]]

## Industry Standard Terms

- **Normal Random Variable** → "Gaussian distribution" / "bell curve." $N(0,1)$ is the "standard normal," and converting to it is "standardization" or computing a "z-score."

