# CSE 311: Greatest Common Divisor (GCD)

#Definition **GCD Theorem**: For integers $a, b$ with $a > 0$, there exists a unique integer $n$ such that:
1. $n \mid a$ and $n \mid b$
2. For all $d$, if $d \mid a$ and $d \mid b$, then $d \le n$.

We denote this unique number as $n = \gcd(a, b)$.

## Euclid's Algorithm

**Useful Fact**: Let $a$ and $b$ be positive integers. We have $\gcd(a,b) = \gcd(b, a \bmod b)$.

We can repeatedly use this fact to reduce the numbers until we get $\gcd(g, 0) = g$, which gives us the greatest common divisor.

## Related

- [[Divides]]
- [[Extended Euclid]]
