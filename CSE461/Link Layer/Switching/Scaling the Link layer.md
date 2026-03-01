It's hard to scale distributed algorithms:
1. Exacerbated when failures become common
2. Nodes go down; have to run spanning trees again
	1. If nodes go down faster than the spanning tree converges, we have a race condition
	2. If they don't, we are losing paths and resources