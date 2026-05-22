# CSE444: Relational Model

The **Relational Model** is the mathematical foundation for modern database systems, where data is organized into sets of records called relations.

---

## Core Concepts

### Database, Relation, and Tuple

- **Database**: A collection of named **Relations**.
- **Relation** (also called a **Table**):
  - Formally: $R \subseteq S_1 \times S_2 \times \cdots \times S_n$
  - Where $S_i$ is the **Domain** of attribute $i$ and $n$ is the number of attributes.
  - A relation is a **Set** of tuples (no duplicates, no inherent order).
- **Tuple** (also called a **Row** or **Record**):
  - Formally: $t \in S_1 \times S_2 \times \cdots \times S_n$
  - A single element of a relation representing an entity or relationship.

### Schema

The **Relational Schema** describes the structure of a relation:
- **Relation Name**
- **Field Name** (also called **Column** or **Attribute**)
- **Domain** of each field (the set of allowed values, e.g., `integer`, `string`).

**Degree** (or **Arity**) of a relation: The number of attributes ($n$).

**Database Schema**: The set of all relation schemas in the database.

### Instance

- **Relation Instance**: The concrete content of a table at a specific point in time — a set of tuples matching the schema.
- **Cardinality** of a relation instance: The number of tuples in the instance.
- **Database Instance**: The set of all current relation instances.

---

## Integrity Constraints

An **Integrity Constraint** is a condition on the database schema that the DBMS must enforce. Only **Legal** database instances (those satisfying all defined constraints) are allowed to exist.

The simplest form is a **Domain Constraint**: Attribute values must strictly belong to the declared attribute domain.

### Key Constraints

- **Super Key**: A set of attributes that functionally determines all other attributes in the relation (no two distinct tuples can have the same values for these attributes).
- **Candidate Key** (or just **Key**): A **Minimal** super key — no proper subset of the attributes is also a super key.
- **Primary Key**: One candidate key chosen by the designer as the principal identifier for tuples.

```sql
CREATE TABLE Part (
    pno integer,
    pname varchar(50),
    PRIMARY KEY (pno)
);

CREATE TABLE Supply (
    sno integer,
    pno integer,
    qty integer,
    PRIMARY KEY (sno, pno)
);
```

### Foreign Key Constraints

A **Foreign Key** is a field (or set of fields) in one relation that refers to the **Primary Key** of another relation. It enforces **Referential Integrity**, ensuring that the referenced entity exists.

```sql
-- sno in Supply refers to Supplier(sno)
FOREIGN KEY (sno) REFERENCES Supplier(sno)
```

---

## Industry Standard Terms
- **Relation** $\rightarrow$ Table
- **Tuple** $\rightarrow$ Row / Record
- **Attribute** $\rightarrow$ Column / Field
- **Degree** $\rightarrow$ Arity / Column Count
- **Cardinality** $\rightarrow$ Row Count

## Related
- [[CSE444/Review of relational model/Relational Algebra|Relational Algebra]] — RA operators, joins, and SQL-to-RA conversion
- [[CSE444/DBMS architecture and deployments/Architecture|DBMS Architecture and Query Processing]] — how the storage manager handles relations
- [[CSE344/Query Execution/Relational Algebra|CSE344 Relational Algebra]]
- [[Integrity Constraints|CSE344 Integrity Constraints]]
- [[Functional Dependencies (FDs)|Functional Dependencies]] — the formal basis for key identification
