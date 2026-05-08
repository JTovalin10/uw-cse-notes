# CSE344: SQL Basics

## Data Models

A **Data Model** is a mathematical formalism to describe data.
- Allows us to talk about data conceptually without having to think about implementation

A data model has 3 components:
- **Instance**: the actual data
- **Schema**: description of what is being stored
- **Query Language**: how to retrieve or manipulate it

## Relational Model

- Has **Set** or **Bag Semantics**.
	- SQL tables have **Bag Semantics** (duplicates allowed).
	- Relations have **Set Semantics** (no duplicates).
- Attributes are typed and static.
- Relations are flat.

## What is SQL

- **Structured Query Language (SQL)**
	- One of the many languages for querying relational data.
	- Most widely used language to query relational data.
- A **Declarative** programming language.
	- We describe *what* we want, not *how* to get it — see [[CSE344/SQL/Physical Data Independence|Physical Data Independence]]

## Query Structure

- **SELECT**: which attributes we want
- **FROM**: which table(s) we query
- **WHERE**: predicate saying which rows we want

```sql
SELECT URL, Title
FROM URLS
WHERE NumVisits > 5;
```

![[Query Mental Model.png]]

## For-Each Semantics

**For-each semantics** is how we should conceptualize SQL's execution:

```sql
SELECT Name, UserId
FROM Payroll
WHERE Job = 'TA';
```

Becomes:

```c
foreach row in Payroll:
	if row.Job == 'TA':
		output(row.Name, row.UserId)
```

## Keys

- A **Key** is one or more attributes that **uniquely** identify a row.
- See [[CSE344/SQL/Create Table#Keys|Create Table#Keys]] for syntax.

### Foreign Keys

- Databases can hold multiple tables.
- A **Foreign Key** is one or more attributes that uniquely identify a row in another table.
- Describes a relationship between tables — used by [[CSE344/SQL/Joins|Joins]] to combine data.

## Related
- [[CSE344/SQL/Create Table|Create Table]] — DDL syntax for tables and keys
- [[CSE344/SQL/Joins|Joins]] — combining multiple tables on foreign keys
- [[CSE344/SQL/ORDER BY and DISTINCT|ORDER BY and DISTINCT]] — set vs. bag semantics in practice
- [[CSE344/SQL/Physical Data Independence|Physical Data Independence]] — why SQL is declarative
- [[CSE344/Database Design/Integrity Constraints|Integrity Constraints]] — rules enforced by the DBMS
- [[CSE344/Query Execution/SQL to RA Translation|SQL to RA Translation]] — how SQL is compiled to relational algebra
