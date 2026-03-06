how do we set the timeout for sending a retranmssion
1. with sliding window, detecting loss with timeout
	1. set timer when a segment is sent
	2. cancel timer when ack is recieved
	3. if timer fires, retransmit data as lost
## Timeout Problem
- Timeout should be "just right"
	- too long wastes network capacity
	- too short leads to spurious resend
- easy to send on a LAN
	- short, fixed, predictable RTT
- Hard on the Internet
	- wide range, variable RTT
	- vartiation could be due to:
		- queuing at router
		- changes in network path
		- if we set a fixed timeout that is better for the lows it could worsen the congesteion when there is a network issue
		- ![[Example of RTT for retransmissions.png]]
## Adaptive Timeout
[[CSE461/Transport/Transmission Control Protocol (TCP)|Transmission Control Protocol (TCP)]] uses this. Its not a perfect solution but works better than fixed (around 90-95% of the time)
- smoothes estimate of the RTT and variance in RTT
	- update estimates with a moving average
$$
\text{SRTT}_{N+1} = 0.9 * \text{SRTT}_N + 0.1 * \text{RTT}_{N+1}
$$
$$
\text{Svar}_{N+1} = 0.9 * \text{Svar}_N + 0.1 * abs(\text{RTT}_{N+1} - \text{SRTT}_{N+1})
$$
- set timeout to a multiple of estimates
	- to estimate the upper RTT in practice
	- TCP timeout_n = SRTT_N + 4 * Svar_N
 ![[Example of Adaptive Timeout.png]]