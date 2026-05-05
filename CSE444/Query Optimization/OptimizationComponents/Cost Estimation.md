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

## Propagating Statistics
The goal is to estimate the properties of query results as they move up the relational algebra tree. 

### General Recursive Formula
The cardinality of a result depends on the **output of the previous step(s)**:
- **Unary Operators** (Selection/Projection):
  $$T(R_{n}) = sel(\text{predicate}) \times T(R_{n-1})$$
- **Binary Operators** (Joins):
  $$T(R_{n}) = sel(\text{join\ predicate}) \times T(R_{left}) \times T(R_{right})$$

#### Example Propagation:
1.  **Selection on R** (base): $T(R_1) = sel_1 \times T(R)$
2.  **Selection on S** (base): $T(R_2) = sel_2 \times T(S)$
3.  **Join R1 and R2**: $T(R_3) = sel_{join1} \times T(R_1) \times T(R_2)$
4.  **Selection on R3**: $T(R_4) = sel_4 \times T(R_3)$
5.  **Join R4 and T**: $T(R_5) = sel_{join2} \times T(R_4) \times T(T)$

### 1. Result Cardinality ($T(R_{out})$)
- **Selection ($\sigma_P$)**: $T(R_{out}) = sel(P) \times T(R_{in})$
- **Join ($\bowtie$)**: $T(R \bowtie S) = sel(join\ predicate) \times T(R_{left}) \times T(R_{right})$
  - Standard formula: $T(R \bowtie S) = \frac{T(R_{left}) \cdot T(R_{right})}{\max(V(R_{left}, A), V(R_{right}, B))}$
- **Projection ($\pi_A$)**: $T(R_{out}) = T(R_{in})$ (duplicates only removed with explicit `DISTINCT`)

### 2. Selectivity Factors ($sel$)
How much a predicate reduces the input size:
- $\land$ (AND) $\approx sel(P_1) \times sel(P_2)$ (Independence assumption)
- $\lor$ (OR) $\approx sel(P_1) + sel(P_2) - sel(P_1) \times sel(P_2)$
  - Simplified to $sel(P_1) + sel(P_2)$ in practice

#### Equality & Inequality
- **Equality** ($\sigma_{A=c}$): $\frac{1}{V(R, A)}$
- **Inequality** ($\sigma_{A\neq c}$): $1 - \frac{1}{V(R, A)}$

#### Range Predicates
- **Less than** ($\sigma_{A < c}$): $\frac{c - \text{Low}(R, A)}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Greater than** ($\sigma_{A > c}$): $\frac{\text{High}(R, A) - c}{\text{High}(R, A) - \text{Low}(R, A)}$
- **Between** ($\sigma_{c_1 \leq A \leq c_2}$): $\frac{c_2 - c_1}{\text{High}(R, A) - \text{Low}(R, A)}$

#### Joins
- **Equi-join** ($R \bowtie_{A=B} S$): $\frac{1}{\max(V(R, A), V(S, B))}$

### 3. Distinct Values ($V(R_{out}, A)$)
Estimating distinct values of attribute $A$ after an operation:

- **Selection ($\sigma_P(R_{in})$)**: $V(R_{out}, A) \approx \min(V(R_{in}, A), T(R_{out}))$
- **Join ($R \bowtie S$)**:
  - For join attribute $A$: $V(R \bowtie S, A) = \min(V(R_{left}, A), V(R_{right}, A))$ (due to containment)
  - For non-join attribute $B$ in $R$: $V(R \bowtie S, B) \approx \min(V(R_{left}, B), T(R \bowtie S))$
- **Projection ($\pi_A(R_{in})$)**: $V(\pi_A(R_{out}), A) = V(R_{in}, A)$

### 4. Value Ranges (Low/High)
- **Selection ($\sigma_{A > c}(R_{in})$)**: $\text{Low}(R_{out}, A) = \max(\text{Low}(R_{in}, A), c)$
- **Join ($R \bowtie_{A=B} S$)**:
  - $\text{Low}(R \bowtie S, A) = \max(\text{Low}(R_{left}, A), \text{Low}(R_{right}, B))$
  - $\text{High}(R \bowtie S, A) = \min(\text{High}(R_{left}, A), \text{High}(R_{right}, B))$

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
