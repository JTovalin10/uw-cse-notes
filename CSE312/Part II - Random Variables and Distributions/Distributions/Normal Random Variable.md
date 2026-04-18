# CSE 312: Normal Random Variable

#Definition A **normal random variable** (also called a Gaussian) has mean $\mu$ and variance $\sigma^2$, written as:

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
- Doesn't have a closed form, so we cannot calculate the CDF directly (use a z-table instead)
- It can be shifted left or right by changing $\mu$

## Related
- [[Continuous Random Variable]]
- [[Central Limit Theorem]]
- [[Confidence Intervals]]
- [[Expectation]]
- [[Variance]]
