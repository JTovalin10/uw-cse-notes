# Transport Layer: TCP Congestion Control

## Low-Level Primer: Probing for Capacity
The Internet is a shared infrastructure with no central scheduler. To avoid **Congestion Collapse**, TCP must dynamically adjust its transmission rate based on the current network state. It treats the network as a "black box" and uses packet loss as a binary signal of congestion.

TCP maintains a **Congestion Window (cwnd)** that limits the amount of data in flight:
$$\text{Effective Window} = \min(\text{Advertised Window}, \text{Congestion Window})$$

---

## 1. The AIMD Control Law

**Additive Increase Multiplicative Decrease (AIMD)** is the fundamental algorithm for achieving efficiency and fairness.

*   **Additive Increase (AI)**: In the absence of loss, increase $cwnd$ by $1$ **MSS** per **RTT**. This gently probes for additional bandwidth.
*   **Multiplicative Decrease (MD)**: Upon detecting congestion (packet loss), immediately cut $cwnd$ in half (e.g., $cwnd = cwnd / 2$). This rapidly reduces load to allow the bottleneck buffer to drain.

[Image: The AIMD "Sawtooth" diagram showing cwnd vs. time]

---

## 2. Standard Phases of Congestion Control

### Phase 1: Slow Start
*   **Goal**: Rapidly reach the network's available capacity.
*   **Mechanism**: Start with $cwnd = 1 \text{ MSS}$. For **every ACK received**, $cwnd = cwnd + 1$. 
*   **Growth**: Exponential (doubles every RTT: 1, 2, 4, 8...).
*   **Transition**: Continues until $cwnd \ge ssthresh$ (slow start threshold) or a loss occurs.

### Phase 2: Congestion Avoidance
*   **Goal**: Carefully track the "knee" of the congestion curve.
*   **Mechanism**: For **every ACK received**, $cwnd = cwnd + (1 / cwnd)$.
*   **Growth**: Linear (increases by 1 MSS per RTT).

---

## 3. Loss Detection and Recovery

### Timeout (TCP Tahoe)
*   **Mechanism**: If the retransmission timer expires, it is the strongest signal of congestion.
*   **Action**: $ssthresh = cwnd / 2$, $cwnd = 1$. Restart from **Slow Start**.
*   **Drawback**: Catastrophic loss of the **[[ACK Clocking|ACK Clock]]**; throughput drops to near-zero.

### Fast Retransmit and Fast Recovery (TCP Reno)
*   **The Signal**: Receiving **3 Duplicate ACKs**. This indicates that while one segment is missing, subsequent segments are still reaching the receiver (the network is not completely stalled).
*   **Fast Retransmit**: Resend the missing segment immediately without waiting for a timeout.
*   **Fast Recovery**: $ssthresh = cwnd / 2$, $cwnd = ssthresh$. Skip Slow Start and resume linear **Congestion Avoidance**. This preserves the ACK clock and significantly improves performance.

---

## 4. Retransmission Timeout (RTO) Calculation

To avoid the **[[Timeout Misfortune]]**, TCP uses the **Jacobson/Karels Algorithm** to calculate a precise RTO based on RTT variance.

1.  **SampleRTT**: Measured time for a single packet/ACK cycle.
2.  **EstimatedRTT**: An **EWMA** of the samples.
3.  **DevRTT**: Tracks the mean deviation (jitter).
4.  **RTO Formula**: $RTO = \text{EstimatedRTT} + 4 \times \text{DevRTT}$.

*   **Karn's Algorithm**: Never update RTT estimates based on retransmitted segments, as the resulting ACK is ambiguous.

---

## 5. Advanced Congestion Control

*   **ECN (Explicit Congestion Notification)**: Routers mark packets (CE bit in IP header) instead of dropping them. The receiver echoes this to the sender (ECE bit in TCP header), allowing the sender to perform MD without experiencing a loss.
*   **TCP BBR**: A model-based algorithm that measures **Bottleneck Bandwidth** and **Min RTT** independently, avoiding the "bufferbloat" issues of loss-based Reno.
*   **SACK (Selective ACK)**: Allows the receiver to acknowledge non-contiguous blocks of data, enabling the sender to retransmit only the specific gaps in a single RTT.
