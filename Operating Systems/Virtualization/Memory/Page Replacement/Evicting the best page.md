Goal:
1. reduce fault rate by selecting the best victim page to remove
2. the best page to evict is one that will never be touched again
3. never is a long time
	1. belady proof: evicting the page that won't be used for the longest period of time minimizes page fault rate

## Algorithms
1. [[Belady's Algorithm]]
2. [[Page FIFO]]
3. [[LRU]]
4. [[LRU Clock]]
5. [[Page Fault Frequency]]
## Allocation of frames among processes
[[Page FIFO]] and [[LRU Clock]] each can be implemented as local or global replacement algorithms
1. local:
	1. each process is given a limit of pages it can use
	2. it page against itself (evicts its own pages)
2. global
	1. the victim is chosen from among all page frames regardless of owner
	2. processes page frame allocation can vary dynamically
We can also use hybrid algorithms that are both local and global with an explicit mechanism for adding or removing page frames from a process including changing the number of frames a process uses
![[Pasted image 20260213202029.png]]