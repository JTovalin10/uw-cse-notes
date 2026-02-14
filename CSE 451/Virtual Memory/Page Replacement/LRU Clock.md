This is also known as Not Recently Used (NRU) or Second Change
## Algorithm
1. replace page that is old enough
2. logically, arrange all physically page frames in a big circle (clock)
	1. circular linked list
3. a "clock hand" is used to select a good LRU candidate
	1. sweeep through the pages in circular order
	2. If ref bit is off, it hasnt been recertnly used
	3. if ref bit is on, turn it off and go to the next page
## Important things to note
1. arm moves quicly; wen pages are needed
2. low overhead if have plently of memory
3. if memoryu if large, "accuracy" degares
	1. add more hands to fix