# CSE 312: Principle of Inclusion-Exclusion (PIE)

The **Principle of Inclusion-Exclusion (PIE)** gives the size of a union of sets by alternately adding and subtracting intersection sizes.

For two sets:

$$|A \cup B| = |A| + |B| - |A \cap B|$$

For three or more sets, the general formula is:

$$|A \cup B \cup C| = |A| + |B| + |C| - |A \cap B| - |B \cap C| - |A \cap C| + |A \cap B \cap C|$$

We subtract each pairwise intersection individually, then add back the intersection of all sets, because those elements were subtracted too many times.

## Related

- [[Sum Rule]]
- [[Complementary Counting]]
- [[Possibilities with Restrictions]]
