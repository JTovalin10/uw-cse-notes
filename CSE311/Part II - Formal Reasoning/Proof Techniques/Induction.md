# CSE 311: Mathematical Induction

**Mathematical induction** is a [[CSE311/Part II - Formal Reasoning/Proof Techniques/Formal Proofs|proof]] technique used to prove that a property $P(x)$ holds for all integers $x \geq m$. It works like a chain of dominoes: prove the first case, then prove that each case forces the next, and all cases follow.

**Template:**
- Let $P(x)$ be ...
- **Base Case**: Prove $P(m)$, where $m$ is the base case value.
- **Induction Hypothesis**: Assume $P(k)$ holds for some arbitrary integer $k \geq m$.
- **Induction Step**: Show that $P(k+1)$ holds.
- **Conclusion**: Since $k$ was an arbitrary value, $P(x)$ is true for all $x \geq m$.

## Summation

When doing induction on a summation, expand $P(k+1)$ by splitting off the last term:
$$
\sum_{i=0}^{k+1} i \quad \Rightarrow \sum_{i=0}^{k} i + (k+1)
$$
This allows you to apply the induction hypothesis to $\sum_{i=0}^{k} i$ and simplify.

## Product

When doing induction on a product, expand $P(k+1)$ by splitting off the last factor:
$$
\prod_{i=0}^{k+1} i \quad \Rightarrow \prod_{i=0}^{k} i \quad \times (k+1)
$$
This allows you to apply the induction hypothesis to $\prod_{i=0}^{k} i$ and simplify.

## Equivalence Induction

When doing induction to prove an inequality or equivalence, more careful algebraic manipulation is required.

### Example

$$ \text{Prove that for all integers } k \geq 4: k! > 2^k $$

**Base Case**: $P(4)$

$$ 4! = 24 $$

$$ 2^4 = 16 $$

$$ 24 > 16 $$

$$ \text{Therefore, } P(4) \text{ is true.} $$

**Induction Hypothesis**

$$ \text{Assume } P(k) \text{ is true for some arbitrary } k \geq 4: k! > 2^k $$

**Induction Step**: Prove $P(k+1)$

$$ \text{We need to show: } (k+1)! > 2^{(k+1)} $$

$$ (k+1)! = (k+1) \times k! $$

$$ \text{Using our induction hypothesis: } (k+1)! = (k+1) \times k! > (k+1) \times 2^k $$

$$ \text{For the right side of what we're trying to prove: } 2^{(k+1)} = 2 \times 2^k $$

$$ \text{Now we need to show that: } (k+1) \times 2^k > 2 \times 2^k $$

$$ \text{This simplifies to: } k+1 > 2 $$

$$ \text{Since } k \geq 4, \text{ we know that } k+1 \geq 5, \text{ which is greater than } 2. $$

$$ \text{Therefore: } (k+1)! > 2^{(k+1)} $$

**Conclusion**

$$ \text{Since } P(4) \text{ is true and } P(k) \Rightarrow P(k+1) \text{ for all } k \geq 4, \text{ by the principle of mathematical induction, } P(k) \text{ is true for all integers } k \geq 4. $$

When a recursive definition depends on more than one previous value, ordinary induction is not enough — use [[CSE311/Part II - Formal Reasoning/Proof Techniques/Strong Induction|strong induction]]. When the objects are elements of a recursively defined set rather than integers, use [[CSE311/Part II - Formal Reasoning/Proof Techniques/Structural Induction|structural induction]].

## Related

- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Strong Induction|Strong Induction]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Structural Induction|Structural Induction]]
- [[CSE311/Part II - Formal Reasoning/Proof Techniques/Formal Proofs|Formal Proofs]]

## Industry Standard Terms

| CSE 311 Term | Industry-Standard Equivalent |
| --- | --- |
| Mathematical induction | Weak / simple induction |
| Base case | Base case |
| Induction hypothesis | Inductive hypothesis (IH) |
| Induction step | Inductive step |
