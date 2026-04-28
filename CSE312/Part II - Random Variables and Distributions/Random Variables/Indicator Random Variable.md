# CSE 312: Indicator Random Variables

#Definition An **indicator random variable** $\mathbf{1}[A]$ (also written as $1_A$ or $I_A$) is a random variable that indicates whether an event $A$ occurred.

$$\mathbf{1}[A] = \begin{cases} 1 & \text{if event } A \text{ occurs} \\ 0 & \text{otherwise} \end{cases}$$

The expectation of an indicator random variable is simply the probability of the event:
$$\mathbb{E}[\mathbf{1}[A]] = \mathbb{P}(A)$$

Indicator random variables are incredibly useful for computing the expectation of complicated random variables. By decomposing a random variable into a sum of indicator variables, we can use the [[Linearity of Expectation]] to solve it easily.

## Related
- [[Random Variables]]
- [[Expectation]]
- [[Linearity of Expectation]]
