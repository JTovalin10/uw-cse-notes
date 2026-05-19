# CSE 312: Linearity of Expectation

For any two [[Random Variables|random variables]] $X$ and $Y$ — they do **not** have to be [[Independence|independent]]:
$$E[X + Y] = E[X] + E[Y]$$

With constants (you can also pull out constants):
$$E[aX + bY + c] = aE[X] + bE[Y] + c$$

### Simplified Explanation

The [[Expectation|expectation]] of a sum is the sum of the expectations, no matter how the variables relate to each other. This is what makes the [[Indicator Random Variable|indicator random variable]] technique so powerful: you can break a complicated random variable into a sum of simple indicators and add up their easy expectations, ignoring any dependence between them.

## Related
- [[Expectation]]
- [[Random Variables]]
- [[Indicator Random Variable]]
- [[Joint Expectation]]

## Industry Standard Terms

- **Linearity of Expectation** → standard term; expectation is a "linear operator" on the space of random variables.

