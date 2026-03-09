# Transmission Control Protocol (TCP)

**Transmission Control Protocol (TCP)** is a **Connection-Oriented**, **Reliable**, **Full-Duplex**, **Byte-Stream** transport protocol. It abstracts the underlying unreliable [[Datagram]] delivery of [[Internet Protocol (IP)]] into a logical bit-perfect pipe between two application processes. 

## Low-Level Primer: The Byte-Stream Model
*   **Byte-Stream Abstraction**: Unlike [[User Datagram Protocol (UDP)]], which is message-oriented, TCP views data as an unstructured sequence of bytes. The receiver's OS buffers these bytes and delivers them to the application exactly as sent, though not necessarily in the same-sized "chunks" as the original `write()` calls.
*   **Reliability through ARQ**: TCP uses **Positive Acknowledgment with Retransmission**. Every byte is assigned a **Sequence Number**. The receiver sends an **[[Acknowledgment (ACK)]]** indicating the *next* expected byte.
*   **Transmission Control Block (TCB)**: The complex data structure maintained by the OS for every active TCP connection, storing sequence numbers, window sizes, timers, and state.

## TCP Segment Format
A TCP header is typically **20 bytes** (without options).

| Field | Size | Purpose |
| :--- | :--- | :--- |
| **Source Port** | 16 Bits | Sending process identifier. |
| **Dest Port** | 16 Bits | Receiving process identifier ([[Ports]]). |
| **Sequence Number** | 32 Bits | The byte-stream index of the first data byte in this segment. |
| **Acknowledgment Number** | 32 Bits | Valid if ACK flag is set. The **Next Expected Byte** from the peer. |
| **Data Offset** | 4 Bits | Number of 32-bit words in the header (specifies where data begins). |
| **Flags (Control Bits)** | 9 Bits | `SYN`, `ACK`, `FIN`, `RST`, `PSH`, `URG`, `ECE`, `CWR`. |
| **Advertised Window** | 16 Bits | Used for **[[Flow Control]]**; tells sender how much buffer space is available. |
| **Checksum** | 16 Bits | Covers header, payload, and the IP **Pseudo-Header**. |
| **Urgent Pointer** | 16 Bits | Offset from sequence number for "urgent" data (rarely used). |

### Common Flags
*   **SYN**: Synchronize; used during connection establishment.
*   **ACK**: Acknowledgment field is valid.
*   **FIN**: Finish; sender has no more data.
*   **RST**: Reset; abort the connection due to error or lack of state.
*   **PSH**: Push; bypass receiver's buffer and deliver to app immediately.

---

## Connection Management

### The Three-Way Handshake (Establishment)
Used to synchronize **Initial Sequence Numbers (ISNs)** and exchange options like **MSS**.
1.  **Client → Server (SYN)**: Client chooses `ISN_c` and sends `SYN`.
2.  **Server → Client (SYN-ACK)**: Server acknowledges `ISN_c` (`ACK = ISN_c + 1`) and chooses `ISN_s`.
3.  **Client → Server (ACK)**: Client acknowledges `ISN_s` (`ACK = ISN_s + 1`). Data can now be attached.
*   **ISN Randomization**: ISNs are chosen randomly to prevent "off-path" sequence prediction attacks and avoid collisions with delayed segments from previous connection incarnations.

### Connection Termination (Four-Way Teardown)
TCP supports **Half-Close** semantics; one side can stop sending while still receiving.
1.  **A → B (FIN)**: Side A is done sending.
2.  **B → A (ACK)**: Acknowledges FIN.
3.  **B → A (FIN)**: Side B is done sending.
4.  **A → B (ACK)**: Final acknowledgment.
*   **TIME_WAIT State**: The active closer enters `TIME_WAIT` for $2 \times MSL$ (Maximum Segment Lifetime). This ensures the final ACK arrived at the peer and allows all "stray" segments to clear the network before the port is reused.

---

## Flow Control: The Sliding Window
TCP prevents a fast sender from overwhelming a slow receiver using an **Advertised Window** ($Win$).
*   **Flow Control Equation**: `LastByteSent - LastByteAcked <= AdvertisedWindow`
*   **Zero Window Probing**: If the receiver advertises $Win=0$, the sender periodically sends a 1-byte **Window Probe** to check if buffer space has opened up.
*   **Silly Window Syndrome**: Occurs when the receiver advertises tiny windows (e.g., 1 byte), causing massive overhead. 
    *   **Receiver Solution (Clark's Algorithm)**: Don't advertise a window until it reaches $1/2$ the buffer size or $1 \times MSS$.
    *   **Sender Solution (Nagle's Algorithm)**: Don't send tiny segments; buffer data until a full MSS is reached or an ACK arrives.

---

## Congestion Control
TCP treats the network as a "black box" and probes for capacity using the **Congestion Window (cwnd)**. 
*   **The Transmission Limit**: `Effective_Window = min(AdvertisedWindow, CongestionWindow)`

### The Standard Phases (TCP Reno)
1.  **Slow Start**: Start with $cwnd = 1 \text{ MSS}$. For every ACK received, $cwnd = cwnd + 1 \text{ MSS}$ (Exponential growth).
2.  **Congestion Avoidance**: When $cwnd \ge ssthresh$, growth becomes linear: $cwnd = cwnd + 1 \text{ MSS}$ per **RTT**.
3.  **Fast Retransmit**: If the sender receives **3 Duplicate ACKs**, it assumes the segment was lost and resends it *before* the timer expires.
4.  **Fast Recovery**: After a Fast Retransmit, $ssthresh = cwnd / 2$ and $cwnd = ssthresh$. It skips Slow Start and resumes linear growth.

### Retransmission Timeout (RTO) Calculation
*   **Jacobson/Karels Algorithm**:
    1.  `SampleRTT` = time between segment sent and ACK received.
    2.  `EstimatedRTT = (1 - \alpha) \times EstimatedRTT + \alpha \times SampleRTT`
    3.  `DevRTT = (1 - \beta) \times DevRTT + \beta \times |SampleRTT - EstimatedRTT|`
    4.  `RTO = EstimatedRTT + 4 \times DevRTT`
*   **Karn's Algorithm**: Never update `EstimatedRTT` based on segments that have been retransmitted, as it is impossible to know which transmission triggered the ACK.

---

## TCP Options & Extensions
*   **MSS (Maximum Segment Size)**: Default is often 1460 bytes (Ethernet).
*   **Window Scale**: Allows the 16-bit window field to be shifted left (up to 14 bits), enabling windows up to 1 GB for high **Bandwidth-Delay Product (BDP)** links.
*   **SACK (Selective ACK)**: Allows receiver to specify multiple non-contiguous byte ranges received, enabling efficient recovery of multiple lost packets.
