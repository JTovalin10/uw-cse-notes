# Database Internals: Relational Algebra

---

## Relational Query Language

Relational query languages are **set-at-a-time**: both inputs and outputs are relations.

Two variants:
- **Relational Algebra**: specifies a step-by-step order of operations (operational/procedural)
- **Relational Calculus / SQL**: declarative — says *what*, not *how*

### Sets vs. Bags

Relational algebra has two flavors:
- **Set semantics** (standard RA): no duplicate tuples
- **Bag semantics** (extended RA): duplicates allowed — SQL uses bag semantics by default; use `DISTINCT` to enforce set semantics

---

## Five Basic Relational Operators

Queries are built by composing **relational operators**, each of which takes one or two relation instances as arguments and returns one relation instance. Operators compose into **relational algebra expression trees**. Note that join takes exactly two inputs — joining 3+ relations requires multiple join operators.

![[Five Basic Relational Operators.png]]

| Operator | Symbol | SQL Equivalent | Description |
|----------|--------|---------------|-------------|
| **Selection** | $\sigma_c(R)$ | `WHERE` | Keeps tuples satisfying condition $c$; output schema = input schema |
| **Projection** | $\pi_A(R)$ | `SELECT` | Keeps only the attributes listed in $A$; output schema has fewer columns |
| **Cross Product** | $R \times S$ | `FROM R, S` | All combinations of tuples from $R$ and $S$; inputs must have disjoint attributes |
| **Union** | $R \cup S$ | `UNION` | All tuples in $R$ or $S$; inputs must have the same schema |
| **Difference** | $R - S$ | `EXCEPT` | Tuples in $R$ but not in $S$; inputs must have the same schema |

**Derived operators** (all expressible using the five above):
- **Intersection**: $R \cap S = R - (R - S)$
- **Join**: $R \bowtie_\Theta S = \sigma_\Theta(R \times S)$ — cross product then filter
- **Natural Join**: $R \bowtie S$ — equijoin on all commonly-named attributes

---

## Types of Joins

- **Theta Join**: $R \bowtie_\Theta S = \sigma_\Theta(R \times S)$
  - Join of $R$ and $S$ with an arbitrary join condition $\Theta$
  - Implemented as cross product followed by selection
- **Equijoin**: $R \bowtie_\Theta S = \pi_A(\sigma_\Theta(R \times S))$
  - Join condition $\Theta$ consists only of equalities
  - Projection $\pi_A$ drops all redundant (duplicate) attributes
- **Natural Join**: $R \bowtie S$
  - Equijoin on all attributes with the same name in both schemas
  - Automatically drops duplicate columns

---

## SQL to Relational Algebra Conversion

SQL maps to relational algebra in the following operator order (FROM and WHERE are treated together as one step):

1. **FROM** (cross product / join)
2. **WHERE** (selection $\sigma$)
3. **GROUP BY** (grouping $\gamma$)
4. **HAVING** (selection after grouping)
5. **ORDER BY**
6. **SELECT** (projection $\pi$)

![[Basic SQL to RA Conversion.png]]

**Notation notes**:
- $\gamma_{P.userId,\ P.name,\ count(*) \to cnt}$ means: group by those attributes and rename the count to `cnt`
- Everything following `GROUP BY` operates on the grouped result
- `DISTINCT` is represented by $\delta$ (duplicate elimination)

#### Examples

![[Eng to SQL 1.png]]
![[Eng to SQL 2.png]]

---

## Industry Standard Terms

| Course Term | Industry / Standard Term |
|---|---|
| Relational algebra (RA) | Query language / logical query language |
| Selection $\sigma$ | `WHERE` clause / filter |
| Projection $\pi$ | `SELECT` clause |
| Cross product $\times$ | `CROSS JOIN` / Cartesian product |
| Natural join $\bowtie$ | `NATURAL JOIN` |
| Theta join $\bowtie_\Theta$ | `JOIN ... ON` |
| Set difference $-$ | `EXCEPT` / `MINUS` |
| Bag semantics | Multiset semantics |
| Duplicate elimination $\delta$ | `DISTINCT` |

## Related

- [[Database Internals/Review of Relational Model/Relational Model|Relational Model]] — database/relation/tuple definitions, schema, integrity constraints
- [[Database Internals/DBMS Architecture and Deployments/Architecture|DBMS Architecture]] — how the optimizer turns RA expressions into physical query plans
- [[Database Internals/DBMS Architecture and Deployments/Subsystems/Query Pipeline|Query Processing Pipeline]] — the optimizer stage where RA logical plans are generated
- [[Introduction to Data Management/Query Execution/Relational Algebra|CSE344 Relational Algebra]] — in-depth RA operator coverage from the prerequisite course
- [[SQL to RA Translation|SQL to RA Translation]] — detailed SQL-to-RA translation rules
