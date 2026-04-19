# CSE344: Functional Dependencies (FDs)

A **Functional Dependency** $A_1, ..., A_m \rightarrow B_1, ..., B_n$ holds in relation $R$ if:
$$
\forall t, t' \in R \;(t.A_1 = t'.A_1 \land \cdots \land t.A_m = t'.A_m \;\rightarrow\; t.B_1 = t'.B_1 \land \cdots \land t.B_n = t'.B_n)
$$

Informally, an FD says that some attributes **determine** other attributes.

**Examples of FDs from "real life":**
- FullName $\rightarrow$ Initials
- ModelNumber $\rightarrow$ Capacity
- UserId $\rightarrow$ Name

Note: dependency doesn't imply causation.

## Terminology

Within an FD $A_1, ..., A_m \rightarrow B_1, ..., B_n$:
- $A_1, ..., A_m$ is the **antecedent** (or **determinant**)
- $B_1, ..., B_n$ is the **consequent**
- We say the antecedent **yields** the consequent

An FD either holds or doesn't hold on an instance of $R$. $R$ **satisfies** an FD if every instance of $R$ is one in which the FD is true. If $R$ satisfies an FD, that FD is a **constraint** on $R$.

![[FDs that hold example.png]]

## Reasoning About FDs

Some FDs logically imply other FDs.

**Example:** given Restaurant(id, name, city, rating, popularity, ...)
- If `rating → popularity` and `city, popularity → recommendation`
- Then `city, rating → recommendation` also holds

## Armstrong's Axioms

- **Reflexivity (Trivial FD):** If $B \subseteq A$, then $A \rightarrow B$
- **Augmentation:** If $A \rightarrow B$, then $\forall C, \; AC \rightarrow BC$
- **Transitivity:** If $A \rightarrow B$ and $B \rightarrow C$, then $A \rightarrow C$

**Secondary rules:**
- **Pseudo-transitivity:** If $A \rightarrow BC$ and $C \rightarrow D$, then $A \rightarrow BD$
- **Extensivity:** If $A \rightarrow B$, then $A \rightarrow AB$

## Related
- [[Normalization]] — using FDs to normalize a schema into BCNF
- [[Closures and Keys]] — computing $X^+$ and determining superkeys from FDs
- [[BCNF Decomposition]] — the algorithm driven by FDs
- [[Data Anomalies]] — the anomalies FDs help identify
- [[Integrity Constraints]] — another way constraints are expressed in a schema
