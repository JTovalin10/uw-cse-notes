# Link Layer: Node-to-Node Delivery and Framing

## Low-Level Primer: The L2/L3 Duality
In the hierarchical network model, the **[[Link Layer]]** (Layer 2) is responsible for the reliable transfer of data units called **Frames** over a single physical or logical link. It operates below the **[[Network Layer]]** (Layer 3) and directly above the **[[Physical Layer]]**.

*   **L2 Address (MAC Address)**: A 48-bit, hardware-encoded "flat" identifier used for delivery between directly connected nodes (e.g., `00:1A:2B:3C:4D:5E`).
*   **L3 Address (IP Address)**: A hierarchical identifier used for global routing across multiple network segments.
*   **The Invariant Principle**: During a packet's journey, the **L3 Addresses** (Source and Destination IP) remain constant, while the **L2 Addresses** (Source and Destination MAC) are stripped and replaced at every router hop as the packet is re-encapsulated into a new frame.

---

## Framing: Defining Frame Boundaries
Because the Physical Layer provides a continuous stream of bits, the Link Layer must "frame" this data into discrete packets using delimiters.

### 1. Byte-Oriented Protocols (Sentinel-Based)
Frames are viewed as a sequence of bytes.
*   **Method**: Uses special sentinel characters (e.g., `STX` for Start of Text, `ETX` for End of Text) to mark boundaries.
*   **Byte Stuffing**: If a sentinel byte appears in the actual payload, it is escaped using a special **DLE (Data Link Escape)** character.
*   **Protocols**: **PPP (Point-to-Point Protocol)**, **BISYNC**.

### 2. Bit-Oriented Protocols (High-Level Data Link Control - HDLC)
Frames are viewed as a sequence of bits, independent of byte boundaries.
*   **Flag Sequence**: The pattern `01111110` marks both start and end.
*   **Bit Stuffing**: To prevent data from being mistaken for a flag, the sender inserts a `0` after every five consecutive `1`s in the payload. The receiver removes the `0`.

[Image: HDLC frame format showing Flag, Address, Control, Payload, and CRC fields.]

---

## Error Detection: Maintaining Data Integrity
Physical links are noisy and prone to bit-flipping errors. The Link Layer uses redundancy to detect and sometimes correct these errors.

### 1. Cyclic Redundancy Check (CRC)
The most robust error detection mechanism, based on polynomial long division in GF(2).
*   **Divisor Polynomial ($C(x)$)**: A fixed polynomial agreed upon by both sender and receiver.
    *   **CRC-32**: $x^{32} + x^{26} + x^{23} + x^{22} + x^{16} + x^{12} + x^{11} + x^{10} + x^8 + x^7 + x^5 + x^4 + x^2 + x + 1$.
*   **Detection Capabilities**: Detects all single and double-bit errors, any odd number of errors, and burst errors of length up to the degree of the polynomial.

### 2. Internet Checksum
*   **Mechanism**: Treats data as a sequence of 16-bit integers and computes their 1's complement sum.
*   **Trade-off**: Computationally efficient (can be done in software) but mathematically weaker than CRC (e.g., cannot detect byte swaps).

---

## Reliability and Retransmission (ARQ)
**Automatic Repeat Request (ARQ)** ensures reliable delivery even when frames are lost.

*   **Stop-and-Wait**: Sender transmits one frame and waits for an **ACK**. If the timer expires before an ACK arrives, the frame is retransmitted.
*   **Sliding Window**: Allows multiple frames (up to the **Send Window Size - SWS**) to be in-flight before requiring an ACK.
    *   **Go-Back-N**: Receiver discards all frames following a lost frame; sender must retransmit the entire window.
    *   **Selective Repeat**: Receiver buffers out-of-order frames; sender only retransmits the missing frame.

[Image: Comparison of Go-Back-N and Selective Repeat window mechanisms.]

---

## Multiple Access Control (MAC)
When multiple nodes share a single medium (e.g., Ethernet or Wireless), the Link Layer must manage access to prevent collisions.

*   **CSMA/CD (Carrier Sense Multiple Access with Collision Detection)**: Used in wired Ethernet. Listen before talking; stop and wait a random backoff time if a collision is detected.
*   **CSMA/CA (Collision Avoidance)**: Used in Wi-Fi. Nodes use "Request to Send" (RTS) and "Clear to Send" (CTS) to avoid collisions in the presence of hidden terminals.

[Image: Hidden Terminal Problem diagram.]
