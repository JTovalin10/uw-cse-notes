# Normal Case
![[Screenshot 2026-01-22 at 3.05.17 PM.png]]
# Ack loss
![[Screenshot 2026-01-22 at 3.05.28 PM.png]]
# early timeout
![[Screenshot 2026-01-22 at 3.05.48 PM.png]]

# Limitations
it allows only a single frame to be outstanding from the sender. The issue is that if we icnrease the Mbps it doesnt increase the throughput as much
	good for [[Local Area Network (LAN)|LAN]], not **efficient** for high BD
![[Screenshot 2026-01-22 at 3.07.59 PM.png]]

Formula:
$$
\text{Frame/sec} = \frac{1}{T_{frame} + \text{RTT}}
$$
where T_Frame is the transmission size
frame is a packet wrapped with header/trailer info ([[Media Access Control (MAC)|MAC]], error checking, etc)

## Textbook Notes

The simplest ARQ scheme: send one frame, wait for an ACK before sending the next. If the ACK doesn't arrive in time, retransmit.

![[Pasted image 20260207012641.png]]

### Duplicate Detection
If the receiver's ACK is dropped but the frame was received, the sender will resend the same frame. To handle this, the header includes a **1-bit sequence number** that alternates with each frame, letting the receiver detect duplicates.

### Limitation
Only one outstanding frame at a time. Maximum sending rate:
```
Bits-per-Frame / Time-per-Frame
```
This wastes bandwidth when the link has high delay — the pipe is mostly empty. The solution is [[Sliding Window]].