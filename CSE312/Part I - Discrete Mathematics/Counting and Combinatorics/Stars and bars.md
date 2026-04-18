# CSE 312: Stars and Bars

**Stars and bars** counts the number of ways to distribute $n$ identical objects among $k$ distinct groups, where order within a group does not matter.

$$\binom{n+k-1}{k-1} = \frac{(n+1)(n+2)\cdots(n+k-1)}{(k-1)!}$$

The idea is to think of $n$ stars (objects) separated by $k-1$ bars (dividers between groups); choosing where to place the bars determines the distribution.

## Related

- [[Product Rule]]
- [[Number of Subsets Formula]]
