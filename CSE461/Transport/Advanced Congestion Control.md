# Advanced Congestion Control

Standard [[Transmission Control Protocol (TCP)|TCP]] reacts to congestion only *after* it happens (when a packet is lost). **Advanced Congestion Control** focuses on **Congestion Avoidance**—detecting that the network is *starting* to get full and slowing down before packets actually drop.

---

## Active Queue Management (AQM)
In AQM, the [[Router]] actively helps the end hosts by signaling that buffers are getting full.

### 1. DECbit (Destination Experience Bit)
Developed in the 1980s, this was one of the first explicit signals.
- **What is it?** Routers monitor their average queue length. If it's $\ge 1$, they set a "congestion bit" in the packet header.
- **Why?** It attempts to optimize the **[[Power]]** function ($Throughput / Delay$). A queue length of 1 balances high throughput with low idle time.
- **How it works:** Destination echoes the bit to the source in an [[Acknowledgment (ACK)|ACK]].
  - If $<50\%$ of packets in the last window had the bit set, the source increases its window by $1$.
  - If $\ge 50\%$ have the bit set, the source decreases its window to $0.875 \times$ the previous value.

### 2. RED (Random Early Detection)
RED is the most famous AQM algorithm.
- **What is it?** Instead of waiting for the buffer to be $100\%$ full ([[Queuing#Tail Drop|Tail Drop]]), the router starts dropping packets *randomly* once a "Minimum Threshold" is reached.
- **Parameters:**
  - `MinThreshold`: Below this, no drops.
  - `MaxThreshold`: Above this, all packets are dropped.
  - `AvgLen`: A weighted running average: `AvgLen = (1 - Weight) x AvgLen + Weight x SampleLen`.
- **Logic:** Drop probability $P$ increases linearly between `Min` and `Max`. The actual probability $P = \frac{TempP}{1 - count \times TempP}$ ensures drops are evenly distributed over time to avoid multiple drops in the same TCP connection.
- **Global Synchronization:** RED prevents all flows from backing off at once by dropping only a few packets randomly.

### 3. ECN (Explicit Congestion Notification)
The modern standard for signaling.
- **What is it?** Instead of dropping a packet, the router **marks** it using the `CE` (Congestion Encountered) bit in the IP header.
- **Mechanism:** The TCP receiver echoes this to the sender (setting `ECE` flag). The sender responds by setting `CWR` (Congestion Window Reduced) after halving its rate.
- **Benefit:** Congestion signal without the delay of a retransmission.

---

## Source-Based Avoidance (Host-Only)
These algorithms don't need router help; they just look at timing.

### 1. TCP Vegas
Vegas measures [[Round-Trip Time (RTT)]] very carefully to detect queue build-up.
- **What is it?** It compares the "Actual" throughput with the "Expected" throughput.
  - `ExpectedRate = CongestionWindow / BaseRTT`
  - `ActualRate = BytesSent / RTT_Sample`
- **Mechanism:** `Diff = ExpectedRate - ActualRate`. 
  - If `Diff < alpha` (where $\alpha$ is usually 1 buffer), increase window (underutilization).
  - If `Diff > beta` (where $\beta$ is usually 3 buffers), decrease window (congestion starting).

### 2. TCP BBR (Bottleneck Bandwidth and RTT)
A modern algorithm developed by Google to solve the **Bufferbloat** problem.
- **Logic:** It models the network's max bandwidth and min delay. It then **paces** packets based on estimated bandwidth rather than relying on the "self-clocking" of ACKs.
- **Benefit:** It avoids filling up router queues entirely, leading to much lower latency.

### 3. DCTCP (Data Center TCP)
A specialized version of TCP for high-speed, low-latency datacenter environments.
- **Mechanism:** It uses ECN to estimate the *fraction* of bytes $(\alpha)$ that encountered congestion.
- **Formula:** $cwnd = cwnd \times (1 - \alpha/2)$.
- **Benefit:** Reduces rate proportionally to the amount of congestion rather than always cutting it in half.

## Related Topics
- [[Congestion]] — High-level theory.
- [[Queuing]] — How routers manage these buffers.
- [[Flow Control]] — End-to-end rate matching.
- [[Power]] — Throughput vs. delay metric.
