# CSE351: Cache Organization

## Cache Parameters

A cache is characterized by four parameters:

| Parameter | Meaning |
|:---|:---|
| $K$ | Block size in bytes |
| $C$ | Total cache capacity in bytes |
| $E$ | **Associativity** — number of lines (ways) per set |
| $S$ | Number of sets: $S = C / (K \cdot E)$ |

To locate data, the $\log_2(S)$ lowest-order bits of the block number index into the set:
- **Direct-mapped** ($E = 1$): $s = \log_2(C/K)$ index bits
- **Fully associative** ($E = C/K$): $s = 0$ (no set indexing — tag compared against every line)

## Block Placement and Replacement

Each cache line has a **valid bit** stored in its metadata (0 = empty, 1 = in use).

On a cache miss, if the target set has an empty line the block is placed there. When all lines in a set are occupied, a **replacement policy** selects the victim:

- **Direct-mapped**: no choice — only one line per set.
- **Set/fully associative**: ideally **LRU (Least Recently Used)**, but hardware typically uses an approximation due to cost.

## Types of Misses: The 3 C's

| Miss Type | Cause | How to Reduce |
|:---|:---|:---|
| **Compulsory** (cold-start) | First-ever access to a block — always unavoidable | Larger block size |
| **Conflict** | Block maps to a full set even though other sets are free | Higher associativity |
| **Capacity** | Active working set is too large to fit in the cache | Larger cache |

Conflict misses do not occur in fully associative caches.

## Related
- [[CSE351/Cache/Cache Associativity|Cache Associativity]]
- [[CSE351/Cache/Cache Locality|Locality]]
- [[CSE351/Cache/Handling Writes|Handling Writes]]
- [[CSE351/Cache/Program Optimizations via Cache|Program Optimizations via Cache]]
- [[CSE451/Memory Management/Concepts/Virtual and Physical Caches|Virtual and Physical Caches (451)]]
