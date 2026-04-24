# CSE351: Cache Locality

Locality of reference refers to the tendency of programs to access a small portion of their address space at any given time. This principle is what makes caching effective.

## Types of Locality

### Temporal Locality
**Temporal locality** exists when locations referenced recently tend to be referenced again in the near future. This occurs frequently in loops, where instructions and data are accessed repeatedly.

### Spatial Locality
**Spatial locality** exists when locations near recently referenced locations are likely to be referenced in the near future. This occurs with linear data structures like arrays, or when instructions are executed sequentially.

## Related
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]
- [[CSE351/Data Structures/Arrays|Arrays]]
