# Transmission Control Protocol (TCP)

TCP provides a **reliable, ordered byte stream** over a connection. It is the workhorse of the Internet, used by everything from web browsers (HTTP) to file transfers.

## Key Features
- **Reliability**: Every byte is guaranteed to arrive via [[Acknowledgment (ACK)|ACKs]] and retransmissions.
- **Ordering**: If packets arrive out of order, TCP buffers them and presents them to the app in the correct sequence.
- **[[Flow Control]]**: Prevents a fast sender from overwhelming a slow receiver using an **Advertised Window**.
- **[[Congestion Control]]**: Prevents the sender from overwhelming the *network* itself.

---

## Connection Lifecycle

### 1. Establishment (Three-Way Handshake)
Before sending data, the two sides must "sync" up.
1. **SYN**: Client sends a sequence number $x$.
2. **SYN-ACK**: Server acknowledges $x$ and sends its own sequence number $y$.
3. **ACK**: Client acknowledges $y$.
- **Why randomly choose ISNs?** To prevent "off-path" attacks and avoid confusion from old, delayed packets from a previous connection "incarnation."

### 2. Termination (The Four-Way Teardown)
TCP is a "Symmetric" close. Both sides must independently close their half of the pipe.
- **FIN**: "I have no more data to send."
- **ACK**: "I got your request to close."
- **TIME_WAIT**: The active closer stays in this state for $2 \times MSL$ (Maximum Segment Lifetime, typically 60s) to ensure the final ACK arrived and to let old packets clear the network.

**State transitions:**
- **Active Close**: `ESTABLISHED` → `FIN_WAIT_1` → `FIN_WAIT_2` → `TIME_WAIT` → `CLOSED`
- **Passive Close**: `ESTABLISHED` → `CLOSE_WAIT` → `LAST_ACK` → `CLOSED`

---

## Congestion Control (The "Brain" of TCP)
TCP doesn't know how fast the network is. It has to "probe" the network to find the limit. It uses the `CongestionWindow` (cwnd) to limit in-flight data.

### AIMD (Additive Increase, Multiplicative Decrease)
- **Additive Increase**: For every successful RTT, `cwnd += 1 MSS`. 
  - Implementation: `cwnd += MSS * (MSS / cwnd)` for every ACK.
- **Multiplicative Decrease**: On loss, `cwnd = cwnd / 2` (but not less than 1 MSS).
- **The Sawtooth**: This pattern of aggressive back-off ensures the Internet stays stable even under heavy load.

### Phases
1. **Slow Start**: Used at the beginning or after a timeout. `cwnd` starts at 1 and doubles every RTT (exponential growth).
2. **Congestion Avoidance**: Once `cwnd >= ssthresh`, switch to linear growth (+1 per RTT).
3. **Fast Retransmit**: If the sender sees **3 duplicate ACKs**, it assumes a packet was lost and resends it *immediately* without waiting for a timeout.
4. **Fast Recovery**: After a Fast Retransmit, `ssthresh = cwnd / 2`, then `cwnd = ssthresh` (instead of 1), and it resumes linear increase.

### TCP CUBIC (Modern Default)
Optimized for "Long-Fat Networks" (High [[Bandwidth]]-Delay Product).
- **Formula**: $W(t) = C(t - K)^3 + W_{max}$
- **Logic**: It grows fast initially, slows down near the old $W_{max}$ (plateau), and then probes aggressively for new capacity.
- **Fairness**: Based on *time* since last loss rather than ACKs, making it fairer to flows with different RTTs.

---

## The TCP Segment
The TCP header contains fields for:
- **Sequence/ACK Numbers**: 32-bit fields for ordering and reliability.
- **Flags**: `SYN`, `FIN`, `ACK`, `RST`, `PSH`, `URG`, and ECN bits (`ECE`/`CWR`).
- **Options**: Including [[Maximum Transmission Unit (MTU)|MSS]] (usually 1460 bytes on Ethernet) and **Window Scaling** for large BDPs.

## Related Topics
- [[User Datagram Protocol (UDP)]] — The unreliable, "fast" alternative.
- [[Sliding Window Protocol]] — The general theory behind TCP's window.
- [[Advanced Congestion Control]] — Modern versions of TCP like BBR and CUBIC.
- [[Round-Trip Time (RTT)]] — Critical for setting timeouts and congestion rates.
