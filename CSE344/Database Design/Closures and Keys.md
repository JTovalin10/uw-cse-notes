# Database Design: Closures and Keys

Closures and keys are the tools used to reason about [[Functional Dependencies (FDs)|functional dependencies]] and drive [[BCNF Decomposition|normalization]].

## Closures

The **closure** of the set $\{A_1, ..., A_m\}$, written as $\{A_1, ..., A_m\}^{+}$, is the set of all attributes $B$ such that $A_1, ..., A_m \rightarrow B$.

A closure finds **everything a set of attributes determines**.

**Example:** given the functional dependencies:
- Name $\rightarrow$ Initials
- ID $\rightarrow$ Name

The following closures hold:
- $\text{Name}^+ = \{\text{Name, Initials}\}$
- $\text{ID}^+ = \{\text{ID, Name, Initials}\}$
- $\text{Initials}^+ = \{\text{Initials}\}$

### Closure Algorithm

**Inputs:** $X = \{A_1, ..., A_m\}$
**Output:** $X^+$

Repeat until $X$ does not change:
- If $B_1, ..., B_n \rightarrow C$ is a FD and $B_1, ..., B_n \in X$
- Then $X \leftarrow X \cup \{C\}$

Return $X$.

- This is repeated application of transitivity (Armstrong's Axioms)
- Algorithm steps:
	1. Find some attribute(s) $C$ to add to the right side
	2. Add them
	3. Look back at the FDs to find more $C$
- To check if $A \rightarrow B$: simply check if $B \subseteq A^{+}$
	- Equivalent to, and much simpler than, repeatedly applying Armstrong's axioms

## Keys

### Formal Definitions

A **superkey** of relation $R$ is a set of attributes $A_1, ..., A_n$ such that for any attribute $B$:
$$A_1, ..., A_n \rightarrow B$$

In other words, $\{A_1, ..., A_n\}$ is a superkey iff $\{A_1, ..., A_n\}^+ =$ all attributes of $R$.

A **key** is a minimal superkey — no proper subset of a key is itself a superkey.

A **candidate key** is any key when a relation has multiple keys.

### Keys in SQL
- A relation may have more than one key
- When creating the table, designate one as `PRIMARY KEY`
- For all others, declare them `UNIQUE`

### Usefulness in Design

FDs whose antecedent is **not** a superkey hint at redundancy — the consequent can be extracted into another relation:
- If $A$ is a superkey, $A \rightarrow B$ is fine
- If $A$ is **not** a superkey, $B$ should be removed from $R$

This is exactly the condition checked in [[BCNF Decomposition|BCNF decomposition]].

## Related
- [[Functional Dependencies (FDs)]] — the FDs that closures are computed over
- [[BCNF Decomposition]] — uses closures and superkey checks to decompose relations
- [[Normalization]] — the broader normalization context
