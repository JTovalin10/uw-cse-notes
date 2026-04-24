# Congestion Window (cwnd)

## Low-Level Primer: The Transmission Limit
The **Congestion Window (cwnd)** is a TCP state variable maintained by the sender that limits the amount of data (in bytes or segments) the sender can have "in-flight" (unacknowledged) on the network at any given time. It is the primary mechanism used for **[[Transport Layer - TCP Congestion Control|Congestion Control]]**.

Unlike the **[[Advertised Window (rwnd)]]**, which is dictated by the receiver's buffer capacity, the **cwnd** is dynamically adjusted by the sender's estimation of the network's available capacity.

---

## Technical Mechanics

The sender is constrained by the **Effective Window**, which is the minimum of the congestion window and the receiver's advertised window:
$$\text{Max In-Flight Data} = \min(\text{cwnd}, \text{rwnd})$$

### cwnd Dynamics
The value of **cwnd** changes based on the congestion control phase:
1.  **[[Slow Start]]**: cwnd starts at 1 Maximum Segment Size (MSS) and increases by 1 MSS for every ACK received (exponential growth).
2.  **[[Congestion Avoidance]]**: cwnd increases linearly by 1 MSS per **[[Round-Trip Time (RTT)]]**.
3.  **[[Multiplicative Decrease]]**: Upon detecting packet loss (via timeout or duplicate ACKs), cwnd is reduced (typically cut in half or reset to 1 MSS depending on the algorithm).

---

## Key Differences

| Feature | Congestion Window (cwnd) | Advertised Window (rwnd) |
| :--- | :--- | :--- |
| **Owner** | Sender | Receiver |
| **Purpose** | Prevent network congestion | Prevent receiver buffer overflow |
| **Source of Info** | Network feedback (Loss/ACKs) | Explicit header field in ACKs |
| **Constraint Type** | Network Path Limit | Endpoint Resource Limit |

## Related Terminology
*   **[[ssthresh]] (Slow Start Threshold)**: The target value where TCP switches from exponential growth (Slow Start) to linear growth (Congestion Avoidance).
