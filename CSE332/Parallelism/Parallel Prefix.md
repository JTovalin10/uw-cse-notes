# CSE 332: Parallel Prefix

**Parallel Prefix Sum**: Given an array, compute a new array where each index $i$ is the sum of all values up to $i$. This requires an associative operation.

Parallel Prefix Sum is a "two pass" algorithm:
1. **Pass 1 (Up/Build Tree)**: Build a tree using divide and conquer where each node stores the `sum` of its range.
   - Base case: range is smaller than cutoff, compute sequentially.
   - Combine: `parent.sum = leftChild.sum + rightChild.sum`
2. **Pass 2 (Down/Fill Output)**: Go root-down to compute the **LeftSum** (the sum of all elements strictly to the left of the current range).
   - Root `leftSum` is $0$.
   - Left child `leftSum` is `parent.leftSum`.
   - Right child `leftSum` is `parent.leftSum + sibling.sum`.
   - For a leaf node: `output[lo] = leftSum + input[lo]`, then sequentially fill the rest of the node's range: `output[i] = output[i-1] + input[i]`.

Parallel Prefix is highly useful for **Pack** (or **Filter**), which takes an array of values and a Boolean function, returning a new array with only the elements that evaluated to `true`.
1. **Map**: Apply the condition to create an array of 1s (true) and 0s (false).
2. **Prefix Sum**: Run parallel prefix sum on the map result. This gives the count of true elements seen to the left of each position, acting as the output index!
3. **Map/Fill**: Fill the output array in parallel. If `mapResult[i] == 1`, `output[prefixResult[i] - 1] = input[i]`.

## Related
- [[Fork-Join]]
