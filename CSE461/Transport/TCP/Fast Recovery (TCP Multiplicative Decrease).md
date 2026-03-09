inferring loss from ACK's
- TCP uses a cumulative ACK
	- carries highest in-order seq. number
	- normally a steady advance
- duplicate ACKs give us hints about what data hasn't arrived
	- tell us some new data did arrive, but it was not next segment
	- thus the next segment may be lost
	- we can infer a loss occurs
## Fast Retransmit
- treats three duplicate ACKs as a loss, note it only repairs one segment loss
	- retransmit next expected segment
	- some repition allows for reordering, but still detects loss quickly
		- could also be that its not loss but just slow. this is fine as there is no harm in retransmission if we think it is lost
	- it can repair single segment loss quickly, typiucally before a timeout
	- however, we have quiet time at the sender/reciever while waiting for the ACK to jump
	- and we still need to MD cwnd
![[Fast Retransmit.png]]
## Inferring Non-Loss from ACKs
- duplicate ACKs also give us hints about what data has arrived
	- each new duplicate ACK means that some new segment has arrived
	- it will be the segments after the loss
	- thus advancing the sliding window will not increase the number of segments stored in the network
## Fast Recovery
- first fast retransmit, and MD cwnd
- then pretend further duplicate ACKs are the expected ACKs
	- lets new segments be sent for ACKs
	- reconcile views when the ACK jumps
- we assume that the duplicate ACKs are in the right order and, for example 10,11,12,13,13,13,13, we assume that the duplicate 13's are 10,11,12,13,14,15,16,17, etc after the fix
- it repairs a single segment loss quickly and keeps the ACK clock running
- this allows us to realize AIMD
	- no timeouts or slow-start after loss, just continue with a smaller cwnd
- TCP Reno combines slow-start, fast retransmit, and fast recovery
	- multiplicative decrease is 1/2
	- this is scalable as millions use this and they all respond to each other and adapt