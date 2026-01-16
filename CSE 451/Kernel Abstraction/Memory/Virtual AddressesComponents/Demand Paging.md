# Demand Paging (Memory Overcommitment)
```
Process "needs" 1GB
→ Page table has 1GB of entries
→ Only allocate physical frames when pages are accessed
→ Actually using 50MB of RAM
```

The OS can promise more memory than physically available, only allocating frames when actually needed.
