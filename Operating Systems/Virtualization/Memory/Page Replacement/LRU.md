# CSE451: LRU (Least Recently Used)

**Least Recently Used (LRU)**: a page replacement algorithm that uses reference information to make a more informed replacement decision than **[[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|FIFO]]**.

Idea: past experience gives us a guess of future behavior.

On replacement: evict the page that hasn't been used for the longest amount of time.
- LRU looks at the past, while **[[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]]** wants us to look at the future — LRU is exactly the practical, backward-looking approximation of Belady's forward-looking ideal.

## Implementation
To be perfect, we must grab a timestamp on every memory reference, put it in the **[[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|PTE]]**, and order or search pages based on those timestamps. This costs too much memory bandwidth and algorithm execution time in practice, so an approximation is used instead.

### Approximation
We can instead approximate LRU using the PTE **reference bit** (ref bit):
- Keep a counter for each page.
- At some regular interval, for each page:
	- if reference bit = 0, increment the counter (page was unused this interval)
	- if reference bit = 1, zero the counter (page was used this interval)
- The counter will contain the number of intervals since the last reference to the page.
	- The page with the largest counter is the LRU candidate.

It is important to note that not all architectures provide a hardware reference bit in the PTE — on those architectures we can simulate one using the valid bit to deliberately induce faults, letting the fault handler record that the page was touched.

## Formal Definition
Given a reference string $r_1, \dots, r_t$ and resident set $F$, exact **LRU** evicts the page $p \in F$ that maximizes the backward distance to its most recent reference:
$$
\text{victim} = \arg\max_{p \in F} \; \big(t - \max\{k \le t : r_k = p\}\big)
$$
This requires an exact, continuously updated ordering of all resident pages by last-access time (e.g. via a timestamp per reference). The **reference-bit-counter approximation** described above instead discretizes time into fixed intervals and replaces the exact last-access timestamp with a counter of how many intervals have elapsed since the reference bit was last observed set; the page with the maximum counter value is treated as the LRU victim. This trades exactness for tractability — it can order pages coarsely (by interval) but not with fine-grained precision within an interval.

## Simplified Explanation
Throw out whatever hasn't been touched in the longest time, on the theory that if you haven't needed something recently, you probably won't need it again soon. Since checking every single memory access for an exact "last used" timestamp is too expensive, the OS instead periodically checks a cheap yes/no reference bit per page and keeps a rough "how long has it been since I last saw this bit set" counter, using that as a stand-in for true recency.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| LRU | Least Recently Used (LRU) |
| Ref bit | Reference bit / accessed bit |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — the algorithm survey LRU belongs to
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]] — the unimplementable optimal policy LRU approximates
- [[Operating Systems/Virtualization/Memory/Page Replacement/LRU Clock|LRU Clock]] — a specific, cheaper hardware-friendly approximation of LRU using a sweeping clock hand
- [[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entries]] — where the reference bit used by this approximation lives
- [[Operating Systems/Virtualization/Memory/Address Translation/Page Table/Page Table Entry Anatomy|Page Table Entry Anatomy]] — deeper detail on the reference/accessed bit and dirty bit
