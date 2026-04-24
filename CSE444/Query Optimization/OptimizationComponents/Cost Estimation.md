# CSE444: Cost Estimation

**Cost estimation** is the process of calculating the total system resources (primarily **I/O cost**) required to execute a physical query plan. It relies on cardinality estimation and specific cost formulas for each physical operator.

## Database Statistics
The DBMS collects statistical summaries of stored data to inform the optimizer:
- **Cardinality**: $T(R)$, the total number of tuples in relation $R$.
- **Page Count**: $B(R)$, the number of physical pages used by $R$.
- **Index Statistics**: $V(R, a)$, the number of distinct values for attribute $a$.
- **Value Ranges**: Minimum and maximum values for attributes.
- **Histograms**: Detailed data distribution summaries:
  - **Equi-width**: Each bucket covers the same range of values.
  - **Equi-depth**: Each bucket contains approximately the same number of tuples.
  - **V-optimal**: Minimizes variance within buckets (most accurate but expensive).

## Cardinality Estimation
Given the cardinalities of input relations, the goal is to estimate the size $T(Q)$ of the query result. Each condition reduces the size by a **selectivity factor**.

### Selectivity Factors
- **Equality Selection** ($\sigma_{A=c}(R)$): $\frac{1}{V(R, A)}$
- **Range Selection** ($\sigma_{A<c}(R)$): $\frac{c - \text{Low}(R, A)}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Join** ($R \bowtie_{A=B} S$): $\frac{1}{\max(V(R, A), V(S, B))}$

### Join Cardinality Formula
$$T(R \bowtie S) = \frac{T(R) \cdot T(S)}{\max(V(R, A), V(S, B))}$$
*Assumption: **Containment of value sets**, where the smaller set of values is a subset of the larger set.*

## Computing Plan Costs
The optimizer computes costs in a bottom-up fashion:
1. Estimate cardinality of base relations.
2. Estimate cardinality of intermediate results.
3. Apply operator-specific cost formulas (e.g., [[CSE444/Query Evaluation/Operator Algorithms|External Merge Sort]] or Hash Join costs).

![[CSE444/Screenshots/Computing the cost of a plan.png]]

> [!NOTE] Intermediate Results
> If an operator (like a selection) brings data into memory but a subsequent operator (like sort-merge join) requires disk-based runs, the intermediate result must be written to disk, adding to the total I/O cost.

## Related
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]]
- [[CSE444/Query Optimization/OptimizationComponents/Search Space|Search Space]]
- [[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]]
