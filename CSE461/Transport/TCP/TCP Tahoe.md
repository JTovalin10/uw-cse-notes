# TCP Tahoe
- intial slow-start (doubling) phase
	- start with cwnd = 1 (or small value)
	- cwnd += 1 packet per ack
- later additive increase phase
	- cwnd += 1 / cwnd packets per ACK
	- roughly adds 1 packet per RTT
- switching threshold (initally infinity)
	- switch to AI when cwnd > ssthresh
	- set ssthresh = cwnd / 2 after loss
	- begin with slow-start after timeout
If we lose the ACK clock we have to restart and rebuilt it from. This occurs during a timeout