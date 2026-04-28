This is also known as Not Recently Used (NRU) or Second Change
## Algorithm
1. replace page that is old enough
2. logically, arrange all physically page frames in a big circle (clock)
	1. circular linked list
3. a "clock hand" is used to select a good LRU candidate
	1. sweep through the pages in circular order
	2. If ref bit is off, it hasn't been recently used
	3. if ref bit is on, turn it off and go to the next page
## Important things to note
1. arm moves quickly; when pages are needed
2. low overhead if you have plenty of memory
3. if memory is large, "accuracy" degrades
	1. add more hands to fix