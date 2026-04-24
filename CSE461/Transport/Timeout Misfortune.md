# Timeout Misfortune: Adaptive Retransmission and the ACK Clock

## Low-Level Primer: The Criticality of the ACK Clock
In high-performance networking, the **[[ACK Clocking|ACK Clock]]** is the self-clocking mechanism where the arrival of an **[[Acknowledgment (ACK)]]** at the sender triggers the injection of a new data segment into the pipe. This ensures that the rate of data entering the network matches the rate at which data is leaving the network at the bottleneck link. 

**Timeout Misfortune** refers to the catastrophic loss of this "clock" due to a **Retransmission Timeout (RTO)**. When a timeout occurs, the pipe is effectively drained, and the sender must restart from a "cold" state, typically using **[[Slow Start (TCP Additive Increase)|Slow Start]]** to rebuild the timing and flow of the network.

---

## The Dual Misfortune of Timeouts

Setting a fixed timeout is mathematically impossible for the global Internet due to the high variance in **[[Round-Trip Time (RTT)]]**. An incorrect timeout leads to two distinct failure modes:

### 1. The Early (Spurious) Timeout
*   **Definition**: The timeout fires before the actual ACK has had time to return, even though the packet was not lost.
*   **Consequence**: **Spurious Retransmissions**. The sender injects redundant data into a network that is likely already congested, potentially leading to **Congestion Collapse**.
*   **Technical Impact**: Wastes bandwidth and can cause the receiver to receive duplicate segments, complicating the sliding window state.

### 2. The Late (Conservative) Timeout
*   **Definition**: The timeout is set much higher than the actual RTT.
*   **Consequence**: **Network Under-utilization**. If a packet is truly lost, the sender sits idle for a long duration while the pipe drains completely.
*   **Technical Impact**: Significant increase in application-layer latency and a total loss of the **ACK Clock**, requiring a slow-start restart.

---

## Adaptive RTO Calculation: The Jacobson/Karels Algorithm (1988)

To mitigate misfortune, TCP uses an adaptive algorithm that tracks both the mean RTT and the **statistical variance** (mean deviation).

### The Mathematical Model
1.  **SampleRTT**: The measured time from sending a segment to receiving its ACK.
2.  **EstimatedRTT**: A **Exponential Weighted Moving Average (EWMA)** of the RTT.
    *   `Difference = SampleRTT - EstimatedRTT`
    *   `EstimatedRTT = EstimatedRTT + (δ × Difference)` (typically $\delta = 0.125$)
3.  **DevRTT (Deviation)**: Tracks the variance in the samples.
    *   `DevRTT = DevRTT + δ × (|Difference| - DevRTT)`
4.  **The RTO Formula**:
    *   $\text{TimeOut} = \mu \times \text{EstimatedRTT} + \phi \times \text{DevRTT}$
    *   Standard constants: $\mu = 1$, $\phi = 4$.

**Result**: In a stable network with low variance, the timeout stays close to the RTT. In a jittery network, the $\phi \times \text{DevRTT}$ term "pushes" the timeout further out to avoid the **Early Timeout Misfortune**.

![[Screenshots/Example of Adaptive Timeout.png]]

---

## Expert Augmentation: Overcoming Ambiguity

### The Karn/Partridge Algorithm (1987)
A critical edge case in RTT estimation is **Retransmission Ambiguity**: if a segment is sent twice and an ACK arrives, does it acknowledge the first or second transmission?

*   **The Rule**: **Never sample RTT for retransmitted segments.** 
*   **The Backoff Strategy**: When a timeout occurs, use **[[Binary Exponential Backoff (BEB)]]**. Double the RTO for each subsequent attempt until a successful (non-retransmitted) ACK is received. 
*   **Rationale**: Loss is usually caused by congestion; backing off the timer prevents the sender from further overwhelming the bottleneck.

### Consequences of Losing the ACK Clock
When a timeout is the *only* way a loss is detected:
*   The **[[Congestion Window (cwnd)]]** is reset to **1 MSS**.
*   The sender enters **Slow Start**.
*   The throughput drops to near-zero until the "pipe" can be refilled.
*   **Optimization**: Modern TCP uses **[[Transport Layer - TCP Congestion Control#3. Loss Detection and Recovery|Fast Retransmit]]** (3 duplicate ACKs) to repair losses *before* a timeout occurs, preserving the ACK clock.

---

## Summary of Timeout Strategies

| Strategy | Logic | Pros | Cons |
| :--- | :--- | :--- | :--- |
| **Fixed Timeout** | Static value (e.g., 200ms) | Simple to implement | Brittle; fails on global Internet |
| **Original Adaptive** | $2 \times \text{EstimatedRTT}$ | Adapts to mean RTT | Ignores variance; prone to spurious resends |
| **Jacobson/Karels** | $\text{SRTT} + 4 \times \text{DevRTT}$ | Handles jitter/variance | Requires more state (tracking deviation) |
| **Exponential Backoff**| $\text{RTO} = \text{RTO} \times 2$ | Prevents congestion collapse | High latency on persistent loss |

![[Screenshots/Fast Retransmit.png]]


![[Screenshots/Example of RTT for retransmissions.png]]
