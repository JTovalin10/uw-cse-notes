# CSE451: Page Coloring

**Page Coloring** is an OS-level technique for controlling which physical page frames are allocated to a process in order to avoid cache thrashing.

## The Problem

**[[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|Physical caches]]** ([[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|PIPT]] or [[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|VIPT]]) use some bits of the physical address as the cache index. Two physical addresses that share the same index bits will map to the same cache set and evict each other — even if the cache has plenty of free space in other sets.

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

## Relationship to [[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|VIPT]] Caches

In a [[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|VIPT]] cache where the index bits extend beyond the page offset (i.e., `cache_size / associativity > page_size`), the OS *must* be color-aware to avoid synonyms — two virtual addresses mapping to the same physical frame but landing in different cache sets. Page coloring (ensuring synonyms get the same color) is one way to handle this.

## Formal Definition

For a cache with total capacity $C$, associativity $A$, and page size $P$, the number of distinct page colors is:

$$\text{num\_colors} = \frac{C / A}{P}$$

Two physical frames $f_1$ and $f_2$ have the same color if and only if:

$$\left\lfloor \frac{f_1 \times P}{P} \right\rfloor \bmod \text{num\_colors} = \left\lfloor \frac{f_2 \times P}{P} \right\rfloor \bmod \text{num\_colors}$$

which reduces to comparing the bits of the frame number that overlap with the cache's set-index field.

## Simplified Explanation

Imagine the cache as a parking garage with a fixed number of numbered spots per floor, and each floor only has room for so many cars before new arrivals kick out old ones. A page's "color" is just which floor it's assigned to. If the OS carelessly assigns two frequently-used pages to the same floor, they'll keep kicking each other out of the same parking spots even though other floors sit empty. Page coloring is the OS being deliberate about which floor (color) each page goes to, so heavily-used pages spread across floors instead of colliding.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page Coloring | Cache coloring / cache-aware page allocation |
| Page Color | Cache color / bin index |
| Conflict Miss | Cache conflict miss (standard cache terminology) |

## Related
- [[Operating Systems/Virtualization/Memory/Concepts/Virtual and Physical Caches|Virtual and Physical Caches]]
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table|Page Table]]
- [[Hardware & Software Interface/Cache/Cache Organization|CSE351: Cache Organization]]
- [[Hardware & Software Interface/Cache/Side Channel Attacks|CSE351: Side Channel Attacks]]
