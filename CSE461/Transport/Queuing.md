# Queuing

Queuing is what happens inside a [[Router]] or [[Switch]] when packets arrive faster than they can be sent out. The router stores these packets in memory buffers. The **Queuing Discipline** determines two things:
1. **Scheduling**: Which packet in the buffer gets to go next?
2. **Drop Policy**: If the buffer is full, which packet gets thrown away?

---

## 1. FIFO (First-In, First-Out)
The simplest approach. The first packet to arrive is the first to be sent.
- **Tail Drop**: If the buffer is full, newly arriving packets are discarded without regard to flow.
- **Priority Queuing**: Higher-priority packets (routing updates, VoIP) bypass lower-priority packets. It can starve the lower-priority flows if not carefully rate-limited.

---

## 2. Fair Queuing (FQ)
The goal of FQ is to isolate flows so that no single flow can "hog" the entire link.

- **Mechanism**: The router maintains a separate queue for every flow. It services them in a round-robin style.
- **Bit-by-Bit Round Robin**: FQ simulates bit-by-bit round-robin by calculating a **Finishing Time** ($F_i$) for each packet.
- **Formula**:
  $$F_i = \max(F_{i-1}, A_i) + L_i$$
  - $A_i$: Arrival time.
  - $L_i$: Length of packet $i$.
  - The router sends the packet with the lowest $F_i$ first.
- **Work Conserving**: FQ is work-conserving, meaning the link is never left idle if there is a packet to send.

---

### Weighted Fair Queuing (WFQ)
An enhancement where different flows get different shares of the bandwidth based on a weight $w_i$.
- **Bandwidth Share**: A flow with weight $w_i$ gets:
  $$Bandwidth\_Share = \frac{w_i}{\sum w_j} \times Total\_Capacity$$
- This allows a router to reserve e.g. 50% for Video, 30% for Web, and 20% for Email.
- This is the core mechanism behind [[Quality of Service (QoS)]].

---

## Why does it matter?
Queuing directly impacts **[[Round-Trip Time (RTT)]]**. If a packet sits in a queue for a long time, the RTT goes up. If the queue overflows, the packet is lost, which signals [[Transmission Control Protocol (TCP)|TCP]] to slow down.

## Related Topics
- [[Advanced Congestion Control]] — Using queues to warn hosts of congestion.
- [[Statistical Multiplexing]] — Using queues to handle "bursty" traffic efficiently.
- [[Bufferbloat]] — The problem of having queues that are *too* large, leading to massive delays.
- [[Resource Allocation]] — The "policy" side of these mechanisms.
