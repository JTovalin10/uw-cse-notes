# CSE 312: Principle of Inclusion-Exclusion (PIE)

The **Principle of Inclusion-Exclusion (PIE)** gives the size of a union of sets by alternately adding and subtracting intersection sizes.

For two sets:

$$|A \cup B| = |A| + |B| - |A \cap B|$$

For three or more sets, the general formula is:

$$|A \cup B \cup C| = |A| + |B| + |C| - |A \cap B| - |B \cap C| - |A \cap C| + |A \cap B \cap C|$$

We subtract each pairwise intersection individually, then add back the intersection of all sets, because those elements were subtracted too many times.

## Example

How many length 5 strings over the alphabet $\{a, b, c, \dots, z\}$ contain: exactly 2 'a's OR exactly 1 'b' OR no 'x's?

Let:
$A = \{\text{length 5 strings that contain exactly 2 'a's}\}$
$B = \{\text{length 5 strings that contain exactly 1 'b's}\}$
$C = \{\text{length 5 strings that contain no 'x's}\}$

We want $|A \cup B \cup C|$. Calculate size-by-size:
- Single sets: $|A| = \binom{5}{2} \cdot 25^3$, $|B| = \binom{5}{1} \cdot 25^4$, $|C| = 25^5$
- Pairwise intersections: 
  - $|A \cap B| = \binom{5}{2} \cdot \binom{3}{1} \cdot 24^2$
  - $|A \cap C| = \binom{5}{2} \cdot 24^3$
  - $|B \cap C| = \binom{5}{1} \cdot 24^4$
- Three-wise intersection: $|A \cap B \cap C| = \binom{5}{2} \cdot \binom{3}{1} \cdot 23^2$

By PIE, combine these: $|A \cup B \cup C| = |A| + |B| + |C| - (|A \cap B| + |A \cap C| + |B \cap C|) + |A \cap B \cap C|$.

## Related

- [[Sum Rule]]
- [[Complementary Counting]]
- [[Possibilities with Restrictions]]
