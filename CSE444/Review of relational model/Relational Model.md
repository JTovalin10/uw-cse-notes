# CSE444: Relational Model and Relational Algebra

---

## DBMS Architecture Overview

The **Query Processor** executes queries; the **Storage Manager** stores data.

![[DBMS Architecture.png]]

- **Buffer Manager**: memory cache for database pages
- **Access Methods**: store and retrieve tuples from disk

See [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] for the full query pipeline.

---

## Core Concepts

### Database, Relation, and Tuple

- **Database**: a collection of relations
- **Relation** (also called a **table**):
  - $R \subseteq S_1 \times S_2 \times \cdots \times S_n$
  - where $S_i$ is the **domain** of attribute $i$ and $n$ is the number of attributes
  - a relation is a **set** of tuples (no duplicates, no order)
- **Tuple** (also called a **row** or **record**):
  - $t \in S_1 \times S_2 \times \cdots \times S_n$
  - one element of the relation

### Schema

The **relational schema** describes the column headers:
- Relation name
- Name of each **field** (also called column or attribute)
- **Domain** of each field

**Degree** (or **arity**) of a relation: the number of attributes.

**Database schema**: the set of all relation schemas.

### Instance

- **Relation instance**: the concrete table content — a set of tuples matching the schema
- **Cardinality** of a relation instance: the number of tuples
- **Database instance**: the set of all current relation instances

---

## Integrity Constraints

An **integrity constraint** is a condition on the database schema that the DBMS enforces — only **legal** database instances (those satisfying all constraints) are allowed to exist.

The simplest form is a **domain constraint**: attribute values must come from the declared attribute domain.

### Key Constraints

- **Super key**: a set of attributes that functionally determines all other attributes
- **Candidate key** (or just **key**): a minimal super key — no proper subset is also a super key
- **Primary key**: one candidate key chosen as the designated identifier

```sql
CREATE TABLE Part (
    pno integer,
    ...,
    PRIMARY KEY (pno)
);

CREATE TABLE Supply (
    sno integer,
    pno integer,
    qty integer,
    price integer,
    PRIMARY KEY (sno, pno)
);
```

### Foreign Key Constraints

A **foreign key** is a field (or set of fields) in one relation that refers to the primary key of another relation. It enforces **referential integrity** — the referenced tuple must exist.

```sql
-- sno in Supply refers to Supplier(sno)
FOREIGN KEY (sno) REFERENCES Supplier(sno)
```

---

## Relational Query Language

Relational query languages are **set-at-a-time**: both inputs and outputs are relations.

Two variants:
- **Relational Algebra**: specifies a step-by-step order of operations (operational/procedural)
- **Relational Calculus / SQL**: declarative — says *what*, not *how*

### Relational Algebra

Queries specify an operational procedure:
- **Relational operators** take one or two relation instances as arguments and return one relation instance
- Operators compose into **relational algebra expressions** (trees)
- Note: each join operator takes exactly two inputs — joining 3+ relations requires multiple join operators

#### Sets vs. Bags

Relational algebra has two flavors:
- **Set semantics** (standard RA): no duplicate tuples
- **Bag semantics** (extended RA): duplicates allowed — SQL uses bag semantics by default; use `DISTINCT` to enforce set semantics

#### Five Basic Relational Operators

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

### Types of Joins

- **Theta Join**: $R \bowtie_\Theta S = \sigma_\Theta(R \times S)$
  - Join of $R$ and $S$ with an arbitrary join condition $\Theta$
  - Implemented as cross-product followed by selection
- **Equijoin**: $R \bowtie_\Theta S = \pi_A(\sigma_\Theta(R \times S))$
  - Join condition $\Theta$ consists only of equalities
  - Projection $\pi_A$ drops all redundant (duplicate) attributes

---

## SQL to Relational Algebra Conversion

SQL maps to relational algebra in the following operator order (note: FROM and WHERE are treated together as one step):

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

## Related
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline and storage manager overview
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — CSE344 in-depth RA operator coverage
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — detailed SQL-to-RA translation rules
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — CSE344 coverage of keys, foreign keys, and other constraints
- [[CSE344/SQL/Joins|Joins]] — SQL join syntax and semantics
- [[CSE344/Database Design/Functional Dependencies (FDs)|Functional Dependencies]] — formal basis for key constraints
