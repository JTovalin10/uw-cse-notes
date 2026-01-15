#Definition Extended Euclid Standard form:
$$
Ax \equiv _{m} B
$$
When we want to find the multiple inverse y of b mod (n) i.e. $b \cdot y \equiv _n 1$ and the answer should lie between $0 \leq y < n$

The formula is: 
gcd(a, b) $\Rightarrow$ gcd(b, a mod(b)), where a and b is either b or n. To begin, a should be whatever b or n is greater
Example:
$$
5y \equiv _{33} 1 \quad \Rightarrow \quad \text{gcd(33,5)}
$$
$$
100y \equiv _{15} 1 \quad \Rightarrow \quad \text{gcd(100,15)}
$$
From here we do this
$$
gcd(a, b) \quad := \quad a = bk + c
$$
$$
gcd(b, c) \quad := \quad b = cj + d
$$$$
gcd(c, d) \quad := \quad c = di + e
$$
We do this until we reach
$$
m = n \cdot 1 + 0
$$
From here we backtrack starting from $c = di+e$ where e = 1
$$
e = c -di \quad \Rightarrow e = c - (cj+d) \cdot i \quad \text{Sub d}
$$
$$
c - (cj+d) \cdot i \quad \Rightarrow \quad c - cji-(b-cj)i \quad \text{sub d}
$$
We will do this until we reach the last sub which in this case is $a=bj+c$

Finally, using $13y \equiv _{12} n$
We should have something in the format like
$$
1 = 13 \cdot m + 12 \cdot k
$$
Taking mod(12) it will result in 
$$
1 = 13 \cdot m + 0 \quad \Rightarrow 13^{-1} = m \text{mod(12)}
$$
Finally, we use this to find y:
$$
13y \equiv _{12} n \quad \Rightarrow y \equiv _{12} n \cdot 13^{-1} \quad \Rightarrow y \equiv _{12} n \cdot m
$$

# General Solution
Finally, doing every step and getting $y \equiv _m n$ we can get a general solution of 
$$
y = m \cdot k + n
$$
### Connections
[[Modulo]]
[[Divides]]
