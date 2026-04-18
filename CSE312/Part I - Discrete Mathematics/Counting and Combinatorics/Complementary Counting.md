# CSE 312: Complementary Counting

To count a set $A$, where we want to find the complement, we do:

$$|A| = |U| - |\bar{A}|$$

This can be used if we want to find the complement of a problem where we have all options such as a set $\{a, b, c, \ldots, z\}$ and want to find all permutations of length 5. But, we restrict it to exclude $a$, so $U$ would be $26^5$ and $|\bar{A}|$ would be $25^5$; then subtracting these two will result in the count of permutations that include $a$.

## Related

- [[Principle of Inclusion-Exclusion]]
- [[Number of Subsets Formula]]
- [[Product Rule]]
