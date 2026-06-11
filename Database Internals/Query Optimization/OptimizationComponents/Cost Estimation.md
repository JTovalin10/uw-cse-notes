# Database Internals: Cost Estimation

**Cost estimation** is the process of calculating the total system resources (primarily **I/O cost**) required to execute a physical query plan. It relies on cardinality estimation and specific cost formulas for each physical operator. Without accurate cost estimation, the optimizer cannot distinguish between a good plan and a catastrophically bad one.

## Database Statistics

The DBMS collects statistical summaries of stored data to inform the optimizer:
- **Cardinality**: $T(R)$, the total number of tuples in relation $R$.
- **Page Count**: $B(R)$, the number of physical pages used by $R$.
- **Index Statistics**: $V(R, a)$, the number of distinct values for attribute $a$.
- **Value Ranges**: Minimum and maximum values for attributes, used for range predicate selectivity.
- **Histograms**: Detailed data distribution summaries:
  - **Equi-width**: Each bucket covers the same range of values. Simple to build but inaccurate for skewed data.
  - **Equi-depth**: Each bucket contains approximately the same number of tuples. More accurate for skewed distributions because no bucket is disproportionately large.
  - **V-optimal**: Minimizes variance within buckets (most accurate but most expensive to maintain).

## Propagating Statistics

The goal is to estimate the properties of query results as they move **up** the relational algebra tree. Each operator receives estimated statistics from its children and computes estimated statistics for its output. This bottom-up propagation allows the optimizer to estimate the size of every intermediate result.

### General Recursive Formula

The cardinality of a result depends on the output of the previous step(s):
- **Unary Operators** (Selection/Projection):
  $$T(R_{n}) = sel(\text{predicate}) \times T(R_{n-1})$$
- **Binary Operators** (Joins):
  $$T(R_{n}) = sel(\text{join predicate}) \times T(R_{\text{left}}) \times T(R_{\text{right}})$$

#### Example Propagation

1. **Selection on R** (base): $T(R_1) = sel_1 \times T(R)$
2. **Selection on S** (base): $T(R_2) = sel_2 \times T(S)$
3. **Join $R_1$ and $R_2$**: $T(R_3) = sel_{\text{join1}} \times T(R_1) \times T(R_2)$
4. **Selection on $R_3$**: $T(R_4) = sel_4 \times T(R_3)$
5. **Join $R_4$ and T**: $T(R_5) = sel_{\text{join2}} \times T(R_4) \times T(T)$

### 1. Result Cardinality ($T(R_{\text{out}})$)

- **Selection ($\sigma_P$)**: $T(R_{\text{out}}) = sel(P) \times T(R_{\text{in}})$
- **Join ($\bowtie$)**:
  $$T(R \bowtie S) = \frac{T(R_{\text{left}}) \cdot T(R_{\text{right}})}{\max(V(R_{\text{left}}, A), V(R_{\text{right}}, B))}$$
- **Projection ($\pi_A$)**: $T(R_{\text{out}}) = T(R_{\text{in}})$ (row count unchanged; duplicates are only removed with an explicit `DISTINCT`).

### 2. Selectivity Factors ($sel$)

How much a predicate reduces the input size:
- $\land$ (AND): $sel(P_1 \land P_2) \approx sel(P_1) \times sel(P_2)$ (independence assumption)
- $\lor$ (OR): $sel(P_1 \lor P_2) \approx sel(P_1) + sel(P_2) - sel(P_1) \times sel(P_2)$
  - Simplified to $sel(P_1) + sel(P_2)$ in practice.

#### Equality and Inequality

- **Equality** ($\sigma_{A=c}$): $\dfrac{1}{V(R, A)}$
- **Inequality** ($\sigma_{A \neq c}$): $1 - \dfrac{1}{V(R, A)}$

#### Range Predicates

- **Less than** ($\sigma_{A < c}$): $\dfrac{c - \text{Low}(R, A)}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Greater than** ($\sigma_{A > c}$): $\dfrac{\text{High}(R, A) - c}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Between** ($\sigma_{c_1 \leq A \leq c_2}$): $\dfrac{c_2 - c_1}{\text{High}(R, A) - \text{Low}(R, A)}$

#### Joins

- **Equi-join** ($R \bowtie_{A=B} S$): $\dfrac{1}{\max(V(R, A), V(S, B))}$

This formula assumes that all values of the attribute with fewer distinct values are contained in the other relation (the **containment assumption**). The $\max$ in the denominator means the selectivity is driven by the attribute with more distinct values — the one that is harder to match.

### 3. Distinct Values ($V(R_{\text{out}}, A)$)

Estimating distinct values of attribute $A$ after an operation:

- **Selection ($\sigma_P(R_{\text{in}})$)**: $V(R_{\text{out}}, A) \approx \min(V(R_{\text{in}}, A), T(R_{\text{out}}))$
  - After filtering, the number of distinct values cannot exceed either the original count or the total surviving tuples.
- **Join ($R \bowtie S$)**:
  - For the join attribute $A$: $V(R \bowtie S, A) = \min(V(R_{\text{left}}, A), V(R_{\text{right}}, A))$ (due to the containment assumption).
  - For a non-join attribute $B$ in $R$: $V(R \bowtie S, B) \approx \min(V(R_{\text{left}}, B), T(R \bowtie S))$.
- **Projection ($\pi_A(R_{\text{in}})$)**: $V(\pi_A(R_{\text{out}}), A) = V(R_{\text{in}}, A)$ (projection does not change the set of distinct values present).

### 4. Value Ranges (Low/High)

- **Selection ($\sigma_{A > c}(R_{\text{in}})$)**: $\text{Low}(R_{\text{out}}, A) = \max(\text{Low}(R_{\text{in}}, A), c)$
- **Join ($R \bowtie_{A=B} S$)**:
  - $\text{Low}(R \bowtie S, A) = \max(\text{Low}(R_{\text{left}}, A), \text{Low}(R_{\text{right}}, B))$
  - $\text{High}(R \bowtie S, A) = \min(\text{High}(R_{\text{left}}, A), \text{High}(R_{\text{right}}, B))$

## Computing Plan Costs

The optimizer computes costs in a bottom-up fashion:
1. Estimate the cardinality of base relations from catalog statistics.
2. Estimate the cardinality of intermediate results by propagating statistics up the tree.
3. Apply operator-specific cost formulas (e.g., [[Database Internals/Query Evaluation/External Merge-Sort|External Merge-Sort]] or [[Database Internals/Query Evaluation/Single-Pass Hash Join|Hash Join]] costs) to each node.

![[Computing the cost of a plan.png]]

> [!NOTE] Intermediate Results
> If an operator (like a selection) brings data into memory but a subsequent operator (like sort-merge join) requires disk-based runs, the intermediate result must be written to disk, adding to the total I/O cost.

---

## Industry Standard Terms

| Course Term | Industry / Standard Equivalent |
|---|---|
| Cardinality estimation | Row count estimation / cardinality estimation |
| Selectivity | Filter selectivity / predicate selectivity |
| $V(R, a)$ | NDV (number of distinct values) |
| Equi-depth histogram | Height-balanced histogram |
| Containment assumption | Inclusion assumption |

## Related

- [[Database Internals/Query Evaluation/Operator Algorithms|Operator Algorithms]] — operator-specific cost formulas
- [[Database Internals/Query Optimization/OptimizationComponents/Search Space|Search Space]]
- [[Database Internals/Query Optimization/OptimizationComponents/Dynamic Programming|Dynamic Programming]]
