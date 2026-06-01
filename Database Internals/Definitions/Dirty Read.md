# **Dirty Read** (Write-Read Conflict)

### Formal Definition
A situation where a transaction $T_2$ reads a data item $X$ that was previously modified by transaction $T_1$, where $T_1$ has not yet issued a `COMMIT`. If $T_1$ subsequently performs a `ROLLBACK`, $T_2$ has processed state that never existed in the persistent database.

### Simple Explanation
**Reading "Unfinished" Work.**
Imagine you read a draft of a book before the author finishes. If the author decides to delete that whole chapter, you've now read something that "never happened." In databases, if a transaction reads data that hasn't been committed yet, and that transaction fails, the data you read disappears, making your work invalid.
