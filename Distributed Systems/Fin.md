## Why build a Distributed System
- reliability
	- make unreliable components, reliable
	- replication: primary-backup, paxos
- performance/throughput
	- partitioning

## Challenges
- correctness
	- edge cases kill you
	- think of events, what order message come in and when
		- make no assumptions of order they come in
	- look for strategies for testing that simulates network in order we can control to explore difference flow of execution
- partial failure
- concurrency