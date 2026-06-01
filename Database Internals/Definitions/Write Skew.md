# **Write Skew**

### Formal Definition
A concurrency anomaly possible under [[CSE444/Transactions/Optimistic Components/Snapshot Isolation|Snapshot Isolation]] where two transactions $T_1$ and $T_2$ read overlapping data sets $R_1, R_2$, and then update disjoint sets $W_1, W_2$ such that a cross-record constraint $\phi$ is violated, even though $W_1 \cap W_2 = \emptyset$.

### Simple Explanation
**The "Black and White" Problem.**
Imagine a rule: "There must always be at least one doctor on call." 
Two doctors, Alice and Bob, are both on call. Both decide they want to go home. 
1. Alice looks at the system, sees Bob is on call, and signs off.
2. Bob looks at the system (at the same time), sees Alice is on call, and signs off.
Both transactions commit because they didn't change the *same* record, but now **zero** doctors are on call. The rule is broken because they both acted based on a "snapshot" that changed.
