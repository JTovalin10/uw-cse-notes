# TCP End-to-End Issues

TCP runs over the Internet rather than a physical point-to-point link. Its [[Sliding Window]] algorithm faces different challenges than at the link layer.

## Differences from link-level sliding window

| Issue | Link layer | TCP |
|-------|------------|-----|
| **Connection** | Same two nodes, dedicated link | Any two hosts; needs explicit setup/teardown |
| **RTT** | Fixed | Varies widely (1 ms to 500 ms+); timeout must be adaptive |
| **Reordering** | Impossible | Possible; packets can arrive out of order |
| **Resources** | Engineered for the link | Variable; must learn receiver capacity (flow control) |
| **Congestion** | Single sender, visible queue | Many senders; network capacity unknown |

## Maximum segment lifetime (MSL)

- TCP assumes each packet has a maximum lifetime
- IP discards packets when [[Time to Live (TTL)|TTL]] expires
- Recommended MSL: 120 seconds (conservative estimate)
- Very old packets could confuse the sliding window — TCP must handle delayed duplicates

## End-to-end argument

- Reliability should be provided **end-to-end**, not hop-by-hop
- Hop-by-hop guarantees (e.g., X.25) don't imply end-to-end correctness
	- Nodes can introduce errors or reorder
	- Heterogeneous links may not preserve service
- **Rule:** Don't provide a function at lower levels unless it can be completely and correctly implemented there
- **Exception:** Incomplete low-level functions OK as performance optimization
	- e.g., hop-by-hop CRC — detect/retransmit corrupt packet across one hop vs. entire file end-to-end

## Related

- [[Transmission Control Protocol (TCP)]]
- [[Sliding Window]]
- [[Flow Control]]
- [[Round-Trip Time (RTT)]]
