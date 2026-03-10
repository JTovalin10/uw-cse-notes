# Network-Side Congestion Control: Explicit Feedback and Queue Management

## Low-Level Primer: Congestion vs. Flow Control
While **[[Flow Control]]** is a point-to-point mechanism to prevent a fast sender from overwhelming a slow receiver, **[[Transport Layer - TCP Congestion Control|Congestion Control]]** is a network-wide effort to prevent a subset of senders from overwhelming the shared infrastructure (routers and links). Traditional TCP (e.g., Tahoe, Reno) is **Reactive**: it drives the network into a state of congestion (packet loss) and then recovers.

**Network-Side Congestion Control** aims to move from reactive recovery to **Congestion Avoidance**. By involving the router in the signaling process, the network can provide explicit feedback before packet loss occurs, reducing both latency and retransmission overhead.

---

## Congestion Feedback Signals
The network can signal congestion to the end-hosts through three primary mechanisms:

1.  **Packet Loss**: The implicit signal used by traditional TCP. Simple but leads to high latency and reduced throughput during recovery.
2.  **Increased Delay**: Measured by end-hosts as an increase in **[[Round Trip Time (RTT)]]**. Used by algorithms like TCP Vegas.
3.  **Explicit Signaling**: The router actively marks packets to indicate the onset of congestion.

[Image: Feedback signals loop between sender, router queue, and receiver]

---

## Explicit Congestion Notification (ECN)
**ECN** is a protocol-level mechanism that allows routers to signal congestion without dropping packets. It requires support at the **[[Network Layer - Internetworking and IP|IP Layer]]** and the **[[Transport Layer - Transmission Control Protocol (TCP)|Transport Layer]]**.

### Technical Mechanics
*   **IP Header Marking**: The router detects the onset of congestion (typically via a threshold in the buffer queue). Instead of dropping a packet, it sets the **CE (Congestion Experienced)** codepoint in the 2-bit ECN field of the **[[IPv4]]** or **[[IPv6]]** header.
*   **Receiver Feedback**: When the receiver sees the CE mark, it notifies the sender by setting the **ECE (ECN-Echo)** flag in the **[[Transport Layer - Transmission Control Protocol (TCP)|TCP]]** header of the next ACK.
*   **Sender Response**: The sender receives the ECE flag and responds as if a packet loss had occurred (i.e., enters **[[Multiplicative Decrease]]**), reducing its congestion window (**[[Congestion Window (cwnd)|cwnd]]**). It then sets the **CWR (Congestion Window Reduced)** flag in its next data packet to acknowledge the feedback.

### Critical Evaluation of ECN
| Aspect | Detail |
| :--- | :--- |
| **Advantage** | Prevents packet loss, reducing retransmission overhead and application-level latency (jitter). |
| **Advantage** | Provides a clear, unambiguous signal compared to noisy RTT measurements. |
| **Disadvantage** | Requires a "full-stack" upgrade: both end-host OSs and every intermediate router must support ECN. |
| **Disadvantage** | Risk of "liar" receivers who ignore CE marks to maintain high throughput (solved by ECN Nonces). |

[Image: Packet marking and signaling flow in an ECN-enabled network]

---

## Random Early Detection (RED)
**RED** is an **Active Queue Management (AQM)** algorithm. Unlike traditional **Tail Drop** (which drops only when the buffer is 100% full), RED begins dropping packets proactively.

### The RED Algorithm
The router maintains an **Exponential Weighted Moving Average (EWMA)** of the queue length ($avg\_q$). It uses two thresholds:
1.  **Min_th**: If $avg\_q < min\_th$, every packet is accepted.
2.  **Max_th**: If $avg\_q > max\_th$, every packet is dropped (Tail Drop mode).
3.  **Transition Phase**: If $min\_th < avg\_q < max\_th$, the router drops packets with a probability $P$ that increases linearly from 0 to $max\_p$ as the queue grows.

### Why Randomness?
*   **Avoiding Global Synchronization**: In a Tail Drop scenario, all TCP flows experience loss simultaneously, cause them all to enter Multiplicative Decrease at the same time, leading to massive under-utilization of the link.
*   **Fairness**: By dropping randomly, RED is statistically more likely to drop a packet from a "heavy" flow (one sending more packets), effectively punishing the source of the congestion.

---

## Comparison of Queue Management Strategies

| Strategy | Feedback Mechanism | Efficiency | Fairness |
| :--- | :--- | :--- | :--- |
| **Tail Drop** | Implicit (Loss at 100% capacity) | Low (Causes Global Synchronization) | Poor |
| **RED** | Implicit (Random Loss before capacity) | Moderate (Prevents synchronization) | Good |
| **ECN + RED** | Explicit (Marking instead of dropping) | **High** (Avoids loss entirely) | Excellent |

[Image: Graph comparing queue occupancy and drop probability for Tail Drop vs. RED]
