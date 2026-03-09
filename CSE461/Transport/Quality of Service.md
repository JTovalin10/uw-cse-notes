# QoS, Queuing, and Resource Allocation

**Resource Allocation** is the process of managing competing demands for limited network resources: **[[Link]] Bandwidth** and **[[Router]] Buffer Space**. **Quality of Service (QoS)** defines the mechanisms used to provide performance guarantees (e.g., bounded delay, guaranteed throughput) beyond the standard **Best-Effort** delivery model.

## Low-Level Primer: The Queuing Discipline
A router manages its internal memory buffers using a **Queuing Discipline**, which defines two critical behaviors:
1.  **Scheduling**: Determining the order in which packets are transmitted out of the buffer.
2.  **Drop Policy**: Determining which packets are discarded when the buffer is saturated.

---

## Scheduling Algorithms

### 1. FIFO (First-In, First-Out)
The simplest scheduling mechanism. Packets are transmitted in the exact order they arrive.
*   **Drop Policy (Tail Drop)**: When the buffer is full, the most recently arrived packet is discarded.
*   **Priority Queuing**: A variation where multiple FIFO queues exist for different priority levels (e.g., Routing updates > VoIP > Web). High-priority queues are always emptied first, which can lead to **Starvation** of low-priority traffic.

### 2. Fair Queuing (FQ)
Designed to isolate flows so that no single "aggressive" flow can monopolize the link.
*   **Bit-by-Bit Round Robin**: FQ simulates a system where 1 bit is sent from each active queue in a round-robin fashion.
*   **The Finishing Time Formula**: Since routers send whole packets, FQ calculates a virtual "Finishing Time" ($F_i$) for each packet $i$:
    $$F_i = \max(F_{i-1}, A_i) + L_i$$
    *   $A_i$: Actual arrival time of the packet.
    *   $L_i$: Length of the packet in "virtual clock" ticks.
*   **Execution**: The router always transmits the packet with the **lowest** $F_i$ first.
*   **Work Conserving**: The link is never idle if at least one packet is in a queue.

### 3. Weighted Fair Queuing (WFQ)
An enhancement of FQ that allows different flows to receive different percentages of the link bandwidth based on a **Weight** ($w_i$).
*   **Bandwidth Share**: A flow $i$ with weight $w_i$ is guaranteed a share:
    $$\text{Bandwidth Share}_i = \frac{w_i}{\sum_{j} w_j} \times \text{Total Capacity}$$

---

## Quality of Service (QoS) Architectures

### 1. IntServ (Integrated Services)
A **Fine-Grained**, reservation-based model where resources are reserved per-flow.
*   **RSVP (Resource Reservation Protocol)**: The signaling protocol used by the receiver to request a specific QoS from all routers along the path.
*   **Soft State**: Reservations must be refreshed periodically or they time out.
*   **Flowspec**:
    *   **TSpec**: Describes traffic using a **Token Bucket** ($r, b$).
        *   $r$: Average token rate (sustained bandwidth).
        *   $b$: Bucket size (maximum burst size).
    *   **RSpec**: The service level (e.g., **Guaranteed** or **Controlled Load**).
*   **Scalability Issue**: Core routers cannot maintain state for millions of individual flows.

### 2. DiffServ (Differentiated Services)
A **Coarse-Grained** model that groups traffic into **Classes** rather than individual flows.
*   **DSCP (DiffServ Code Point)**: A 6-bit field in the [[IP]] header (Type of Service field) that identifies the packet's class.
*   **Per-Hop Behaviors (PHB)**:
    *   **EF (Expedited Forwarding)**: Low-latency, low-jitter priority service (used for VoIP).
    *   **AF (Assured Forwarding)**: Guaranteed bandwidth with four classes and three drop precedence levels.
*   **RIO (RED with In and Out)**: A drop policy where "Out-of-Profile" packets are dropped much earlier than "In-Profile" packets as congestion increases.

---

## Policing and Shaping
*   **Policing**: A "Hard Limit" where any packet exceeding the $r, b$ profile is immediately dropped.
*   **Shaping**: A "Soft Limit" where excess packets are buffered and delayed to smooth out bursts, ensuring the output stream conforms to the profile.

## The Power Metric & Fairness
*   **The Power Metric**: Evaluates the "efficiency" of an allocation scheme.
    $$\text{Power} = \frac{\text{Throughput}}{\text{Delay}}$$
*   **Jain's Fairness Index**: Quantifies how equitably $n$ flows are sharing a resource.
    $$\mathcal{J}(x_1, x_2, \dots, x_n) = \frac{(\sum x_i)^2}{n \sum x_i^2}$$

## Related Topics
*   **[[Congestion]]**: The result of resource allocation failure.
*   **[[Admission Control]]**: The decision to reject a reservation request.
*   **[[Statistical Multiplexing]]**: The principle behind over-subscribing link resources.
