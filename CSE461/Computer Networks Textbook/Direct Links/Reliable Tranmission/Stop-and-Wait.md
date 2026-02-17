The simplest ARQ scheme: send one frame, wait for an ACK before sending the next. If the ACK doesn't arrive in time, retransmit.

![[Pasted image 20260207012641.png]]

## Duplicate Detection
If the receiver's ACK is dropped but the frame was received, the sender will resend the same frame. To handle this, the header includes a **1-bit sequence number** that alternates with each frame, letting the receiver detect duplicates.

## Limitation
Only one outstanding frame at a time. Maximum sending rate:
```
Bits-per-Frame / Time-per-Frame
```
This wastes bandwidth when the link has high delay — the pipe is mostly empty. The solution is [[CSE461/Computer Networks Textbook/Direct Links/Reliable Tranmission/Sliding Window]].
