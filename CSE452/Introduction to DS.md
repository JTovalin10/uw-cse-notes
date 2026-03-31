## What is a Distributed System
1. Multiple machines
	1. concurrency
2. connected by a network
3. **fault tolerant**
### Why Build One
- harness the power of multiple machines
- horizontal scaling
	- adding more computers
- vertical scaling
	- making the computer better
- Redundancy/replication (Fault tolerance)
	- multiple machines keep the same copy of data
- **Performance**
	- Placing data near users
	- [[Caching]]
## How hard is it to build a DS
- hard to maintain "coherence"
	- replication makes updates hard
- Multiple machines working together
	- one could fail
	- **partial failures**
		- you must accept failure is normal
- **Concurrency**
## Fault Model
What failures do we consider to be normal
- a list of failures we plan to tolerate
	- tolerate automatically
- what failures are possible
	- machines
		- power goes out - crash (ungracfully)
	- [[CSE461]]
		- reordering
		- duplicate
		- dropped pakets
		- packet corrupted (bit flip)
		- message injection
		- timeout
		- delay
			- congestion