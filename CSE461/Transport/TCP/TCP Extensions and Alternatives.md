# TCP Extensions and Alternatives

## TCP extensions (header options)

| Extension | Problem | Solution |
|-----------|---------|----------|
| **Timestamp** | Coarse RTT sampling | Put send time in header; receiver echoes; precise RTT |
| **PAWS** | 32-bit seq wraps on fast links | Use 64-bit ID (seq + timestamp) to distinguish incarnations |
| **Window scaling** | 16-bit window (64 KB) too small | Scale factor; effective window >> 64 KB |
| **SACK** | Cumulative ACK doesn't say which later segments arrived | Selective ACK for non-contiguous blocks; retransmit only gaps |

- Extensions added as options; hosts can communicate without them
- Agreed during connection establishment

**Without SACK:** Sender must choose pessimistic (retransmit all after gap) or optimistic (retransmit one at a time) strategy. SACK allows retransmit just the gaps.

## Alternative design choices

- **Byte stream vs message** — TCP chose byte stream; messages require upper bound. SCTP is message-oriented.
- **Strict order** — TCP delivers in order; some apps prefer out-of-order for lower latency. SCTP, QUIC support partial ordering.
- **Explicit setup/teardown** — TCP has 3-way handshake; could piggyback on first data. QUIC combines setup + TLS in 1 RTT.
- **Window vs rate** — TCP uses window; rate = window/RTT. Rate-based is an alternative.

## SCTP

Stream Control Transmission Protocol:
- Partially ordered delivery
- Message-oriented
- Multiple IP addresses per session

## QUIC

- Runs over [[User Datagram Protocol (UDP)|UDP]] (deployable through middleboxes)
- Fast setup: connection + TLS in 1 RTT
- Connection ID persists across network changes (Wi-Fi ↔ cellular)
- Multiple streams per connection; avoids head-of-line blocking
- Congestion control similar to TCP
- HTTP/3 uses QUIC

## Multipath TCP

- Steers packets over multiple paths (e.g., Wi-Fi + cellular)
- Receiver reconstructs in-order byte stream
- Complex interactions with flow control and congestion control

## Related

- [[Transmission Control Protocol (TCP)]]
- [[User Datagram Protocol (UDP)]]
- [[Remote Procedure Call (RPC)]]
- [[Sliding Window]]
