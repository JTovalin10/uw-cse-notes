# Database Internals: Dynamic Programming

Most modern cost-based optimizers (originating from the **System R** optimizer) use **Dynamic Programming** to find the optimal join order for single-block queries. The key insight is that the optimal plan for a set of relations must contain the optimal sub-plan for every subset — this is the principle of **optimal substructure** that makes DP applicable.

## System R Style Optimizer

- **Scope**: Limited to single-block queries (SELECT-FROM-WHERE with no nested subqueries).
- **Strategy**: Bottom-up exploration of the search space — compute the best plan for each sub-set of relations before considering larger sets.
- **Heuristics**:
  - Push selections down (filter early).
  - Pull projections up (reduce tuple width).
  - Avoid Cartesian products (only join pairs that share a predicate).

## The Algorithm

For each subset $Q \subseteq \{R_1, \ldots, R_n\}$, the optimizer computes:
- $T(Q)$: the estimated size of the join result.
- $\text{Plan}(Q)$: the best (cheapest) physical plan for $Q$.
- $\text{Cost}(Q)$: the estimated cost of that plan.

### Steps

1. **Base Case**: For each individual relation $\{R_i\}$:
   - $T(\{R_i\}) = T(R_i)$
   - $\text{Plan}(\{R_i\}) = \text{Best access method (index scan vs. sequential scan)}$
   - $\text{Cost}(\{R_i\}) = \text{Cost of the chosen access method}$

2. **Recursive Step**: For each subset $Q$ of size $k$ (from $2$ to $n$):
   - Estimate $T(Q)$ using selectivity factors propagated from the children.
   - Consider all **partitions** $Q = Q' \cup Q''$ (all ways to split $Q$ into two disjoint non-empty parts):
     - Compute the cost of joining the best plans for $Q'$ and $Q''$: $\text{Cost}(\text{Plan}(Q') \bowtie \text{Plan}(Q''))$.
   - $\text{Cost}(Q) = \text{smallest cost found across all partitions}$.
   - $\text{Plan}(Q) = \text{the corresponding plan}$.

3. **Final Result**: Return $\text{Plan}(\{R_1, \ldots, R_n\})$.

### Implementation Details

- **Pruning**: Only the cheapest plan for each set of relations is kept for future consideration. Any more expensive plan for the same result set is discarded (unless it produces an **interesting order** — see [[Database Internals/Query Optimization/OptimizationComponents/Selinger Algorithm|Selinger Algorithm]]).
- **Search Space Restrictions**:
  - If restricting to **Left-Deep trees**, then $Q''$ must always be a single base relation. This reduces the number of partitions to consider at each step from exponential to linear in the current subset size.
  - Most optimizers will only consider pairs $Q', Q''$ that have a join predicate between them (to avoid Cartesian products).

![[DB Dynamic Programming.png]]

## Complexity

- **Without restrictions**: Considers all $2^n - 2$ non-trivial subsets at each level — exponential in $n$.
- **With left-deep restriction**: Reduces to $O(n^2 \cdot 2^n)$ subproblems total, which is tractable up to roughly 10–15 relations. Beyond that, heuristic methods (e.g., greedy, simulated annealing) are used.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Dynamic Programming optimizer | Selinger-style optimizer / System R optimizer |
| Optimal substructure | Bellman's principle of optimality |
| Left-Deep restriction | Left-deep tree enumeration |

## Related

- [[Database Internals/Query Optimization/OptimizationComponents/Search Space|Search Space]]
- [[Database Internals/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]]
- [[Database Internals/Query Optimization/OptimizationComponents/Join Trees|Join Trees]]
- [[Database Internals/Query Optimization/OptimizationComponents/Selinger Algorithm|Selinger Algorithm]] — extends DP with interesting orders
