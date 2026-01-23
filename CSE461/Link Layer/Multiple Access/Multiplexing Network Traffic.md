- Network traffic is bursty
	- ON/OFF resources
	- Load varies greatly over time
	- inefficient to always allocate users their ON needs with
		- [[Time Division Multiplexing (TDM)]]
		- [[Frequency Vision Multiplexing (FDM)]]
	- ![[Screenshot 2026-01-22 at 3.28.42 PM.png]]
**Multiple Access**
- schemes multiplex users according to demands - for gains of statistical multiplexing
- ![[Screenshot 2026-01-22 at 3.29.20 PM.png]]

# How to Control
We have two classes of multiple access algorithms
1. centralized: use a privilege "scheduler" to pick who gets to transmit and when
	1. pros: scales well, usually efficient
	2. cons: requires management, fairness
	3. ex: cell networks
2. [[Distributed (random) Access]]: have all participants "figure it out" through some mechanism
	1. pros: operates well under low loads, easy to set up, equality
	2. neg: scaling is really hard
	3. ex: wifi networks
3. 