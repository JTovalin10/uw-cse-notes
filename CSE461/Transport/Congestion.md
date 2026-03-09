# Congestion Control & Resource Allocation

**Congestion** is a network-layer phenomenon that occurs when the aggregate demand for a resource (e.g., [[Link]] bandwidth or [[Router]] buffer space) exceeds its available capacity. Left unmanaged, it leads to **Congestion Collapse**, where throughput drops to near-zero as the network becomes saturated with retransmissions of dropped packets.

## Low-Level Primer: The Congestion Metric
The performance of a congested network is typically evaluated using the **Power Curve**.
*   **Throughput**: The rate at which data is successfully delivered to the destination.
*   **Delay (Latency)**: The time taken for a packet to traverse the network, including processing, transmission, and [[Queuing]] delays.
*   **The Power Metric**: Defined as $\text{Power} = \frac{\text{Throughput}}{\text{Delay}}$.
    *   **Goal**: Network designers aim to operate at the "knee" of the curve, where throughput is maximized before queuing delays begin to grow exponentially.

[Image: Power curve showing the relationship between throughput, delay, and the optimal operating point]

---

## The Mechanics of Congestion Control

### ACK Clocking (Self-Clocking)
TCP uses the arrival of [[Acknowledgment (ACK)|ACKs]] to trigger the transmission of new data, a process known as **ACK Clocking**.
*   **Principle**: The rate at which ACKs return to the sender matches the rate at which packets can clear the bottleneck link.
*   **Benefit**: It naturally "paces" the sender to the network's capacity, preventing massive bursts that would overflow router buffers.

[Image: ACK clocking diagram showing how ACKs regulate the entry of new segments into the network]

### Jain’s Fairness Index
A mathematical measure used to determine if multiple flows are sharing a link equitably.
$$\mathcal{J}(x_1, x_2, \dots, x_n) = \frac{(\sum_{i=1}^n x_i)^2}{n \sum_{i=1}^n x_i^2}$$
*   **Range**: $1/n$ (worst case) to $1.0$ (perfectly fair).

---

## Router-Assisted Solutions: Active Queue Management (AQM)

Standard routers use **Tail Drop** (discarding packets only when the buffer is $100\%$ full). AQM algorithms proactively manage queues to prevent synchronization and long delays.

### 1. DECbit (Explicit Signaling)
One of the first implementations of **Binary Feedback**.
*   **Mechanism**: Routers monitor average queue length. If $\text{AvgQueue} \ge 1.0$, they set a **Congestion Experienced** bit in the packet header.
*   **Host Reaction**: The source calculates the fraction of bits set in the last window.
    *   If $< 50\%$: Increase window additively ($+1$).
    *   If $\ge 50\%$: Decrease window multiplicatively ($\times 0.875$).

### 2. RED (Random Early Detection)
The industry-standard AQM algorithm. It drops packets *randomly* based on a weighted average of the queue length.
*   **Algorithm Steps**:
    1.  Calculate **Weighted Moving Average**: $\text{AvgLen} = (1 - w) \times \text{AvgLen} + w \times \text{SampleLen}$.
    2.  If $\text{AvgLen} < \text{MinThreshold}$: No packets are dropped.
    3.  If $\text{AvgLen} > \text{MaxThreshold}$: All packets are dropped (**Tail Drop**).
    4.  If $\text{Min} \le \text{AvgLen} \le \text{Max}$: Drop packet with probability $P$.
*   **Goal**: Prevent **Global Synchronization** (where all TCP flows back off simultaneously) and eliminate "lock-out" of new flows.

### 3. ECN (Explicit Congestion Notification)
The modern extension to [[Internet Protocol (IP)]] and [[Transmission Control Protocol (TCP)]].
*   **Marking vs. Dropping**: Routers mark the **CE** (Congestion Encountered) bits in the IP header instead of dropping the packet.
*   **TCP Feedback**:
    1.  Receiver sees **CE** bit; sends ACK with **ECE** (ECN-Echo) flag.
    2.  Sender halves its `cwnd` and sends next segment with **CWR** (Congestion Window Reduced) flag.

---

## Advanced Source-Based Algorithms

Modern TCP variants use timing and bandwidth modeling rather than just packet loss.

| Algorithm | Key Metric | Logic |
| :--- | :--- | :--- |
| **TCP Vegas** | RTT Delay | Measures `Diff = ExpectedRate - ActualRate`. If `Diff > Threshold`, it slows down *before* loss occurs. |
| **TCP BBR** | Bandwidth/RTT | Models the **Bottleneck Bandwidth** and **Min RTT**. It paces packets at the estimated rate to prevent **Bufferbloat**. |
| **DCTCP** | ECN Fraction | Used in Data Centers. It reduces `cwnd` proportionally to the fraction of marked packets ($\alpha$) rather than a fixed $50\%$ cut. |
| **TCP CUBIC** | Time-based | Uses a cubic function to grow the window. It stays near the previous "best" rate for a long time and then probes aggressively. |

### The Formula for TCP CUBIC
$$W(t) = C(t - K)^3 + W_{max}$$
*   $K$: The time at which the window reaches $W_{max}$.
*   $W_{max}$: The window size at the last congestion event.

## Related Topics
*   **[[Queuing]]**: The hardware implementation of packet buffers.
*   **[[Resource Allocation]]**: The broader policy of link sharing.
*   **[[Quality of Service (QoS)]]**: Providing differentiated service levels (e.g., priority for voice).
