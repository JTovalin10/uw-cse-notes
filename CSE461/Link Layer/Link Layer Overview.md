# Link Layer & Framing

The **Link Layer** (Layer 2) is responsible for the reliable transfer of messages (**Frames**) over one or more connected physical links. It builds upon the **Physical Layer** by organizing raw bitstreams into discrete units and managing media access.

## Low-Level Primer: The L2/L3 Duality
The Link Layer provides node-to-node delivery, whereas the Network Layer provides host-to-host delivery.

*   **L2 Address (MAC Address)**: A 48-bit "flat" identifier (e.g., `00:1A:2B:3C:4D:5E`) used for delivery between directly connected nodes on a local network.
*   **L3 Address (IP Address)**: A hierarchical identifier used for global routing across multiple networks.
*   **The Invariant**: During traversal, the **L3 Address** remains constant, while the **L2 Address** changes at every hop as the frame is re-encapsulated for the next physical link.
*   **Resolution Protocols**:
    *   **ARP**: Resolves L3 (IPv4) → L2 (MAC).
    *   **NDP**: Resolves L3 (IPv6) → L2 (MAC).

[Image: Network-link-physical stack showing frame encapsulation]

---

## Framing Methods

Framing is the process of interpreting a physical-layer bitstream as a sequence of discrete frames.

### 1. Byte-Oriented Protocols (e.g., PPP)
Frames are viewed as a collection of bytes.
*   **Sentinel-Based**: Uses special characters to mark boundaries.
    *   **SYN**: Start of synchronization.
    *   **STX / ETX**: Start and End of text.
    *   **Byte Stuffing**: If a sentinel appears in the data, it is escaped (e.g., using a backslash).
*   **Byte Counting**: The header includes a field specifying the frame's length in bytes.
    *   **Failure Mode**: If the count field is corrupted, the receiver loses frame synchronization until the next sentinel.

[Image: Example of byte-oriented frame structure with STX/ETX]

### 2. Bit-Oriented Protocols (e.g., HDLC)
Frames are viewed as a collection of bits, independent of byte boundaries.
*   **Flag Sequence**: The distinguished bit pattern `01111110` marks both start and end.
*   **Bit Stuffing**:
    *   **Sender**: Inserts a `0` after every five consecutive `1`s in the payload.
    *   **Receiver**: If five `1`s arrive:
        *   Next bit `0`: Discard (it was stuffed).
        *   Next bit `1`: Check the following bit. 
            *   `0`: End of frame (`01111110`).
            *   `1`: Error (`01111111`).

[Image: HDLC frame format showing the flag sequence and bit stuffing]

### 3. Clock-Based Framing (e.g., SONET)
Used in high-speed fiber links.
*   **Soft Synchronization**: Boundaries are determined by physical layer timing rather than stuffing.
*   **STS-1 Frame**: 810 bytes (9 rows by 90 columns).
*   **Scrambling**: Payload is XORed with a 127-bit pattern to ensure sufficient 0-to-1 transitions for clock recovery.
*   **State Machine**: The receiver must see the sync pattern correctly $N$ times to achieve "lock" and $M$ misses to declare "out of sync."

[Image: SONET STS-1 frame structure grid]

---

## Error Detection and Correction

Due to thermal noise and interference, bits may be flipped.

### 1. Cyclic Redundancy Check (CRC)
The most powerful link-layer detection method, based on polynomial long division.
*   **Mechanics**:
    1.  Sender and receiver agree on a divisor polynomial $C(x)$ of degree $k$.
    2.  Sender appends $k$ zeros to the message $M(x)$ and divides by $C(x)$ using **Modulo-2 Arithmetic**.
    3.  The remainder is the CRC, which is appended to the message.
*   **Properties**:
    *   Detects all single and double-bit errors.
    *   Detects all odd numbers of errors (if $(x+1)$ is a factor).
    *   Detects any burst error shorter than $k$ bits.

[Image: CRC polynomial long division example]

### 2. Checksums and Parity
*   **Internet Checksum**: 16-bit 1's complement sum of all words. Efficient but weak (fails to detect certain swapped-byte errors).
*   **Parity Bit**: Single redundant bit to make the count of '1's even or odd. Detects single-bit errors only.
*   **Two-Dimensional Parity**: Arranges bits in a grid; detects all 1, 2, and 3-bit errors and some 4-bit errors.

[Image: 2D parity grid showing row and column parity bits]

### 3. Hamming Code (Forward Error Correction)
Used when the cost of retransmission is high (e.g., wireless or deep space).
*   **Hamming Distance ($d$)**: The number of bit positions in which two codewords differ.
*   **Error Detection**: Requires distance $d+1$ to detect $d$ errors.
*   **Error Correction**: Requires distance $2d+1$ to correct $d$ errors.

---

## Reliability & Retransmission (ARQ)

To handle lost or corrupted frames, the link layer uses **Automatic Repeat Request (ARQ)** schemes.

### 1. Stop-and-Wait
The simplest reliability mechanism.
*   **Mechanism**: Sender transmits one frame and waits for an **Acknowledgment (ACK)** before sending the next.
*   **Duplicate Detection**: Uses a **1-bit Sequence Number** ($0$ or $1$) to distinguish between a new frame and a retransmission of the previous one.
*   **Efficiency**: Very low on high **Bandwidth-Delay Product** links, as the pipe remains empty during the RTT.
    *   **Utilization ($U$)**: $U = \frac{T_{trans}}{T_{trans} + RTT}$

### 2. Sliding Window
Generalizes Stop-and-Wait by allowing multiple frames to be "in flight."
*   **SWS (Send Window Size)**: Max outstanding unacknowledged frames.
*   **RWS (Receive Window Size)**: Max out-of-order frames the receiver will buffer.
*   **Invariant**: $LFS - LAR \le SWS$ (Last Frame Sent - Last ACK Received).
*   **Sequence Number Constraint**: To avoid ambiguity between new frames and delayed retransmissions, $SWS < \frac{\text{MaxSeqNum} + 1}{2}$ (when $RWS = SWS$).

### 3. Retransmission Strategies
*   **Go-Back-N**: If a frame is lost, the sender retransmits **all** frames starting from the lost one. Receiver only buffers the next expected frame ($RWS=1$).
*   **Selective Repeat**: Sender only retransmits the specific frames that were lost. Receiver buffers out-of-order frames ($RWS > 1$) to improve efficiency.

## Related Topics
*   **[[Internet Protocol (IP)]]**: The primary implementation of the Network Layer.
*   **[[Forwarding Table]]**: The database used for local packet switching.
*   **[[OSI Layers]]**: The full 7-layer theoretical model.
