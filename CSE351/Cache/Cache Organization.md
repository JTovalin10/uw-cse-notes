# CSE351: Cache Organization

## Cache Parameters

A cache is characterized by four parameters:

| Parameter | Meaning |
|:---|:---|
| $n$ | Total number of address bits |
| $K$ | Block size in bytes |
| $C$ | Total cache capacity in bytes |
| $E$ | **Associativity** — number of lines (ways) per set |
| $S$ | Number of sets: $S = C / (K \cdot E)$ |

## Address Splitting (Bit Math)

A memory address is split into three components to navigate the cache:

1. **Block Offset ($b$ bits)**: $\log_2(K)$ — selects the specific byte within a cache block.
2. **Set Index ($s$ bits)**: $\log_2(S)$ — selects which set the block belongs to.
3. **Tag ($t$ bits)**: $n - s - b$ — uniquely identifies the block within the set.

- **Direct-mapped** ($E = 1$): $s = \log_2(C/K)$ index bits.
- **Fully associative** ($S = 1$): $s = 0$ (no set indexing — tag compared against every line).

## Memory Hierarchy Latencies

Typical access times in processor cycles:

| Level | Access Latency |
|:---|:---|
| **L1 Cache** | ~4 cycles |
| **L2 Cache** | ~10 cycles |
| **L3 Cache** | ~40-50 cycles |
| **Main Memory** | ~100-200 cycles |

## Cache Line Anatomy

A single cache line (the unit of storage in a cache) consists of:

1. **Valid Bit**: 1 if the line contains valid data, 0 otherwise.
2. **Tag**: Bits from the memory address that uniquely identify the block currently stored in that line.
3. **Data Block**: The actual cached bytes (size $K$).

On a cache miss, if the target set has an empty line the block is placed there.
 When all lines in a set are occupied, a **replacement policy** selects the victim:

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
