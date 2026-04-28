# CSE 312: Pascal's Rule

**Pascal's Rule** (or Pascal's Identity) is a combinatorial identity about combinations.

$$\binom{n}{k} = \binom{n-1}{k-1} + \binom{n-1}{k}$$

## Intuition (Proof by Double Counting)

Suppose you and $n-1$ other people are trying out for a $k$-person team. We can count the number of possible teams in two different ways:

**Way 1:** There are $n$ people total, and we are choosing $k$ of them. The total number of teams is $\binom{n}{k}$.

**Way 2:** There are two types of teams:
- Teams that include you. If you make the team, we need to choose $k-1$ more people from the remaining $n-1$ people. There are $\binom{n-1}{k-1}$ such teams.
- Teams that don't include you. If you don't make the team, we need to choose all $k$ people from the remaining $n-1$ people. There are $\binom{n-1}{k}$ such teams.

By the sum rule, the total number of teams is $\binom{n-1}{k-1} + \binom{n-1}{k}$.

Since both ways count the exact same thing, the expressions must be equal: $\binom{n}{k} = \binom{n-1}{k-1} + \binom{n-1}{k}$.

## Related

- [[Binomial Theorem]]
- [[Sum Rule]]
- [[Number of Subsets Formula|Combinations]]
