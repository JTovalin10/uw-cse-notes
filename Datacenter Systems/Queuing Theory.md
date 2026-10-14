- can we predict what will happen to user performance
	- can be used for resources due to limits
	- if a service becomes more popular
	- provision more or less hardware
		- instead of guessing
	- if we change the impl. to provide more features
	- use priorities or otherwise change the scheduling policy
## Queuing Model
- simple model
![[simple queuing model.png]]
- predict: long-term performance in a *stable system*, where arrival rate($\lambda$)$\leq$ service rate ($\mu$) 
	- service rate is measured in server itself or bandwidth terms
	- doesnt answer what happens to system if the load starts to overload the system (undefined state of system) or long-term relations for unstable scenarios
		- stable is hwen laod is lower than what the system is able to process
- throughput: measurement of what came out (output) of the queue
	- doesnt measure input, the laod can be much higher than bandwidth
- bandwidth: the provisioned max-throughput a service or link (service in queuing) can give us
### Definition
- queueing delay(W): wait time, number of tasks queued (Q)
	- amount of time a new arrival spends in the queue before its serviced
- service time (S): time to service the request
	- time it takes for a request from arrival to depature
- response time (R) = W + S
	- tells us what is going on inside of system
- Utilization (U) = fractionn of time the server is busy
	- Service Time * arrival rate ($\lambda$)
- throughput (X): rate of task completions
	- if no overload, throughput = arrival rate
		- we want them to be generally close to each other
### Little's Law
- useful for the averge
$$
N = X_{\text{average throughput}} \times R_{\text{avererage repsonse time}}
$$can tell us the average time a task is inside the system
N: avergae number of tasks in the system
applies to any stable system
arrival distrivution shouldnt matter
- you can resolve for any letter if you have the other numbers to now about averages
	- you can focus on server, queue, and such if you want to figure out avergae, throughput, utilization, or num queue tasks
- can help us answer questions in regards to adding hardware
- avergaes can be a bit deciving as they abstract what goes inside of system
### Queueing 
- what arrival pattern is the best case for minimizing queuing delay
	- fixed equally spaced arrivals
	- keeps arrival rate and service time constant
	- the server will always be utilizing with no waiting
	- response time stays teh same and throughput increases
	- only in theory
	- ![[Fixed Arrivals.png]]
- what arrival pattern is the worst
	- all requests arrive at the same time
	- all tasks will be forced to wait (burst arrival)
	- throughput and load is the same but latency gets increased
	- also in theory (can happen ocassioanlly)
![[Response time best vs worst case.png]]

- average case: what arrival process creates the average
	- Gaussian/normal: arrival are spread around a mean value
		- system is trying to send request relatively spaced requests. Best-effort as unforeseen events
	- Poisson/Exponential: arrivals are memoryless/uncoordinated
		- low queuing until a point until it grows exponential (infinite queuing)
		- use 20% headroom as queue length starts to grow exponentially
		- models with Markov chain
			- automaton
		- lambda is expected arrival rate and there is a probability of task leaving (mu). As its probabilistic it flutactes. if lambda is lower than mu, then closer to 0, but if lambda is higher than mu then you go to infinity
		- permits closed form solution to state probabilities, as function of arrival rate and service rate
		- ![[Exponential Distribution.png]]
	- heavy tailed: arrivals are bursty
		- everyone arrives at once (close to worst-case)
	- can have randomness in both arrivals and service time
## Queueing Inutiton
- if tasks arrive at random intervals, at an average rate less than serveice rate
	- sometimes kjobs arrive faster than teh server can handle, and queues build up
	- more often jobs arrive slower than service rate, and queues drain
	- sometimes erver is idle, and nothing arrives (1-U)