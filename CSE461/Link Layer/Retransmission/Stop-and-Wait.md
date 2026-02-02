# Normal Case
![[Screenshot 2026-01-22 at 3.05.17 PM.png]]
# Ack loss
![[Screenshot 2026-01-22 at 3.05.28 PM.png]]
# early timeout
![[Screenshot 2026-01-22 at 3.05.48 PM.png]]

# Limitations
it allows only a single frame to be outstanding from the sender. The issue is that if we icnrease the Mbps it doesnt increase the throughput as much
	good for LAN, not **efficient** for high BD
![[Screenshot 2026-01-22 at 3.07.59 PM.png]]

Formula:
$$
\text{Frame/sec} = \frac{1}{T_{frame} + RTT}
$$
where T_Frame is the transmission size
frame is a packet wrapped with header/trailer info (MAC, error checking, etc)