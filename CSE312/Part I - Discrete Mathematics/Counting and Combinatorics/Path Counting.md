# CSE 312: Path Counting

**Path counting** problems ask for the number of ways to navigate a grid from a starting point to an ending point, moving only in specific directions (e.g., right and up).

## Example

Imagine we are at a farm in the lower-left corner of a grid and want to get to the Adventure's Guild in the upper-right corner.
- We must move exactly 4 steps right and 4 steps up, for a total of 8 steps.
- How many different paths are there?

**Idea 1: Subsets**
We are going to take 8 steps in total. We just need to choose which subset of 4 steps will be "up" (the other 4 will automatically be "right"). 
This is choosing 4 items from a set of 8, so the answer is $\binom{8}{4}$.

**Idea 2: Artificial Ordering (Permutations of Multiset)**
We can think of this as arranging a string of 8 characters: $\uparrow \uparrow \uparrow \uparrow \rightarrow \rightarrow \rightarrow \rightarrow$.
- Put them in an artificial order (pretend all $\uparrow$ and $\rightarrow$ are distinct): $8!$ ways.
- Remove the overcounting: The 4 "up" arrows are identical, so divide by $4!$. The 4 "right" arrows are identical, so divide by $4!$.
- Total paths: $\frac{8!}{4! \cdot 4!} = \binom{8}{4}$.

## Related

- [[Overcounting]]
- [[Number of Subsets Formula|Combinations]]
