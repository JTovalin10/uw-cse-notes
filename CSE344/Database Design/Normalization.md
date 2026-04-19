# CSE344: Normalization

Normalization is the process of restructuring a relational schema to eliminate [[Data Anomalies|data anomalies]] using [[Functional Dependencies (FDs)|functional dependencies]].

## Process Overview

1. Start with a relational schema: $R(A_1, A_2, A_3, ...)$
2. Identify [[Data Anomalies]] (redundancy, update, deletion)
3. Find the schema's [[Functional Dependencies (FDs)|functional dependencies]]
4. Compute [[Closures and Keys|closures and keys]]
5. Apply [[BCNF Decomposition]] until the schema is in BCNF

## Normal Forms

### 1NF (First Normal Form)

All attribute values are **atomic** — multivalued attributes and nested relations are not allowed.
- We call data in 1NF "flat"
- This is the minimum requirement for a relation

### BCNF (Boyce-Codd Normal Form)

For every non-trivial functional dependency $X \rightarrow C$, $X$ must be a **superkey**.
- Equivalently: $\forall X$ either $X^+ = X$ (trivial) or $X^+ = A$ (full schema — i.e., $X$ is a superkey)
- If a relation is in BCNF, it **does not have** the redundancy, update, or deletion anomalies
- If it is **not** in BCNF, it **does** have these anomalies

## Key Topics

- [[Data Anomalies]] — redundancy, update anomaly, deletion anomaly, and informal design guidelines
- [[Functional Dependencies (FDs)]] — formal definition, Armstrong's axioms, reasoning about FDs
- [[Closures and Keys]] — closure algorithm, superkeys, keys, candidate keys
- [[BCNF Decomposition]] — the recursive decomposition algorithm with worked examples

## Related
- [[Entities, Relationships, and ER Diagrams]] — design starting point before normalization
- [[Physical Design and Indices]] — physical design follows after logical normalization
