A flow control mechanism where the sender can transmit up to a **window** of packets before needing an acknowledgment. The window slides forward as acks arrive.

- Controls the rate of transmission to prevent overwhelming the receiver's buffers
- Used in [[Hop-by-Hop Flow Control]] between adjacent nodes in [[Virtual Circuit (VC)]] networks
- Window size determines how many unacknowledged packets can be in flight

For a detailed breakdown of sender/receiver state and invariants, see [[CSE461/Link Layer/Retransmission/Sliding Window]].
