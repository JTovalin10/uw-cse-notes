# CSE444: Relational Model

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

## Related

- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — RA operators, joins, and SQL-to-RA conversion
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — query pipeline and storage manager overview
- [[CSE344/Query Execution/Relational Algebra|Relational Algebra]] — CSE344 in-depth RA operator coverage
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — CSE344 coverage of keys, foreign keys, and other constraints
- [[CSE344/Database Design/Functional Dependencies (FDs)|Functional Dependencies]] — formal basis for key constraints
