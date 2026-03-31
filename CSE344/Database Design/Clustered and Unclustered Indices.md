# Database Design: Clustered and Unclustered Indices

## Scans vs. Selections

- **Selections** are satisfied by a relatively small number of tuples (e.g., find tuples where `attribute = 40`)
	- Performance goal: beat a sequential scan
- **Range scans** are satisfied by many tuples (e.g., find tuples where `attribute` is in `(40–85]`)
	- Goal: minimize unnecessary disk I/O
	- Typical approach: find the first tuple that satisfies the condition, then load subsequent tuples into memory

## Clustered Index

A **clustered index** is one whose tuples are physically ordered on disk in the same order as the index's key.
- Created when you index the attribute(s) by which the main data is already ordered
- Typically, only one clustered index per table

```SQL
CREATE CLUSTERED INDEX DateIndex ON Flights(date);
```

![[Cluster Index.png]]

- **Selection**: look up the index key → retrieve the corresponding tuple
- **Range scan**: look up the first matching key → load subsequent tuples sequentially (cheap, because they are contiguous on disk)

## Unclustered Index

An **unclustered index** does not store its data in sorted order — it stores pointers to tuples scattered across disk.
- A table can have any number of unclustered indices

```SQL
CREATE UNCLUSTERED INDEX DateIndex ON Flights(date);
```

An unclustered index's ordering differs from the on-disk tuple ordering.

![[Unclustered Index.png]]

- **Selection**: look up the index → follow pointer to the matching tuple
- **Range scan**: look up matching index keys → follow pointers to each tuple — may need to reload blocks repeatedly if the cache fills up (expensive for large ranges)

## When to Use Each

| Scenario | Recommendation |
|---|---|
| Frequent range scans on large tables | **Clustered index** — sequential disk reads are far cheaper |
| Point lookups on secondary attributes | **Unclustered index** — fine for small result sets |
| Multiple access patterns on same table | One clustered + multiple unclustered indices |

## Related
- [[Database Indices]] — creating indices and multi-attribute indices
- [[Disk Storage]] — why physical ordering on disk matters for performance
- [[External Memory Algorithms#Physical Selection Operators]] — cost formulas that depend on clustered vs. unclustered
