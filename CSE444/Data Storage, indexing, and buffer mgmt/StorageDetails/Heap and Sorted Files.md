# Indexing: Heap and Sorted Files

## Heap File Access Methods

### API

| Operation | Description |
|-----------|-------------|
| Create / Destroy | Create or delete a file |
| Insert | Insert a record |
| Delete | Delete a record by **RID** (unique tuple identifier) |
| Get | Retrieve a specific record by RID — used with indexes |
| Scan | Iterate over all records in the file |

- Sequential scan is fine for small tables, but becomes a bottleneck as the database grows

### Access by Attribute Value

Examples of attribute-based queries:
- `SELECT * FROM Supplier WHERE city = 'seattle'`
- `SELECT * FROM Student WHERE GPA > 3.5`
- `SELECT * FROM Student WHERE SID = 12345` — point lookup

#### Searching in a Heap File

- A heap file is **not sorted** on any attribute
- Attribute-based queries require a full sequential scan

![[Screenshots/Searching in a Heap File.png]]

#### Sorted File (Sequential File)

A file sorted on an attribute (usually the primary key) — we say the attribute is **indexed**.

```sql
CREATE INDEX s_sid ON Student(sid);

-- To force physical sorting:
CREATE CLUSTERED INDEX s_sid ON Student(sid);
```

- Binary search is possible: $O(\log_2 n)$ cost
- See [[CSE344/Database Design/Clustered and Unclustered Indices|Clustered and Unclustered Indices]]

![[Screenshots/Sequential File.png]]

**Limitations of Sorted Files:**
- The $\log_2 n$ binary search only applies to the indexed attribute
- Queries on other attributes still require a full sequential scan — solved by adding a **secondary index**
