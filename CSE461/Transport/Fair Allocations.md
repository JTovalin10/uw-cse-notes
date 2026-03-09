in practie, efficiency is more important than fairness
- we cant always have both fairness and efficiency
## The Slippery Notion of Fairness
- why is "equal per flow" fair anyways
	- A -> C uses more network resources than A->B or B->C
	- host A sends two flows, B sends one
- not productive to seek exact fairness
	- more important to avoid starrvation
		- a node that cannot use any bandwidth
	- equal per flow is good enough
## Equal Per Flow
- bottleneck: for a flow of traffic is the link that limits its bandwidth
	- where congestion occcurs for the flow
	- for A->C, link A-B is the bottlenexk
- flows may have differnet bottlenecks
### Max-Min Fairness
- Intuitively, flows bottlenecked on a link get an equal share of that link
- max-min fair allocation is one that
	- increasing the rate of one flow will decrease the rate of a smaller flow
	- the "maximizes the minimum" flow
- to find it given a network, imagine "poruing water into the network"
	- start with all flows at rate 0
	- increase the flows until there is a new bottleneck in the network
		- increase it by fractionsof the bandwidth
	- hold the fixed rate of the flows that are bottlenecked
	- go to step 2 for any remaining flows
	![[Bottleneck.png]]	
### Adaption over time
Allocation changes as flows start and stop