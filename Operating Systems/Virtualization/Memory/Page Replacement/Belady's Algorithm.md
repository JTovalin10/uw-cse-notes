# CSE451: Belady's Algorithm

**Belady's Algorithm** (also called **OPT**, the optimal page replacement algorithm) has the provably lowest fault rate of any replacement policy. All it does is:
1. Evict the page that won't be used for the longest time in the future.
2. Problem: it is impossible to predict the future, so this algorithm cannot actually be implemented in a real system.

This algorithm is only useful as a measuring tool, to compare other algorithms against and check whether a given policy isn't that much worse than the theoretical best case.

## Formal Definition
For a reference string $r_1, r_2, \dots, r_n$ and a set of resident pages $F$ at time $t$, **Belady's Algorithm (OPT)** evicts the page $p \in F$ that maximizes the distance to its next reference:
$$
\text{victim} = \arg\max_{p \in F} \; \min \{ k > t : r_k = p \}
$$
If a page in $F$ is never referenced again for the remainder of the reference string, it is chosen immediately (its "next reference time" is treated as infinite). Belady proved that this policy minimizes the total number of page faults over the reference string, for any fixed amount of physical memory — no other replacement policy can produce fewer faults on the same reference string.

## Simplified Explanation
Kick out whichever page you won't need again for the longest stretch of time. If you could see into the future, this is always the smartest choice, because you're getting rid of the thing that's least useful to keep around right now. The catch is you can't actually see the future — so real systems use algorithms like **[[Operating Systems/Virtualization/Memory/Page Replacement/LRU|LRU]]** that guess based on the past instead, and Belady's Algorithm is only used afterward, offline, to measure how close those guesses came to the best possible outcome.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Belady's Algorithm | OPT (Optimal Page Replacement) |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — the algorithm catalog this fits into, and the goal it exists to satisfy
- [[Operating Systems/Virtualization/Memory/Page Replacement/LRU|LRU]] — the practical, past-looking approximation of this future-looking ideal
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|Page FIFO]] — a much simpler and less accurate policy, often compared against OPT
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Anomaly|Belady's Anomaly]] — a counterintuitive fault-rate behavior named after the same author, but affecting FIFO rather than OPT
