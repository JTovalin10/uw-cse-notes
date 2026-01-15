Formula
- Let P(x) be ...
- Base Case: P(m), where m is base case
- Induction Hypothesis: Assume P(k) holds where x is a arbitrary k value
- Induction Hypothesis: show work that P(k+1) holds
- Conclusion: as k was an arbitrary value it holds that P(x) is true
# Summation
When doing summation induction you can do this with P(k+1)
$$
\sum _{i=0} ^{k+1} i \quad \Rightarrow \sum _{i=0} ^k i + (k+1)
$$
# Production
When doing product induction you can do this with P(k+1)
$$
\prod _{i=0} ^{k+1} i \quad \Rightarrow \prod _{i=0} ^k i \quad \times (k+1) 
$$
# Equivalence Induction
When doing equivalence you have to be more careful and do more work
### Example: 

$$ \text{Prove that for all integers } k \geq 4: k! > 2^k $$

Base Case: P(4)

$$ 4! = 24 $$

$$ 2^4 = 16 $$

$$ 24 > 16 $$

$$ \text{Therefore, } P(4) \text{ is true.} $$

induction Hypothesis

$$ \text{Assume } P(k) \text{ is true for some arbitrary } k \geq 4: k! > 2^k $$

Induction Step: Prove P(k+1)

$$ \text{We need to show: } (k+1)! > 2^{(k+1)} $$

$$ (k+1)! = (k+1) \times k! $$

$$ \text{Using our induction hypothesis: } (k+1)! = (k+1) \times k! > (k+1) \times 2^k $$

$$ \text{For the right side of what we're trying to prove: } 2^{(k+1)} = 2 \times 2^k $$

$$ \text{Now we need to show that: } (k+1) \times 2^k > 2 \times 2^k $$

$$ \text{This simplifies to: } k+1 > 2 $$

$$ \text{Since } k \geq 4, \text{ we know that } k+1 \geq 5, \text{ which is greater than } 2. $$

$$ \text{Therefore: } (k+1)! > 2^{(k+1)} $$

Conclusion

$$ \text{Since } P(4) \text{ is true and } P(k) \Rightarrow P(k+1) \text{ for all } k \geq 4, \text{ by the principle of mathematical induction, } P(k) \text{ is true for all integers } k \geq 4. $$