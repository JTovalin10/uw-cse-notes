# ssthresh (Slow Start Threshold)

## Low-Level Primer: The Transition Point
**ssthresh** (Slow Start Threshold) is a TCP state variable that dictates when the sender should transition from the **[[Slow Start]]** phase to the **[[Congestion Avoidance]]** phase. It represents the sender's best estimate of the network's available "bottleneck" capacity.

---

## Technical Mechanics

TCP uses **ssthresh** to balance the need for rapid capacity probing (exponential growth) with the need for stable, cautious probing (linear growth).

### Phase Transition Rules
1.  **If cwnd < ssthresh**: TCP is in **Slow Start**. The congestion window increases by 1 MSS for every ACK received (exponential growth).
2.  **If cwnd >= ssthresh**: TCP transitions to **Congestion Avoidance**. The congestion window increases by 1 MSS per **[[Round-Trip Time (RTT)]]** (linear growth).

### Dynamic Adjustment
The value of **ssthresh** is not fixed; it is dynamically recalculated whenever congestion is detected:
*   **On Loss (Duplicate ACKs)**: In **TCP Reno**, `ssthresh` is set to $cwnd / 2$, and `cwnd` is set to the new `ssthresh` (skipping slow start).
*   **On Timeout**: `ssthresh` is set to $cwnd / 2$, and `cwnd` is reset to 1 MSS (entering a full slow-start restart).

---

## Significance in AIMD
**ssthresh** is the primary driver behind the **Multiplicative Decrease** part of the **[[Transport Layer - TCP Congestion Control#1. The AIMD Control Law|AIMD]]** control law. By setting the threshold to half of the congestion-causing window, TCP ensures that it restarts its probe from a safe, non-congesting rate.
