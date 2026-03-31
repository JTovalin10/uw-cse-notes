# Database Design: Entities, Relationships, and ER Diagrams

**Database Design** (also called **Logical Design** or **Relational Schema Design**) organizes data by considering what data needs to be stored and the interrelationships of that data.

## ER Diagrams

**ER (Entity-Relationship) Diagrams** visually describe:
1. The data
2. Its interrelationships

![[ER Model Relationship Example.png]]

### Why ER Diagrams?
- Our application uses an ER diagram to conceptualize and communicate its design
	- They are rigorous, so we can cleanly map concepts into code
	- They are standardized, so we can communicate ideas and solicit design feedback

## Components

### Entity Sets and Attributes

![[ER Diagram Building Blocks.png]]

- An **entity set** is like a class — a description of the data
- An **attribute** is like a class field
- An **entity** is like a specific object — an actual piece of data; corresponds to a specific row

![[ER Diagrams Example.png]]

```SQL
CREATE TABLE Person (
	ssn INT PRIMARY KEY,
	name VARCHAR(...),
	address VARCHAR(...)
);
```

### Relationships: Multiplicity and Multi-Way

If $A$ and $B$ are entity sets, a **relationship** is a subset of $A \times B$.

![[Component Relationship.png]]

```SQL
CREATE TABLE WorksIn (
	pname VARCHAR(100) REFERENCES Person,
	cname VARCHAR(100) REFERENCES Company
);
```

Relationships can also have attributes (e.g., a company makes a product on a given date).

#### Relationship Multiplicity

1. **One-to-one**: when referencing the other table, use `UNIQUE REFERENCES`
2. **Many-to-one**: create a join table; the "one" side uses `UNIQUE REFERENCES`, the "many" side uses `REFERENCES`
3. **Many-to-many**: create a join table where all foreign keys use `REFERENCES` and the `PRIMARY KEY` is the combination of all foreign keys

```SQL
CREATE TABLE Purchase (
	cname VARCHAR(100) REFERENCES Company,
	pname VARCHAR(100) REFERENCES Product,
	bname INT REFERENCES Buyer,
	PRIMARY KEY (cname, pname, bname),
	...
);
```

![[Relationship Multiplictrty.png]]

#### Multi-Way Relationships

If $A$, $B$, and $C$ are entity sets, a relation $R$ is a subset of $A \times B \times C$.

### Subclassing and Weak Entity Sets

An entity set may be a **subclass** of another entity set — it implicitly inherits all the attributes, keys, and relationships of the superclass. In SQL, this is represented via foreign keys.

A **weak entity set** is one whose key includes the key from another entity set.
- Implies that subclasses are weak entities
- The weak entity set and its relationship to the other entity set's key are depicted with double outlines

![[weak entity set.png]]

```SQL
CREATE TABLE University (
	name VARCHAR(64) PRIMARY KEY,
	size INTEGER
);
CREATE TABLE Team (
	tname VARCHAR(64),
	uname VARCHAR(64) REFERENCES University,
	sport VARCHAR(64),
	PRIMARY KEY (tname, uname)
);
```

### Union Types

Sometimes you want a relationship where an entity set relates to the union of two other entity sets — an entity has a relationship with ES1 **xor** ES2.

When creating an ER diagram, include edge cases such as whether entities can participate in multiple relationships — this may require adjusting the diagram or adding a unique key to convey the constraint.

## Integrity Constraints

See [[Integrity Constraints]] for:
- `CHECK` constraints (attribute-level and tuple-level)
- Global assertions
- Referential integrity actions on update/delete (`CASCADE`, `SET NULL`, `SET DEFAULT`)

## Related
- [[Integrity Constraints]] — enforcing application rules in the schema
- [[Normalization]] — what to do when an ER design has anomalies
- [[CSE344/SQL/Create Table]] — SQL syntax for creating the tables derived from ER diagrams
