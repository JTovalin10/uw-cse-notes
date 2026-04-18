# CSE 311: Strong Induction

**Strong induction** is a variant of mathematical induction used when a recursive function or sequence depends on multiple previous values, not just the immediately preceding one. Instead of assuming only $P(k)$, the induction hypothesis assumes $P(j)$ holds for all $j$ in the range $1 \leq j \leq k$.

We use strong induction when we have a recursive function with multiple constant base cases.

**Template:**
- Let $P(n)$ be the property to prove for every integer $n \geq m$.
- **Base Case(s)**: Prove $P$ for each base case required by the recursion.
- **Induction Hypothesis**: Assume $P(j)$ holds for all integers $j$ with $1 \leq j \leq k$, for some integer $k \geq m$.
- **Induction Step**: Prove $P(k+1)$ using the induction hypothesis applied to any $j \leq k$.
- **Conclusion**: Therefore, $P(n)$ holds for all integers $n \geq m$ by strong induction.

## Example

$$
a(1) = 1 \quad a(2) = 3 \quad a(n) = 2a(n-1) - a(n-2), \quad n \geq 3
$$

Use strong induction to prove that $a(n) = 2n - 1$ for all $n \geq 1$.

**Let** $P(n)$ = "$a(n) = 2n - 1$" for every integer $n \geq 1$.

**Base Cases:**
- $n = 1$: By definition, $a(1) = 1 = 2(1) - 1$. $\checkmark$
- $n = 2$: By definition, $a(2) = 3 = 2(2) - 1$. $\checkmark$

**Induction Hypothesis**: Assume $P(j)$ holds for all integers $j$ with $1 \leq j \leq k$, for some integer $k \geq 2$.

**Induction Step**: Prove $P(k+1)$, i.e., show $a(k+1) = 2(k+1) - 1$.

$$
a(k+1) = 2a(k) - a(k-1) \quad \text{(since } k \geq 2 \text{, both } k \text{ and } k-1 \text{ fall within } 1 \leq j \leq k \text{, so we can apply the I.H.)}
$$

$$
2a(k) - a(k-1) \quad \Rightarrow \quad 2(2k-1) - (2(k-1) - 1)
$$

$$
2(2k-1) - 2(k-1) - 1 \quad \Rightarrow \quad 4k - 2 - (2k - 2 - 1) \quad \Rightarrow \quad 2k + 1
$$

$$
2k + 1 \Rightarrow 2k + 2 - 1 \Rightarrow 2(k+1) - 1
$$

So $P(k+1)$ holds.

**Conclusion**: Therefore, $P(n)$ holds for all integers $n \geq 1$ by strong induction.

## Related

- [[Induction]]
- [[Structural Induction]]
- [[Formal Proofs]]
