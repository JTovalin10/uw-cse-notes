Page coloring is an OS-level technique for controlling which physical page frames are allocated to a process in order to avoid cache thrashing.

## The Problem

[[Virtual and Physical Caches|Physical caches]] ([[Virtual and Physical Caches|PIPT]] or [[Virtual and Physical Caches|VIPT]]) use some bits of the physical address as the cache index. Two physical addresses that share the same index bits will map to the same cache set and evict each other — even if the cache has plenty of free space in other sets.

This is a **conflict miss** caused by the OS's choice of physical frame, not by program behavior.

## How Physical Address Maps to Cache

For a cache with `S` sets and `B`-byte cache lines, the physical address is broken down as:

```
[ tag | set index | block offset ]
         ↑
   these bits determine which set
```

The set index bits are determined by the physical page number (the upper bits of the physical address, beyond the page offset). Specifically, if the page size is 4 KB (12-bit offset) and the cache has 64 sets (6-bit index), then bits [17:12] of the physical address determine the set.

## Page Colors

A **page color** is the value of those "extra" bits in the physical frame number — the bits above the page offset that overlap with the cache index. Two pages with the same color map to the same cache sets and compete with each other.

The number of distinct colors is:

```
num_colors = (cache_size / associativity) / page_size
```

## What the OS Can Do

The OS controls which physical frame backs a virtual page. By being aware of page colors, it can:

- **Avoid same-color allocations** for data the program accesses together (e.g., two large arrays) — prevents systematic conflict eviction.
- **Assign same-color frames** to shared memory between processes so they map to the same cache sets and actually share cache lines (useful for shared libraries).
- **Partition cache sets** between processes to provide cache isolation (relevant for security — mitigating cache side-channel attacks).

## In Practice

Most general-purpose OSes (Linux, Windows) do not implement page coloring by default — it adds complexity to the page allocator and the benefit diminishes with higher associativity. However, real-time and high-performance OSes sometimes use it, and it's relevant for understanding cache-aware memory allocation and side-channel vulnerabilities.

## Relationship to [[Virtual and Physical Caches|VIPT]] Caches

In a [[Virtual and Physical Caches|VIPT]] cache where the index bits extend beyond the page offset (i.e., `cache_size / associativity > page_size`), the OS *must* be color-aware to avoid synonyms — two virtual addresses mapping to the same physical frame but landing in different cache sets. Page coloring (ensuring synonyms get the same color) is one way to handle this.
