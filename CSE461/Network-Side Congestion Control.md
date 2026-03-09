## Congestion Avoidance vs Control
- classic TCP drives the network into congestion and recovers
- would be better to use the network to avoid congestion altogether
	- reduce loss and delay
	- 
## Feedback Signals
We hear the condition early so we can adjust accordingly, this router router support. ECN is not used in traditional network but is on cloud infrastructures
![[Feedback signals.png]]
## Explicit Congestion Notification (ECN)
router detects the onset of congestion via its queue
- when congested, it marks affected packets (IP header)
- with ECN they can just drop the packet to give feedback to the sender
- marked packets arrive at reciver are treated as loss
	- tcp reciever relaibly informs TCP sender of the congestion\
![[ECN.png]]
Advantages:
- router delivers clear signal to hosts
- congestion is detected early, no loss
- no extra packet needs to be sent
Disadvantage:
- routers and hosts must be upgraded
- more work at router
## Random Early Detection (RED
- instead of marking packet, dorop
	- we know theyre using TCP so we can use that
- signals congestion to sender
	- but without adding headers or doing packet inspection
- drop at random, depending on queue size
	- if queue is empty, accpet packet always
	- if queue is full, always drop
	- as queue is approaching full, increase likelihood of packet drop
- Sender enters MD, slows packet flow