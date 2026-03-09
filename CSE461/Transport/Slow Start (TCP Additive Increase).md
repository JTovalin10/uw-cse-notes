## Practical AIMD
- we want TCP to follow an AIMD control law for a good allocation
- sender uses a congestion window or cwnd to set its rate
- sender uses loss as network congestion signal
- need TCP to work across a very large range of rates and RTTs
## TCP Startup Problem
- We want to quickly hear the right rate, cwnd, but it varies greatly
	- fixed sliding window doesnt adapt and is rough on the netwoek
	- additive increase with small bursts adapts cwnd gently to the network, but might take a long time to become efficient
## Slow Start Solution
- start by doubling cwnd every RTT
	- exponential growth (2^n)
	- start slow, quickly reach large values
- the issue with AI is that if the payload is small then just an AI approach is poor. As slow-start has exp increase itmakes up for that
- eventually packet loss will occur when the network is congested
	- loss timeout tells us cwnd is too large
	- next time, switch to AI beforehand
	- slowly adapt cwnd near the right value
- in terms of cwnd
	- expect loss for cwnd_c = 2BD + queue
	- use ssthresh = cwnd_c / 2 to switch to AI
- combine behavior after first time
	- most time spent near right value
![[Screenshot 2026-03-06 at 1.16.55 PM.png]]![[Screenshot 2026-03-06 at 1.19.56 PM.png]]