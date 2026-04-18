# CSE 311: Extended Euclidean Algorithm

#Definition **Extended Euclid** standard form:
$$Ax \equiv_m B$$

When we want to find the **multiplicative inverse** $y$ of $b \pmod{n}$, i.e. $b \cdot y \equiv_n 1$, the answer should satisfy $0 \leq y < n$.

## Algorithm

The recurrence is:
$$\gcd(a, b) \Rightarrow \gcd(b,\ a \bmod b)$$
where $a$ and $b$ are drawn from the values in the equation. To begin, set $a$ to whichever of the two values is larger.

Examples:
$$5y \equiv_{33} 1 \quad \Rightarrow \quad \gcd(33, 5)$$
$$100y \equiv_{15} 1 \quad \Rightarrow \quad \gcd(100, 15)$$

## Forward Pass (Division Steps)

Repeatedly apply:
$$\gcd(a, b) \quad := \quad a = bk + c$$
$$\gcd(b, c) \quad := \quad b = cj + d$$
$$\gcd(c, d) \quad := \quad c = di + e$$

Continue until reaching:
$$m = n \cdot 1 + 0$$

## Backward Pass (Back-Substitution)

Backtrack starting from the step where the remainder equals $1$ (i.e. $e = 1$):
$$e = c - di \quad \Rightarrow \quad e = c - (b - cj) \cdot i \quad \text{(substitute } d\text{)}$$
$$c - (cj + d) \cdot i \quad \Rightarrow \quad c - cji - (b - cj)i \quad \text{(substitute } d\text{)}$$

Continue substituting until reaching the first division step $a = bj + c$.

## Final Step

Using the example $13y \equiv_{12} n$, after back-substitution we should have a result in the form:
$$1 = 13 \cdot m + 12 \cdot k$$

Taking $\bmod 12$ eliminates the second term:
$$1 = 13 \cdot m + 0 \quad \Rightarrow \quad 13^{-1} \equiv_{12} m$$

We then use this to solve for $y$:
$$13y \equiv_{12} n \quad \Rightarrow \quad y \equiv_{12} n \cdot 13^{-1} \quad \Rightarrow \quad y \equiv_{12} n \cdot m$$

## General Solution

After completing every step and obtaining $y \equiv_m n$, the **general solution** is:
$$y = m \cdot k + n$$

## Related

[[Modulo]] · [[Divides]] · [[N-Bit Integer Representation]]
