# Database Internals: Unrepeatable Read

An **Unrepeatable Read** (Read-Write Conflict) is a situation where a transaction reads the same data item twice and finds different values because another transaction modified and committed that data in between the two reads.

This anomaly is prevented at the **[[Database Internals/Transactions/Isolation Levels|Repeatable Read]]** isolation level and above, where long-duration read locks prevent another transaction from modifying a row that has been read. It is distinct from the **[[Database Internals/Transactions/Phantom Problem|Phantom Problem]]**, which involves new rows appearing rather than existing rows changing.

## Industry Standard Terms
- **Unrepeatable Read** $\rightarrow$ Non-repeatable read / Read-Write (RW) Conflict; defined in the ANSI SQL standard

## Related
- [[Database Internals/Transactions/Concurrency Anomalies|Concurrency Anomalies]]
- [[Database Internals/Transactions/Isolation Levels|Isolation Levels]]
- [[Database Internals/Transactions/Phantom Problem|Phantom Problem]]
