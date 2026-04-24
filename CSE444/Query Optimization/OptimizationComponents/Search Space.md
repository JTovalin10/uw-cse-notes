# CSE444: Search Space

The **search space** for query plans is the set of all possible equivalent plans for a given query. This space is enormous due to the variety of equivalent relational algebra trees, multiple operator implementations, and various access paths (indices vs. scans).

## Approaches to Search Space Exploration

### Complete Plans
This approach involves taking a logical plan and generating every possible equivalent physical plan to find the best one.
- **Drawback**: Extremely inefficient as there is no opportunity for early pruning.
![[CSE444/Screenshots/Complete Plans.png]]

### Bottom-Up Partial Plans
The optimizer looks at all possible "bottoms" of the plan (sub-expressions) and estimates their costs.
- **Pruning**: We can prune high-cost plans for sub-expressions early. If a subtree is not optimal for its result, it cannot be part of the optimal global plan (unless it provides a useful sorting property).
![[CSE444/Screenshots/Bottom-up Partial Plans.png]]

### Top-Down Partial Plans
The optimizer generates a portion of the query and estimates its cost.
- **Drawback**: Still requires estimating the cost of the "rest of the query" to make informed decisions.
![[CSE444/Screenshots/Top-down partial plans.png]]

## Reducing the Search Space
To make optimization tractable, optimizers often apply heuristics to restrict the search space:
- **[[CSE444/Query Optimization/OptimizationComponents/Join Trees#Left-Deep Join Trees|Left-Deep Join Trees]]**: Many optimizers only consider left-deep trees.
- **Avoid Cartesian Products**: Plans involving Cartesian products are typically ignored unless the query specifically requires them.
- **Selection Pushdown**: Always push selections as far down the tree as possible.
- **Projection Pushup**: Perform projections as late as possible (or as early as possible to reduce tuple width, depending on the model).

### Cartesian Product Avoidance Example
For a query joining `Supplier`, `Supply`, and `Part`, the optimizer will avoid joining `Supplier` and `Part` directly if there is no join predicate between them.
![[CSE444/Screenshots/Plan with Cartesian product.png]]

## Related
- [[CSE444/Query Optimization/OptimizationComponents/Join Trees|Join Trees]]
- [[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]]
- [[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]]
