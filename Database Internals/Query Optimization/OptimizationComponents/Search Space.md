# Database Internals: Search Space

The **search space** for query plans is the set of all possible equivalent plans for a given query. This space is enormous due to the variety of equivalent relational algebra trees, multiple operator implementations, and various access paths (indexes vs. scans). For $n$ relations, the number of distinct join orderings alone grows factorially, making exhaustive enumeration infeasible for large queries.

## Approaches to Search Space Exploration

### Complete Plans

This approach takes a logical plan and generates every possible equivalent physical plan to find the best one.
- **Drawback**: Extremely inefficient because there is no opportunity for early pruning — the optimizer must evaluate every complete plan before any comparison can be made.

![[Complete Plans.png]]

### Bottom-Up Partial Plans

The optimizer looks at all possible "bottoms" of the plan (sub-expressions) and estimates their costs.
- **Pruning**: High-cost plans for sub-expressions can be pruned early. If a subtree is not optimal for its result set, it cannot be part of the optimal global plan — unless it produces output in a sorted order that would benefit a later operator (an **interesting order**). This principle is the foundation of the [[Database Internals/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]] approach.

![[Bottom-up Partial Plans.png]]

### Top-Down Partial Plans

The optimizer generates a portion of the query from the root down and estimates its cost.
- **Drawback**: Top-down approaches still require estimating the cost of the "rest of the query" at each step to make informed decisions, making pruning harder than in the bottom-up approach.

![[Top-down partial plans.png]]

## Reducing the Search Space

To make optimization tractable, optimizers apply heuristics to restrict the search space:

- **[[Database Internals/Query Optimization/OptimizationComponents/Join Trees#Left-Deep Join Trees|Left-Deep Join Trees]]**: Many optimizers (including the [[Database Internals/Query Optimization/OptimizationComponents/Selinger Algorithm|Selinger Algorithm]]) consider only left-deep trees. This limits the search space to $n!$ orderings rather than the exponentially larger set of bushy trees, while still capturing most efficient plans for standard join algorithms.
- **Avoid Cartesian Products**: Plans involving Cartesian products (joins with no predicate) are typically ignored unless the query explicitly requires them. A Cartesian product produces $T(R) \times T(S)$ rows, which is almost always far too large.
- **Selection Pushdown**: Always push selections as far down the tree as possible, so that subsequent operators see fewer rows.
- **Projection Pushup**: Projecting out unneeded attributes early reduces the width (byte cost) of intermediate tuples, reducing both memory pressure and I/O for materialized steps.

### Cartesian Product Avoidance Example

For a query joining `Supplier`, `Supply`, and `Part`, the optimizer will avoid joining `Supplier` and `Part` directly if there is no join predicate between them. Joining those two first would produce a large intermediate result with no filtering, which would then need to be joined with `Supply`. Instead, the optimizer joins `Supply` with either `Supplier` or `Part` first — whichever has a predicate — and the intermediate result is much smaller.

![[Plan with Cartesian product.png]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Search Space | Plan space / optimization search space |
| Bottom-Up Partial Plans | Dynamic programming / bottom-up plan enumeration |
| Top-Down Partial Plans | Top-down enumeration / memoization-based |
| Cartesian Product Avoidance | Cross-join avoidance heuristic |

## Related

- [[Database Internals/Query Optimization/OptimizationComponents/Join Trees|Join Trees]]
- [[Database Internals/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]]
- [[Database Internals/Query Optimization/OptimizationComponents/Cost Estimation|Cost Estimation]]
