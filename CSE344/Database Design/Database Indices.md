# CSE344: Database Indices

## What Is an Index?

An **index** is a separate file that allows direct access to rows based on attribute(s).
- Does not change the underlying relation's representation
- The index file can be organized as:
	- **B+ tree** (minor variation on a B-tree) — supports range queries
	- **Hash table** — supports equality queries only
	- **Bit-map**, **R-tree**, etc.

Without an index, any query requires an $O(n)$ sequential scan — see [[Disk Storage#Querying Without Indices]].

## Creating an Index

```SQL
CREATE INDEX myIndex ON Flights(date);
```

![[What Index does Example.png]]

Creating an index creates a separate file alongside the relation. It is done only once, but may take time to build and store.

## Using an Index

- Can create zero or more indices on a table (on ID, name, date, etc.)
- Future SQL queries may run faster, slower, or the same speed, depending on whether the query optimizer chooses to use the index

## Multi-Attribute Indices

Given separate single-attribute indices:
```SQL
CREATE INDEX keyindex ON Flights(fid); -- typically done by DBMS
CREATE INDEX myIndex1 ON Flights(date);
CREATE INDEX myIndex2 ON Flights(origin);
```

A query filtering on both `date` and `origin` can only use one of the two single-attribute indices:
```SQL
SELECT *
FROM Flights
WHERE date = '2010/01/03'
AND origin = 'SEA';
```

With a composite index, the DBMS can use it directly:
```SQL
CREATE INDEX myIndex12 ON Flights(date, origin);
```

![[Multiple-Attriute Indices.png]]

A **multi-attribute index** is an index on the concatenation of attributes.

### Redundancy

```SQL
CREATE INDEX myIndex1 ON Flights(date);   -- redundant
CREATE INDEX myIndex2 ON Flights(origin); -- redundant
CREATE INDEX myIndex12 ON Flights(date, origin);
```

Single-attribute indices on `(date)` and `(origin)` are redundant when `(date, origin)` already exists — the DBMS can use the composite index for single-attribute lookups on the prefix.

## B+ Trees (In-Memory Structure)

- B+ trees are $n$-ary search trees
- Configuration is based on disk parameters
- All indexed attributes are stored in the search tree (kept in memory)
- All other attributes remain on disk
- Supports both equality lookups and range scans efficiently

## Related
- [[Clustered and Unclustered Indices]] — how the on-disk layout relates to index performance
- [[Disk Storage]] — the block structure that indices are built on top of
- [[External Memory Algorithms#Physical Selection Operators]] — how indices factor into query costs
- [[Physical Design and Indices]] — overview
