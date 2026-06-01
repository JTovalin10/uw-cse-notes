# Link Layer: Ethernet CSMA/CD

## Overview
**CSMA/CD (Carrier Sense Multiple Access with Collision Detection)** is the media access control algorithm used in traditional half-duplex Ethernet. It allows multiple nodes to share a single broadcast medium while minimizing and recovering from collisions.

---

## 1. The Three Rules of CSMA/CD

1.  **Carrier Sense**: "Listen before talking." A node must wait until the medium is idle before it starts transmitting.
2.  **Collision Detection**: "Listen while talking." While transmitting, a node constantly monitors the medium. If the signal it "hears" differs from the signal it is "driving," a collision has occurred.
3.  **Jam Signal**: Upon detecting a collision, the node immediately stops its regular transmission and sends a **32-bit Jam Signal** to ensure all other nodes also detect the collision.

---

## 2. Minimum Frame Size and Propagation Delay

For collision detection to work, a node must still be transmitting when its signal reaches the farthest point of the network and any potential collision signal travels back.

*   **Constraint**: $\text{Transmission Time} \ge 2 \times \text{Propagation Delay}$.
*   **The Round-Trip Time (RTT)**: This $2 \times \tau$ is often called the **Slot Time**.
*   **Ethernet Standard**: For 10 Mbps Ethernet, the slot time is 51.2 $\mu s$, which corresponds to a **Minimum Frame Size of 64 Bytes** (512 bits). 
    *   If a frame is smaller than 64B, it must be **padded**.
    *   This ensures that the sender is still "on the wire" when a collision notification arrives.

---

## 3. Binary Exponential Backoff (BEB)

After a collision, nodes do not retry immediately (which would cause another collision). Instead, they use **[[Binary Exponential Backoff (BEB)]]**:

1.  **Collision Count ($n$)**: The number of consecutive collisions for the current frame.
2.  **Wait Time**: Pick a random integer $k$ from $[0, 2^n - 1]$ and wait $k \times \text{SlotTime}$.
3.  **Backoff Cap**: $n$ is capped at 10 (range $[0, 1023]$).
4.  **Abort**: If $n = 16$, the frame is discarded.

---

## Related
- [[Link Layer Overview]]
- [[Binary Exponential Backoff (BEB)]]
