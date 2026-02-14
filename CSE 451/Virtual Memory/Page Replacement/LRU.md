this algorithm uses reference information to make a more informed replacement decision

Idea: past experience gives us a guess of future behavior

on replacement: evict the page that hasnt been used for the longest amount of time
- LRU looks at the past, [[Belady's Algorithm]] wants us to look at the future

Implementation:
- to be perfecct we must grab a timestamp on every memory reference, put it in the PTE, order or serach based on the timestams
- this costs too much memory bandwidth and algorithm execution time

## Approx
we can instead use an approximiation by using the PTE reference bit
- keep a counter for each page
- at some regular interval, for each page do:
	- if ref bit = 0, increment counter (unused)
	- if ref bit = 1, zero the counter (used)
- the counter will contain the number of intervals since the last reference to the page
	- page with the largest counter is the LRU