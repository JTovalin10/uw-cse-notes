## Performance
- avoid Paxos
- lease shards to give clusters full control (avoid shardmaster as much as possible)
	- leases are 60 seconds and can be extended if its still in use
- find what are we handling?
	- small vs large pages
		- GFS optimizes for large files and eats the cost of small one
- pass linearizability to the application (choose one thing to make linearizable)
	- could be lazy, cheating, or smart
- ask, how can we utilize the full performance of the hardware
	- HDD - use sequential reads and writes
- identify bottlenecks and try to minimize passign through that
		- HOWEVER TRY TO FIX IT, IF NOT IT WILL HAVE TO BE DONE DOWN THE ROAD
## Durability
- for datacenters we must spread the replicas across dataracks in case that one rack dies