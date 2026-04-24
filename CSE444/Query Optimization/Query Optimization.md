# CSE444: Query Optimization

The **query optimizer** is the "brain" of a DBMS. Its goal is to transform a **logical query plan** into the most efficient **physical query plan** by evaluating the estimated costs of many equivalent alternatives.

## Core Optimization Process

1. **[[CSE444/Query Optimization/OptimizationComponents/Search Space|Enumerate Alternative Plans]]**: Generate many possible equivalent logical and physical plans using algebraic identities and different access paths.
2. **[[CSE444/Query Optimization/OptimizationComponents/Cost Estimation|Estimate Costs]]**: For each candidate plan, calculate the total cost (primarily **I/O**) based on database statistics and cardinality estimation.
3. **[[CSE444/Query Optimization/OptimizationComponents/Dynamic Programming|Search for Optimal Plan]]**: Use algorithms like Dynamic Programming to efficiently find the cheapest plan within the search space.

## Key Concepts

- **[[CSE444/Query Optimization/OptimizationComponents/Cost Estimation#Database Statistics|Database Statistics]]**: Histograms and cardinalities ($T(R)$, $B(R)$, $V(R,a)$) used to predict result sizes.
- **[[CSE444/Query Optimization/OptimizationComponents/Join Trees|Join Trees]]**: Different tree shapes (Bushy vs. Left-Deep) that define the search space.
- **Cost-Based Optimization**: Modern approach using cost models rather than simple greedy heuristic rules.

---
## Related
- [[CSE444/Query Evaluation/Operator Algorithms|Operator Algorithms]] — Specific costs for join and sort implementations.
- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — The basis for plan transformations.
- [[CSE444/Query Evaluation/Query Execution & Algorithms|Query Execution]] — How the final plan is carried out.
