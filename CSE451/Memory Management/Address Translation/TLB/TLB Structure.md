# What exactly is TLB
TLB is a tiny, ultra-fast memory chip physically located inside the [[Memory Management Unit]]
- it stores pairs
	- Virtual Page Number | Physical Frame Number
- it is associative
	- the hardware searches the entire TLB in parallel (all at once) to find a match instantly
