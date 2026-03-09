four conditions must exit for a deadlock to be possible
1. mutual exclusion
2. hold and wait
3. no preemption
4. circular wait
## Resource Graphs
- resource graphs are a way to visualize the state of threads and a way to reason about deadlocks
![[Resource Graphs.png]]
## Deadlock
![[Deadlock.png]]

### Handling Deadlock
Elimate one of the four required conditions
- mutual exclusion
- hold and wait
- no preemption
- circular wait
Boradly classified as
- prevtion, avoidance, or detection (and recovery)
### Resource Allocation
![[Resource Allocation Deadlock.png]]
## Graph reduction
- a graph can be reduced by a thread if all of that thread's requests can be granted
	- the thread eventually will terminate and all resources will be freed
	- misc theorms (Holt, Havender)
		- there are no deadlock thread iff the hgraph is complety reducbke
		- the order of reductions is irrelabent
