The goal is to reduce the fault rate by selecting the best victim page to remove
## Freeing a page
**page replacement**
1. if there are free page frames, grab one
	1. what data structure supports this
2. if not must evict something else
## Algorithm
1. try to pick a page that wont be needed in the future
2. try to pick a page that hasn't been modified (this saves the disk write)
3. OS typically tries to keep a pool of free pages around so that allocation doesnt inevitably cause evictions
4. OS also typically tries to keep some "clean" pages around, so that even if you have to evict a page, you wont have to write to it
	1. accomplished by pre-writing when there's nothing better to do