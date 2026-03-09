scheduling ois a policy and the way we switch is a mechanism
## Classes of Schedulers
- Batch
	- throughput/utilization oriengted
	- example: audit inter-bank funds transfers each night, Hadoop/MapReduce jobs
- Interactive
	- response time oriented
	- ex: attu.cs
- Real time
	- deadline driven
	- example: embedded systems
- Parallel
	- speedup-driven
	- shared-space use of a 1000-processor machine for large simulations
## Levels of Scheduling Decisions
- long term
	- should a new job be initiated or should it be held
		- typical of batch systems
		- what might cause you to make a hold decision
	- these typically take a lot of memory or take a long time to complete
- medium term
	- should a running program be temprarily marked as non-runnable (swapped out)
	- we can swap it out and run it later
- short term
	- which thread should be given the CPU next and how long
	- which I/O operation should be sent to the disk next
	- on a multiprocessor
		- shold we attempt to coordinate the running of threads from the same address space in some way
		- should we worry about the cache state (processor affinity)
			- multiple CPU's can potentially touch the same cache line
## Goals
### Performance
- maximize CPU utilization
- max throughput
- minimize average response time (average time from submission of request to completion of response)
- minimize average waiting time (average time from submission of request to start of execution)
- minimize energy (joules per instruction) which can be subject to some constraint (fps or different)
### Fairness
- no single definition of fair
	- how to measure fair
		- equal CPU consumption?
	- fair per-user, per-processor, per-thread?
	- what if one process is CPU bound and one is I/O bound
- sometimes the goal is to be unfair
	- favor some particular class of requests (priority system), but
	- avoid starvation
## When to assign
- pre-emptive vs non-preemptive schedulers
	- non-preemptive
		- once you give somebody the green light, they've got it until they relinquish it
			- I/O operation
			- allocation of memory in a system without swapping
	- preemptive
		- you can re-visit a decision
			- setting the timer allows you to preempt the CPU from a thread even if it doesnt relinquish it voluntariy
			- if you dont mark a program as non-runnable, its memory resources will eventually be re-allocated to others
		- reasignment always involved some overhread
			- this doesnt contrbute to the goal fo the schediler
## Laws
- utilization law
	- Utilization = throughput * average service requirement
- little's law
	- the better average response time implies fewer in system and vice versa
	- averge number in system = throughput * average response time
- Kleinrock's Conversevation Law for priority scheduling
	- U_p us the utilization by priority level p and R_p is the time in the system of priortiy level p
		- this means you cant improve the resonse time of one class of tasks by increasing the priority without hurting the response time of at least one other class
$$
\sum_p U_p * R_p = \text{constant}
$$
## Algorithms
### FCFC/FIFO
- First come first served / first in first out
	- schedule as they come
	- queue
	- jobs are treated equally and no startvation
- in the real world, when does it work well
- what is its limitation
- when does it work badly
- Drawacks
	- average response time can be lousy
		- small requerst wait behind big ones
	- may lead to poor utilization of other resouces
		- if you send me on my way, i can keep another resource busy
		- FCFS ay result in poor overlap of CPU and I/O activity
			- CPU intenstive jobs precent an I/O int4esnive job from doing a small bit of computation, which prevents it from going back and keeping the I/O subsystem busy
		- the more copies of the resource there are to be schedued, the less dramatic of the impact of occasional vert large jobs (so long as there is a single waiting line)
### SPT/SJF
- shortest processing time first / shortest job first
	- choose the request with the smallest service requirement
	- provably optimal with respect to average response time
		- why do we care about probaly optimal
	- drawbacks
		- its non-preemtive
		- SRPT is preemtive which accomdates arrivals
	- what about starvation
	- can you know the processing time of a request
	- can you guess/approximation and how?
### Round Robin
- Use preemtiion to offset lack of information about executon times
	- run them all
- ready queue is treated as a circular FIFO queue
- each request is given a time slice, called quantim
	- request executes for duration of quantum, or until ot blcoks
		- what singiies the end of a quantim
	- time-divison multiplexing (time slicing)
- great for timesharing
	- no starvation
- how is it an improvement over FCFS, SPT, and how is it an approximation to SPT
- drawbacks
	- what if all jobs are the exact same length
		- what would be the schedule be
	- whwat do you set the quantim to be
		- there is no correct answer fot this
			- too small, then context siwtch often
			- if large, then response time degreades
## Priority
- assigns priortiy to requests
	- choose request with highest priorty to run next
		- if it,e use anotehr schedulign algorithm to break
	- goal: non-fiarness (favor one group over another)
- abstractly modeled (and sually implemented) as multiple priority queues
	- put a ready request on the queue associated with its priorty
- drawbacks
	- how do you assign priorities
	- starvation
		- if there is an endless supply of high priority jobs, no-low priority jobs will ever be run
	- inversion (really bad starvation)
		- assume three threads: H, M, L
		- low runs and acquires a resource
		- high rpeemtns low and blocks on that resource
		- medium becomes runnable and is CPU-bound
		- low cant finish, and high is out of lock
### History Does Matter
- its been observred that worksloads tend to have increasing residual life
	- if you did it before youre likely to do it again
- this is exploited in practivce by using a olicy that diuscrimates against the old
### Multi-level Feedback Queues
- MLFQ:
	- there is a hierarchy of queus based on priority
	- new requests enter the highest priority queue
	- each queue is scheduled Round Robin
	- requests move between queues based on execution history
	- lower priority queues may have longer quanta
- Age threads over time (feedback)
	- increase priority of function of accumalted wit time
	- decrease priroty of accumulated processing time
![[MLFQ.png]]
- compute bound threads
	- dont move much
- I/O intense threads
	- give a big priority boost immeditaly
## UNIX Scheduling
- canconical scheduler is pretty much MLFQ
- - 3-4 classes spanning ~170 priority levels
	- timesharing: lowest 60 priorities
	- system: middle 40 pri
	- real-time: highest 60 pri
- priority scheudling across queues, RR within
	- process within highest priorty alwasy runs first
	- processes with same prioty scheduled RR
- processes dynamically change priotity
	- increase voer time if process blocks before end of quantim
	- decreases if process use entire quantum