# Quality of Service (QoS)

The standard Internet uses a **Best-Effort** model: it tries its best to deliver packets, but makes no guarantees about when they will arrive or if they will be dropped. **Quality of Service (QoS)** is a set of technologies that allow the network to provide specific guarantees for different types of traffic.

---

## 1. IntServ (Integrated Services)
This is a "Fine-Grained" approach where every single flow makes a reservation.

- **RSVP (Resource Reservation Protocol)**: The protocol used to "sign up" for bandwidth.
- **Flowspec**:
  - **TSpec**: Traffic characteristics described using a **Token Bucket** ($r, B$).
  - **RSpec**: The service request (e.g., "Guaranteed" or "Controlled Load").
- **Token Bucket**:
  - A mechanism to handle "bursty" traffic. You accumulate tokens at a rate **$r$** (bytes per second) and can store up to **$B$** (bucket size). To send $n$ bytes, you need $n$ tokens.
  - This means a source can send a burst of $B$ bytes into the network at once, but its long-term average rate is limited to $r$.
- **Hard/Soft State**: IntServ uses **Soft State**, meaning reservations must be refreshed periodically or they disappear automatically.
- **Problem**: It doesn't scale. A core router can't track millions of individual flows.

---

## 2. DiffServ (Differentiated Services)
The "Coarse-Grained" approach used in modern networks. Instead of individual flows, it groups traffic into **Classes**.

- **DSCP (DiffServ Code Point)**: A 6-bit tag in the IP TOS field that identifies the packet's class.
- **Per-Hop Behaviors (PHB)**:
  - **Expedited Forwarding (EF)**: "Premium" service. The packet is forwarded with minimal delay (priority queueing).
  - **Assured Forwarding (AF)**: Uses **RIO (RED with In and Out)**. Packets "in profile" have lower drop probability than "out of profile" packets.
- **RIO Drop Policy**:
  - It maintains separate drop probability curves for "In" (inside profile) and "Out" (outside profile) traffic. "Out" traffic is dropped much earlier as queues build up.

---

## Key Mechanisms

### Admission Control
The process of a router saying "No" to a new reservation because its resources are already over-committed.

### Policing vs. Shaping
- **Policing**: Dropping packets that exceed their promised rate (hard limit).
- **Shaping**: Buffering excess packets so they are transmitted at a steady rate (smoothing).

### Equation-Based / TCP-Friendly Control
Real-time applications that don't need TCP's reliability but must be fair to TCP.
- **Formula**: $Rate \propto \frac{1}{RTT \times \sqrt{p}}$, where $p$ is the packet loss rate.
- This ensures that a video flow competes fairly with standard [[Transmission Control Protocol (TCP)|TCP]] flows.

## Related Topics
- [[Advanced Congestion Control]] — How routers handle "Best-Effort" congestion.
- [[Queuing]] — The underlying mechanism for priority and weights.
- [[Bandwidth]] — The resource being managed.
- [[Resource Allocation]] — High-level classification of these schemes.
