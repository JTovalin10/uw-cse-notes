fits hard to scale distributed algorithms
1. exponentaed when failures become common
2. nodes go down, gotta run spanning trees again
	1. if nodes go down faster than spanning tree we have a race condition
	2. if they dont we are losing paths and resources