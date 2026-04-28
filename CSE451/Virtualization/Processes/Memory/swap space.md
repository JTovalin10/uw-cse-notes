# what is it
A reserved area on a disk for moving pages of memory back and forth. This allows the OS to support the illusion of a large virtual memory for multiple concurrently-running processes, even when the total memory demand exceeds the physical capacity of RAM
# How it works
when the RAM is full, it must make room for new data. It does this through swapping or paging out
1. selection: the OS picks a victim page in RAM in LRU fashion
2. eviction: the OS copies that page's data to the swap space on the disk
3. updating: the OS updates the page table for that process, marking the page as "not present" but recording its location on disk
4. retrieval: if the program later tries to access that data, a [[Page Fault]] [[Exception]] occurs. The OS then "swaps in" the page from the disk back into ram