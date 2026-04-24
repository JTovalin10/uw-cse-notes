# CSE444: Dynamic Programming

Most modern cost-based optimizers (originating from the **System R** optimizer) use **Dynamic Programming** to find the optimal join order for single-block queries.

## System R Style Optimizer
- **Scope**: Limited to single-block queries (SELECT-FROM-WHERE).
- **Strategy**: Bottom-up exploration of the search space.
- **Heuristics**:
  - Push selections down.
  - Pull projections up.
  - Avoid Cartesian products.

## The Algorithm
For each subquery $Q \subseteq \{R_1, \ldots, R_n\}$, the optimizer computes:
- $T(Q)$: The estimated size of the result.
- $Plan(Q)$: The best (cheapest) physical plan for $Q$.
- $Cost(Q)$: The estimated cost of that plan.

### Steps
1. **Base Case**: For each individual relation $\{R_i\}$:
   - $T(\{R_i\}) = T(R_i)$
   - $Plan(\{R_i\}) = \text{Best access method (index vs. sequential scan)}$
   - $Cost(\{R_i\}) = \text{Cost of the chosen access method}$

2. **Recursive Step**: For each subquery $Q$ of size $k$ (from $2$ to $n$):
   - Estimate $T(Q)$ using selectivity factors.
   - Consider all partitions $Q = Q' \cup Q''$:
     - Compute the cost of joining the best plans for $Q'$ and $Q''$: $Cost(Plan(Q') \bowtie Plan(Q''))$.
   - $Cost(Q) = \text{Smallest cost found}$.
   - $Plan(Q) = \text{Corresponding plan}$.

3. **Final Result**: Return $Plan(\{R_1, \ldots, R_n\})$.

### Implementation Details
- **Pruning**: Only the cheapest plan for each set of relations is kept for future consideration.
- **Search Space Restrictions**:
  - If restricting to **Left-Deep trees**, then $Q''$ must always be a single relation.
  - Most optimizers will only consider $Q'$ and $Q''$ that have a join predicate between them (to avoid Cartesian products).

![[CSE444/Screenshots/DB Dynamic Programming.png]]

## Related
- [[CSE444/Query Optimization/OptimizationComponents/Search Space|Search Space]]
- [[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]]
- [[CSE444/Query Optimization/OptimizationComponents/Join Trees|Join Trees]]
