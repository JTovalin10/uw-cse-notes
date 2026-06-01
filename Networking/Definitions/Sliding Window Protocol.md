# CSE461: Sliding Window Protocol

The **sliding window protocol** is a flow control mechanism where the sender can transmit up to a **window** of packets before needing an acknowledgment. The window slides forward as ACKs arrive.

- Controls the rate of transmission to prevent overwhelming the receiver's buffers
- Used in [[Hop-by-Hop Flow Control]] between adjacent nodes in [[Virtual Circuit (VC)]] networks
- Window size determines how many unacknowledged packets can be in flight at once

For a detailed breakdown of sender/receiver state and invariants, see [[Link Layer - Reliable Transmission]].

## Related
- [[Automatic Repeat Request (ARQ)]] — the retransmission framework that uses sliding windows
- [[Acknowledgment (ACK)]] — the control signal that advances the window
- [[Link Layer - Reliable Transmission]] — Stop-and-Wait, Go-Back-N, Selective Repeat
- [[Advertised Window (rwnd)]] — TCP's receiver-side window for flow control
- [[Congestion Window (cwnd)]] — TCP's sender-side window for congestion control
