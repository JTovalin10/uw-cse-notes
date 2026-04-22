# CSE444: Query Optimization

The **query optimizer** is responsible for transforming a logical query plan into an efficient physical query plan. This is a **cost-based optimization** process.

## Optimization Process

1. **Enumerate alternative plans**: Generate many possible equivalent logical and physical plans.
2. **Compute estimated cost**: For each plan, calculate the total cost based on system resources.
   - Primarily focuses on **I/O cost** (number of disk reads/writes).
   - Can optionally include CPU and network costs.
3. **Choose the cheapest plan**: Select the plan with the lowest estimated cost.

### Key Observations
- There is no single "best" plan; the optimal choice depends heavily on the data distribution.
- Accurate optimization requires **database statistics** (e.g., histograms) to make informed decisions.

## Search Space

The search space for query plans is enormous due to many equivalent trees, multiple operator implementations, and various access paths.

### Restricting the Search Space
Optimizers often restrict the types of join trees they consider to make the search tractable:
- **Left-deep trees**: Work well with common join algorithms (nested-loop, hash-join) and facilitate pipelining.
- **Right-deep trees**
- **Zig-zag (Linear) trees**
- **Bushy trees**

Optimizers also typically avoid plans that involve **Cartesian products** unless necessary.

## Optimization Rules

Optimizers use algebraic identities to transform plans:
- **Selections**: Commutative, cascading, and can be pushed down.
- **Projections**: Cascading.
- **Joins**: Commutative and associative.

Modern optimizers are **cost-based**, using a cost model rather than just greedy heuristic rules (like "always push selections down").

## Cost Estimation

Cost estimation relies on two main components:
1. **Cardinality Estimation**: Estimating the number of tuples $T(R)$ for each intermediate result.
2. **Cost Formulas**: Calculating I/O and CPU requirements based on cardinalities.

### Database Statistics
The DBMS collects statistical summaries of stored data:
- **Cardinality**: $T(R)$, the number of tuples in relation $R$.
- **Page Count**: $B(R)$, the number of physical pages.
- **Index Statistics**: $V(R, a)$, the number of distinct values for attribute $a$.
- **Value Ranges**: Min and max values for attributes.
- **Histograms**: Detailed data distribution summaries (e.g., **Equi-width**, **Equi-depth**, or **V-optimal**).

### Size (Cardinality) Estimation
Given $T(R_1), \ldots, T(R_n)$, the goal is to estimate $T(Q)$. Each condition reduces the size by a **selectivity factor**.

**Selectivity Factors:**
- **Equality Selection** ($\sigma_{A=c}(R)$): $\frac{1}{V(R, A)}$
- **Range Selection** ($\sigma_{A<c}(R)$): $\frac{c - \text{Low}(R, A)}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Join** ($R \bowtie_{A=B} S$): $\frac{1}{\max(V(R, A), V(S, B))}$

**Join Cardinality Formula:**
$$T(R \bowtie S) = \frac{T(R) \cdot T(S)}{\max(V(R, A), V(S, B))}$$
*(Assuming "containment of value sets" where the smaller set of values is a subset of the larger set).*

## Computing Plan Costs

The optimizer computes costs in a bottom-up fashion:
1. Estimate cardinality of base relations.
2. Estimate cardinality of intermediate results.
3. Apply cost formulas for each physical operator (e.g., $3(B(R) + B(S))$ for two-pass join).

![[CSE444/Screenshots/Computing the cost of a plan.png]]

Note: If an operator (like a selection) brings data into memory but a subsequent operator (like sort-merge join) requires disk-based runs, the intermediate result must be written to disk.

---

## Related
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — cost formulas for specific join implementations
- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — the basis for logical plan transformations
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — how the chosen plan is carried out
