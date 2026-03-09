- efficient means most capacity is used but there is no congestion
- fair means every sender gets a respomable share of the network
- key observations
	- in an effective solution, transport, and network layers must work together
- network layer witness congestion
	- only it can provide direct feedback
- transport layer caues congestion
	- only it can reduce offered load
- why is it hard
	- number of senders and their offered load change
	- senders may lack capacity in different parts of network
	- network is distributed; no single party has overall picture of its state
- solution context:
	- senders adapt concurrently based on their own view of the network
	- design this adaption so the network usage as a whole is efficient and fair
	- adaption is continuous since offered loads continue to change over time
## Models
- open loop vs closed loop
	- open: reserve bandwidth before use
	- closed: use feedback to adjust rates
- host vs network support
	- who is set/enforces allocation
- window vs rate based
	- how is allocation expressed
- TCP is a closed loop, host-driven, and window-based
- network layer returns feedback on current allocation to senders
	- for TCP its packet dropped
- transport layer adjusts sender's behavior via window in response
	- how senders adapt is a control law
## Additive Increase Multiplicative Decrease
- AIMD is a control law hosts can use to reach a good allocation
	- hosts additively increase rate while network is not congested
	- hosts multiplicatively decrease rate when congested
	- used by TCP
![[AIMD.png]]
- fair, y = x
- efficient, x + y = 1
- wherever we start we always converge to a good allocation
### AIMD Properties
- converges to an allocation that is efficient and fair when hosts run it
	- holds for more general toplogies
- other increase/decerease control laws do not
	- MIAD, MIMD, MIAD
- requires only binary feedback from the network
### AIMD Sawtooth
it produces a sawtooth pattern over time for rate of each host
![[Screenshot 2026-03-06 at 1.01.13 PM.png]]
## Feedback signals
![[Screenshot 2026-03-06 at 1.07.59 PM.png]]