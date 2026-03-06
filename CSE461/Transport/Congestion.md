# Congestion
A "traffic jam" in the network
## Nature of Congestion
- routers/switches have internal buffering
	- Typically FIFO which discards a incoming packet if full.
- Queues help by absorbing bursts when input > output rate
- but if input > output rate persistently, queue will overflow
	- this is congestion
- congestion is a function of the traffic patterns - can occur even if every link has the same capacity
- if we make the queue infintite cna mke the latency worse due to the nature of Queue
![[Router and Switches internal buffering.png]]![[Router Queue.png]]
### Effect of Congestion
- as offered load rises, congestion occurs as queues begin to fill:
	- delay and loss rise sharply with more load
	- throughput falls below load (due to loss)
	- goodput mau fall below throughput (due to spurious retransmission)
	- goodput = pacjets reaching the reciever
	- the porbablity of a packet reaching the packet is P^N where N is the number of routers
- none are good
- ideally we want it to be linear and once it reaches capacity it stays constant (fine if we are close)
	- with congestion collapse there is a exponential drop in Goodput in relation to Offered Load
	- furthermore, with onset of congestion the delay exponentially increaes
	- as shown below
![[Congestion Performance.png]]
## TCP Tahoe/Reno
### Bandwidth Allocation
- important task for network is to allocate its capacity to senders
	- good allocation is both efficient and fiar
- efficient means most capacity is used but there is no congestion
- fair means every sender gets a reasonable sahre of the network
- Key Observation
	- in an effective solution, transport and network layer must work together
- network layer witnesses congestion
	- only it can provide direct feedback
- transport layer causes congestion
	- only it can reduce offered load
- why is it hard? just split equally
	- number of sender and their offered laod changes
		- not all senders have the same capacity so it doesnt make sense to try to equalize it
	- sender may lack capacity in different parts of network
	- network is distrbited; no single party has an overall picture of its state
### AIMD
### Fair Queuing
### Slow-start
### Fast Retransmission
### Fast Recovery