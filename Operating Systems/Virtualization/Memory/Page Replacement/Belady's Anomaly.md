# CSE451: Belady's Anomaly

**Belady's Anomaly**: a counterintuitive behavior in which there exist reference strings for which the page fault rate *increases* when a process is given *more* physical memory. Intuitively, giving a process more page frames should only ever help — with more room to keep pages resident, faults should stay the same or go down. Belady's Anomaly shows this assumption is false for some replacement algorithms (most notably **[[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|FIFO]]**): there are specific sequences of page references where adding more physical memory frames actually causes the number of page faults to increase, rather than decrease.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Belady's Anomaly | Belady's anomaly (standard term) |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Page FIFO|Page FIFO]] — the algorithm that exhibits this anomaly
- [[Operating Systems/Virtualization/Memory/Page Replacement/Belady's Algorithm|Belady's Algorithm]] — the optimal algorithm named after the same author; OPT does not suffer from this anomaly (it belongs to the "stack algorithm" class, which FIFO does not)
- [[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — the broader algorithm survey this anomaly is a caveat within
