# Database Design: Data Anomalies

Data anomalies are problems that arise from poor relational schema design. They motivate [[Normalization|normalization]].

## Types of Anomalies

### Redundancy Anomaly
Redundant rows are:
- Unnecessary data
- Wasted space

### Update Anomaly
Redundant rows lead to:
- Slow updates
- Inconsistent data

Because updating one logical fact requires updating multiple rows, any missed row leaves the database in an inconsistent state.

### Deletion Anomaly
Unrelated columns stored in the same table lead to undefined deletions — deleting one piece of information may unintentionally destroy another unrelated piece of information.

## Prevention

- **Separate unrelated attributes/columns** into their own tables
	- Prevents redundancy, inconsistent updates, and undefined deletions

### Informal Design Guidelines
- Semantics of attributes should be self-evident
- Avoid redundant information in tuples
- Avoid NULL values in tuples
- Disallow the generation of "spurious" tuples — if certain tuples shouldn't exist, enforce that constraint

## Design Theory

**Design theory** is a formalism that identifies anomalies and tells us how to remove them using [[Functional Dependencies (FDs)|functional dependencies]].
- FDs can rigorously explain why splitting a table eliminates anomalies
- The formal process:
	1. Start with a relational schema
	2. Find its FDs
	3. Use the FDs to normalize the schema into [[Normalization#BCNF|BCNF]]

## Related
- [[Normalization]] — the formal process for eliminating anomalies
- [[Functional Dependencies (FDs)]] — the formalism used to identify anomalies
- [[BCNF Decomposition]] — the algorithm that eliminates anomalies
