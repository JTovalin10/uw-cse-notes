# Flow Control & Retransmission

**Flow Control** is a transport-layer mechanism designed to prevent a fast sender from overwhelming a slow receiver. **Retransmission** is the primary method for achieving **Reliability** in an unreliable network, using timers and acknowledgments to recover from packet loss.

## Low-Level Primer: The Reliability/Flow-Control Duality
*   **Flow Control**: A receiver-side constraint. It manages the amount of data a sender can transmit before receiving an [[Acknowledgment (ACK)]] based on the receiver's available buffer space.
*   **Retransmission**: A sender-side recovery mechanism. It uses a **Timeout** to decide when a packet is "lost" and must be resent.
*   **The Constraint Equation**: `LastByteSent - LastByteAcked <= AdvertisedWindow`

---

## Retransmission Mechanics

### Timeout Strategy
Setting the **Retransmission Timeout (RTO)** is a trade-off between network efficiency and recovery speed.
*   **Short Timeout**: Recovers quickly but causes **Spurious Retransmissions** (resending data that was just delayed, not lost), which wastes bandwidth and worsens [[Congestion]].
*   **Long Timeout**: Avoids spurious resends but leaves the network idle for long periods during a real loss.

### Adaptive Retransmission (Jacobson/Karels Algorithm)
Because [[Round-Trip Time (RTT)]] varies significantly on the Internet due to [[Queuing]] and path changes, TCP uses a smoothed, adaptive timer.

1.  **Smoothed RTT (SRTT)**: A weighted moving average that filters out transient spikes.
    $$\text{SRTT}_{N+1} = (1 - \alpha) \times \text{SRTT}_N + \alpha \times \text{RTT}_{Sample}$$
    *(Standard $\alpha = 0.125$ or $0.1$)*
2.  **Smoothed Variation (Svar)**: Tracks the jitter or variance in RTT.
    $$\text{Svar}_{N+1} = (1 - \beta) \times \text{Svar}_N + \beta \times |\text{RTT}_{Sample} - \text{SRTT}_{N+1}|$$
    *(Standard $\beta = 0.25$ or $0.1$)*
3.  **The RTO Formula**: Sets the timeout to a conservative upper bound.
    $$\text{RTO} = \text{SRTT} + 4 \times \text{Svar}$$

[Image: Graph showing RTT samples vs. the adaptive timeout envelope]

### Karn/Partridge Algorithm (The Retransmission Ambiguity)
*   **The Problem**: If a segment is retransmitted and an ACK arrives, the sender cannot tell if the ACK is for the *original* transmission or the *retransmitted* one.
*   **The Solution**: Never update RTT estimates based on retransmitted segments. Only use ACKs for segments that were sent exactly once.

---

## Flow Control: The Sliding Window

### Stop-and-Wait (Simple Flow Control)
*   **Mechanism**: Sender sends one frame and waits for an ACK before sending the next.
*   **Inefficiency**: The throughput is limited to $1 \text{ Frame} / \text{RTT}$. On high-speed, long-distance links, the "pipe" remains mostly empty.

### Sliding Window (Modern Flow Control)
Used by [[Transmission Control Protocol (TCP)]] to keep multiple packets "in flight."
*   **Advertised Window ($Win$)**: The receiver specifies the number of bytes it can currently buffer in the **TCP Header**.
*   **Window Scaling**: An option that allows the 16-bit window field to be bit-shifted, supporting windows up to 1 GB for high-bandwidth links.

[Image: Sliding window visualization showing bytes acknowledged, bytes in flight, and the usable window]

### Window Management Issues
*   **Zero Window**: If $Win = 0$, the sender must stop. It periodically sends a **Window Probe** (1-byte segment) to force the receiver to return an ACK with a potentially updated window size.
*   **Silly Window Syndrome**:
    *   **Receiver's Side (Clark's Algorithm)**: Don't advertise a small window; wait until the buffer is $1/2$ full or can fit a full **MSS**.
    *   **Sender's Side (Nagle's Algorithm)**: Don't send tiny segments; buffer data until you have a full **MSS** worth or all outstanding data has been acknowledged.

## Related Topics
*   **[[Transmission Control Protocol (TCP)]]**: The primary implementation of these concepts.
*   **[[Sliding Window Protocol]]**: The theoretical foundation.
*   **[[Congestion]]**: How flow control interacts with network-level limits.
*   **[[Error Detection and Correction]]**: Ensuring the data being acknowledged is correct.
