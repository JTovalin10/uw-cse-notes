Cache gives us a guarantee that is is equivalent to not having a cache
- not knowing about the cache doesn't matter, the program could run slower
## Single-Core (Single Node)
CPU1 -> L1 -> L2 -> L3 (shared) -> RAM (shared) -> disk (shared)
- on single core for cache coherence we can do 
	- write through
	- write back
	- link these from CSE351
## Multi-Core (Single Node)
CPU1 -> L1 -> L2 -> L3 (shared) -> RAM (shared) -> disk (shared)
CPU2 -> L1 -> L2 -> L3 (shared) -> RAM (shared) -> disk (shared)
### Cache Coherence
- keep multiple copies in different caches in sync
- protocol
	- create a memory bus between caches to allow them to talk to each otehr in order to keep it in cache
	- if you will write ot read from x tell the other person not to touch x to keep them in sync
## Distributed Cache
- we want to keep caches near user's for fast access and to not keep refetching data
- Ideas
	- write-through caching
		- forwards to server, server executes, server responds to the cache, cache tells other caches, respond to server
		- handle drops to ensure linearizable
		- what if cache failed (or might've)
		- must coordinate all caches
	- writes go to server
		- server must communicate with caches about any updates to invalidate any cached element
	- splitting the cache (parition/sharding)
		- partitioning data so clients talk to specific caches
			- issue is that client needs to know who to talk to
		- the cache can just write to that cache
		- loses benefit of distance
## Linearizable Caching
 - requires coordinating all nodes that may have a cached copy
 - - the more reads we do the faster it is to linearize and the faster the system is
## Performance Impacts of Caching
- to have a linearizable Distrbuted cache it has terrible performance if we a lot of writes
- trade staleness for better latency
	- be willing to stale data
	- lease
		- the amount of time the cache owns the data, timed ownership
		- it takes ownership of the key by asking the server that it wants to own it
			- the server tells it it owns it for x time (seconds usually)
				- fault tolerance
			- once we are the owner of the key we can execute freely