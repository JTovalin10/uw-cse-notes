# Physical Layer: Performance and Latency

## Low-Level Primer: The Three Dimensions of Link Performance
The performance of a physical link is governed by how much data can be transmitted (**Bandwidth**), how long it takes for a signal to traverse the medium (**Propagation Delay**), and how much data the link can hold simultaneously (**Bandwidth-Delay Product**).

---

## 1. The Components of Latency

**Latency** (or Total Delay) is the cumulative time required for a message to travel from the source to the destination.

### Transmission Delay ($T_{trans}$)
The time required to push all bits of a message into the physical medium.
*   **Formula**: $T_{trans} = \frac{M}{R}$
*   **$M$**: Message size in bits.
*   **$R$**: Link rate (Bandwidth) in bits per second (bps).
*   **Note**: This delay is constant regardless of distance.

### Propagation Delay ($T_{prop}$)
The time required for a single bit to travel from the sender to the receiver.
*   **Formula**: $T_{prop} = \frac{L}{c}$
*   **$L$**: Physical length of the link (meters).
*   **$c$**: Speed of signal propagation in the medium.
    *   Copper/Fiber speed is typically $\approx 2 \times 10^8$ m/s (roughly 2/3 the speed of light).
*   **Note**: This delay is proportional to distance.

### Queuing Delay ($T_{queue}$)
The time a packet spends waiting in a router's buffer before it can be transmitted on the output link.
*   **Cause**: Occurs when the arrival rate at a router exceeds the output link capacity.
*   **Nature**: Stochastic; varies with network congestion.

---

## 2. Bandwidth vs. Throughput

*   **Bandwidth**: The theoretical maximum data transfer rate of a link (the "capacity").
*   **Throughput**: The actual, measured rate of successful data delivery over time.
    *   **Calculation**: $\text{Throughput} = \frac{\text{Data Size}}{\text{Total Transfer Time}}$
    *   Throughput is always $\le$ Bandwidth due to protocol overhead, errors, and congestion.

---

## 3. Bandwidth-Delay Product (BDP)

The **BDP** represents the "volume" of the network pipe—the maximum number of bits that can be "in flight" at any given moment.

*   **Formula**: $BDP = R \times RTT$
    *   $R$: Bandwidth (bps).
    *   $RTT$: Round-Trip Time (seconds).
*   **Significance**:
    *   To keep a high-speed, long-distance link full, the sender's window size (in **Sliding Window** protocols) must be at least the BDP.
    *   If the window is smaller than the BDP, the sender will stop and wait for ACKs while the link is idle, leading to low **Utilization**.

---

## Performance Math Cheat Sheet

| Metric | Formula | Units |
| :--- | :--- | :--- |
| **Total Latency** | $T_{trans} + T_{prop} + T_{queue}$ | Seconds |
| **Bit Width (Time)** | $\frac{1}{R}$ | Seconds |
| **Bit Width (Space)**| $\frac{c}{R}$ | Meters |
| **Utilization ($U$)**| $\frac{T_{trans}}{T_{trans} + RTT}$ | Percentage |

[Image: Diagram showing bits filling a physical pipe, illustrating the difference between Bandwidth (width) and Propagation Delay (length)]
