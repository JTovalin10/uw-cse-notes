# CSE331: Array Reasoning

Reasoning about arrays requires tools beyond simple variables because we can access any element dynamically via `A[i]`. We need to define facts about sublists or ranges of elements.

## Prefixes and Suffixes
When indexing into arrays, it is common to reason about a **prefix** or a **suffix** of the array.
- **Prefix:** `A[0 .. i]` (or `A[.. i]`). Includes all elements up to index `i` (inclusive).
- **Suffix:** `A[i .. n-1]` (or `A[i ..]`). Includes all elements from index `i` to the end of the array.
- An empty prefix is represented when the upper bound is less than the lower bound (e.g., `A[.. -1]` is an empty array).
- Concatenation: `A[.. i-1] + A[i ..] = A`

## "For Any" Facts
Often, an invariant requires a property to hold for a range of elements. We write these as "for any" facts.
Example: `A is sorted` can be formally written as:
`A[j] <= A[j+1] for any 0 <= j <= len(A) - 2`

## Array Mutation
Mutation makes "for any" facts change, and this must be tracked line by line using Floyd Logic.
- Working forward: If we know a fact about `A`, and we assign `A[i] = x`, the old facts about `A[i]` are invalidated. We have a new array state where `A[i] == x` and `A[j]` (for `j != i`) remains the same.
- This can quickly get complicated, which is why we often use pictures to visualize regions of the array.

## Avoiding Out of Bounds
When writing loops with `A[i]`, we must check that `0 <= i < len(A)`. The loop invariant and the loop condition must guarantee that the index is within bounds before any array access.

## Related
- [[Loop invariants with pictures]]
- [[Loops]]
- [[Floyd Logic]]