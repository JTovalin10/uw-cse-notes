# CSE451: Page Replacement

**Page Replacement**: the general mechanism the OS uses to free up a physical frame so that a needed page can be brought into memory, most often triggered by handling a **[[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]]**.

## Freeing a Page
1. If there are free page frames, grab one from the free list.
	- What data structure supports this? A simple free list of available frames, so that allocating a frame is just a removal from the head of the list.
2. If there are no free frames, the OS must evict something else to make room. Choosing the *best* page to evict is the goal of a **[[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Page Replacement Policy]]** — see that file for the algorithm survey (Belady's, FIFO, LRU, LRU Clock, PFF) and the local vs. global frame allocation trade-off.

## OS-Level Strategy
Beyond just picking a victim page algorithmically, the OS applies a couple of practical strategies to keep eviction cheap:
1. Try to pick a page that won't be needed again in the future (this is the underlying goal of every replacement algorithm — see **[[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]]**).
2. Try to pick a page that hasn't been modified, since evicting a clean page saves the disk write that a dirty page would require.
3. The OS typically tries to keep a pool of free page frames around at all times, so that a new allocation doesn't inevitably cause an eviction on the spot.
4. The OS also typically tries to keep some pages "clean" ahead of time, so that even if it does have to evict a page, it won't have to write it to disk first.
	- This is accomplished by pre-writing dirty pages to disk when the disk is otherwise idle — the page stays in memory (still fast to access) but is now clean, so if it's later chosen as a victim, no write-back is needed at eviction time.

## Industry Standard Terms
| Course Term | Industry / General Term |
|---|---|
| Page Replacement | Page replacement / eviction policy |
| Free page frames | Free frame list / free page pool |

## Related
- [[Operating Systems/Virtualization/Memory/Page Replacement/Evicting the best page|Evicting the best page]] — the algorithm catalog and frame allocation policy (local vs. global)
- [[Operating Systems/Virtualization/Memory/Page Fault|Page Fault]] — the event that triggers page replacement
- [[Operating Systems/Virtualization/Memory/Memory Models/Page Table Entries|Page Table Entries]] — the dirty and reference bits used to decide which pages are cheap to evict
- [[Operating Systems/Virtualization/Memory/Page Fault Frequency|Page Fault Frequency]] — a variable-space policy for deciding how many frames a process should get
- [[Operating Systems/Virtualization/Memory/Thrashing|Thrashing]] — the failure mode when replacement can't keep the working set in memory
