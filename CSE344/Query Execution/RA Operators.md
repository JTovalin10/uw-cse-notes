# CSE344: RA Operators

All operators take one or two relations as input and return a new relation. See [[Relational Algebra]] for an overview of RA.

## Sets vs. Bags

- **Sets**: $\{a, b, c\}$, $\{a, d, e, f\}$, $\{\}$ — no duplicates
- **Bags**: $\{a, a, b, c\}$, $\{b, b, b, b, b\}$ — duplicates allowed

Relational Algebra has two flavors:
- **Set semantics** = standard relational algebra
- **Bag semantics** = extended relational algebra

## Reference Images

![[Basic RA Operators.png]]
![[Other RA Operators 1.png]]
![[Other RA Operators 2.png]]

## Unary Operators

### Projection $\pi$ $\equiv$ SELECT
- Removes unspecified columns — output relation has a different schema
- Can have set or bag semantics
- Example: $\pi_{A, B}(R)$ returns the $A$ and $B$ attributes of $R$

### Selection $\sigma$ $\equiv$ WHERE
- Filters tuples from the input using a provided predicate
- Output relation has the same schema as the input
- Example: $\sigma_{A < 6}(R)$ returns all tuples where $A < 6$

### Grouping $\gamma$ $\equiv$ GROUP BY
- $\gamma_{\text{attributes, aggregates}}$
- Both schema and cardinality may change
- Specifies grouped attributes, then aggregates
- The only operation that can compute aggregates
$$\gamma_{A,\; \max(B) \rightarrow mB}(R(A, B, C)) \rightarrow S(A, mB)$$

### Sorting $\tau$ $\equiv$ ORDER BY
- Schema and cardinality don't change
- Orders the input by any of its columns (default: ascending)
$$\tau_{A, B}(R(A, B, C)) \rightarrow S(A, B, C)$$

### Deduplication $\delta$ $\equiv$ DISTINCT
- Deduplicates tuples; may change cardinality but not schema
- Same as grouping by all attributes
$$\delta(T(A, B, C)) \rightarrow R(A, B, C)$$

## Binary Operators

### Union $\cup$ and Intersection $\cap$
- Inputs must have the same schema
- Can have set or bag semantics

### Difference $-$ (or $\setminus$)
- Direction matters
- Both inputs must have the same schema
$$R(A, B) - S(A, B) \rightarrow T(A, B)$$

### Cross Product $\times$ (Cartesian Product)
- The two inputs must have disjoint attributes
$$R(A, B) \times S(C, D) \rightarrow T(A, B, C, D)$$

## Join Operators

### Equijoin $\bowtie_{attr1 = attr2}$
- Explicitly-specified equality condition
- The two inputs must have disjoint attributes; returns all columns including the duplicated column
- Logically equivalent to cross product + selection: $R \bowtie_{B = C} S = \sigma_{B = C}(R \times S)$
- Database systems use specialized implementations — never computes via cross product
$$R(A, B) \bowtie_{R.A = S.C} S(C, D) \rightarrow T(A, B, C, D)$$

### Theta-Join $\bowtie_\theta$
- Binary operation with any predicate (not just equality)
- The two inputs must have disjoint attributes
- An equijoin is a theta-join with an equality predicate
$$R(A, B) \bowtie_{B \leq C} S(C, D) \rightarrow T(A, B, C, D)$$

### Natural Join $\bowtie$
- No parameters — performs an equijoin on all commonly-named attributes, returning one copy of shared columns
- *Unintuitive gotcha:* special-case behavior when operands share all or no column names:
	- All matching columns: returns the intersection $R \cap S$
	- No matching columns: returns the Cartesian product $R \times S$
$$R(A, B) \bowtie S(B, C) \rightarrow T(A, B, C)$$

### Semi-join $\ltimes$
- Returns tuples on the left that join with at least one tuple on the right
	- Same schema as the left table
	- If multiple matches exist, only one tuple is returned
- "Filters" the left table using tuples from the right — compare against $\sigma$, which filters on a single predicate
$$R(A, B) \ltimes S(B, C) \rightarrow T(A, B)$$

### Outer Joins
![[Outer Joins Variations.png]]
- Left, right, and full outer joins
- Variant applicable to all join types above — unmatched rows are preserved and padded with NULLs

## Related
- [[Relational Algebra]] — overview, query plan trees, and why joins are so common
- [[SQL to RA Translation]] — how SQL operators map to these RA operators
- [[RA Tree Transformations]] — rewriting rules using these operators
- [[Physical Algorithms and Pipelining]] — how these logical operators are physically implemented
- [[Main Memory Join Algorithms]] — specific implementations of the join operators
- [[CSE344/SQL/Joins|Joins]] — the SQL syntax for join operators
- [[CSE344/SQL/Outer Joins|Outer Joins]] — SQL-level outer join syntax
- [[CSE344/SQL/Set Operations|Set Operations]] — SQL counterparts to union/intersection/difference
- [[CSE344/SQL/Aggregates|Aggregates]] — SQL counterpart to grouping $\gamma$
- [[CSE344/SQL/ORDER BY and DISTINCT|ORDER BY and DISTINCT]] — SQL counterparts to sorting $\tau$ and deduplication $\delta$
