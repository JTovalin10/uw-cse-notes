## Round-Trip Time (RTT)

The time it takes for a packet to travel from sender to receiver and for the [[Acknowledgment (ACK)|ACK]] to travel back. RTT includes propagation delay in both directions plus any processing/queuing delay.

- Simple formula: $2 \times$ [[Propagation Delay|propagation delay]] (or $2 \times$ [[Message Latency]] for a more accurate model)

- Critical for setting retransmission timeouts — if no ACK arrives within ~1 RTT, the sender assumes the packet was lost
- Affects throughput in [[Sliding Window Protocol|sliding window]] protocols: the sender can have at most `window_size` packets outstanding during one RTT
