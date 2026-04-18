# CSE 312: Overcounting (Multinomial)

When we are counting permutations of a set and we want to eliminate any duplicates because there are repeated elements in the list, we can use the **multinomial coefficient**:

$$\frac{n!}{m! \cdot j! \cdots z!}$$

where $m, j, \ldots, z$ are the counts of each repeated element. This divides out the redundant arrangements introduced by identical elements.

## Related

- [[Permutation]]
- [[Factorial]]
- [[Number of Subsets Formula]]
