# CSE451: Page FIFO

**Page FIFO** (**First-In-First-Out (FIFO)**): a page replacement algorithm that treats a page's age — how long ago it was brought into memory — as the sole criterion for eviction, without consulting any information about how recently or how often the page has actually been used.

## How It Works
1. When you page in something, put it on the tail of a list.
2. Evict the page at the head of the list (the oldest page in memory).

## Pros and Cons
1. **Pro**: something brought in long ago may genuinely not be used again, in which case evicting it is the right call and costs nothing to determine — the list order alone tells you what to evict.
2. **Con**: because FIFO tracks only age and ignores whether a page has actually been accessed recently, a page that was loaded long ago but is still being used heavily (e.g. a frequently reused library page) may still get evicted simply because it's old. FIFO has no way to distinguish "old and unused" from "old and still hot," so it may unnecessarily kick out a heavily-used page and cause an avoidable fault the next time that page is touched.

The performance of FIFO is typically poor precisely because of this blindness to usage, and it suffers from **[[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Anomaly|Belady's Anomaly]]** — adding more physical memory frames can, counterintuitively, increase FIFO's fault rate on certain reference strings.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page FIFO | First-In-First-Out (FIFO) page replacement |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — the algorithm survey FIFO belongs to, including local vs. global allocation
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Anomaly|Belady's Anomaly]] — the anomaly FIFO is known to exhibit
- [[Operating Systems/Virtualization/Memory/Page Replacement/LRU|LRU]] — an alternative that does track usage information, at higher implementation cost
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]] — the optimal policy FIFO is measured against
