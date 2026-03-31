# Database Design: BCNF Decomposition

BCNF decomposition is the algorithm for eliminating [[Data Anomalies|data anomalies]] by successively splitting a relation until it reaches [[Normalization#BCNF|Boyce-Codd Normal Form]].

## What Is Decomposition?

**Decomposition** splits a schema into smaller parts.
- FDs, including the "bad" FD, follow into one of the split tables
- The goal is to isolate the non-superkey FD into its own table

![[Decomposing Schema.png]]
![[Decomposing Schema Using an FD Example.png]]

## The Algorithm

*Normalize*($R$):

$A \leftarrow$ the set of all attributes in $R$

**find** $X$ **s.t.** $X^+ \neq X$ **and** $X^+ \neq A$
- (Find an attribute set whose closure is neither trivial nor the full schema — i.e., $X$ is not a superkey but determines something extra)

**if** $X$ is not found:
- "$R$ is in BCNF" — stop

**else:**
- Decompose $R$ into:
	- $R_1(X^+)$
	- $R_2((A - X^+) \cup X)$
- *Normalize*($R_1$) — recurse
- *Normalize*($R_2$) — recurse

## Why This Works

The key insight from [[Closures and Keys]]:
- If $X$ is a superkey, $X \rightarrow B$ is fine — no anomaly
- If $X$ is **not** a superkey, $B$ leaks into $R$ and causes redundancy

By extracting $X^+$ into $R_1$ and keeping the rest in $R_2$ (with $X$ as a foreign key), the "bad" FD is isolated and the anomaly is eliminated.

## Related
- [[Normalization]] — defines BCNF and the normal forms
- [[Closures and Keys]] — the closure algorithm and superkey check used in each step
- [[Data Anomalies]] — the anomalies that BCNF eliminates
- [[Functional Dependencies (FDs)]] — the FDs that drive each decomposition step
