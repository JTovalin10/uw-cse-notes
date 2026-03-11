# Transport Layer: Transmission Control Protocol (TCP)

## Low-Level Primer: The Reliable Byte-Stream
**[[Transmission Control Protocol (TCP)|TCP]]** is a connection-oriented, full-duplex, reliable transport protocol. It abstracts the underlying unreliable, packet-switched network provided by **[[Internet Protocol (IP)|IP]]** into a logical, bit-perfect pipe between two application processes.

*   **Byte-Stream Model**: TCP does not preserve application message boundaries. It views data as a continuous stream of bytes.
*   **End-to-End Argument**: TCP implements reliability at the endpoints (Hosts), following the principle that complex functions should not be placed in the core network.
*   **Connection State**: The OS maintains a **Transmission Control Block (TCB)** for every active connection, storing sequence numbers, window sizes, and timers.

---

## 1. TCP Segment Format

A standard TCP header is **20 bytes** long (without options).

| Field | Size | Purpose |
| :--- | :--- | :--- |
| **Source/Dest Port** | 16 Bits each | Process-to-process demultiplexing. |
| **Sequence Number** | 32 Bits | The byte-stream index of the first data byte in this segment. |
| **ACK Number** | 32 Bits | The **Next Expected Byte** from the peer (cumulative ACK). |
| **Data Offset** | 4 Bits | Header length in 32-bit words. |
| **Flags** | 9 Bits | `SYN`, `ACK`, `FIN`, `RST`, `PSH`, `URG`. |
| **Advertised Window**| 16 Bits | Used for **[[Flow Control]]**. |
| **Checksum** | 16 Bits | Covers header, payload, and IP **Pseudo-Header**. |

---

## 2. Connection Management

### Three-Way Handshake (Establishment)
Used to synchronize **Initial Sequence Numbers (ISNs)** and exchange options (e.g., MSS).
1.  **Client $\to$ Server (SYN)**: "I want to connect. My ISN is $X$."
2.  **Server $\to$ Client (SYN-ACK)**: "Acknowledged $X$. My ISN is $Y$."
3.  **Client $\to$ Server (ACK)**: "Acknowledged $Y$. Let's send data."

### Four-Way Teardown (Termination)
TCP supports **Half-Close**; one side can stop sending while still receiving.
1.  **Node A $\to$ B (FIN)**: "I have no more data to send."
2.  **Node B $\to$ A (ACK)**: "Acknowledged." (B can still send data to A).
3.  **Node B $\to$ A (FIN)**: "I am also done."
4.  **Node A $\to$ B (ACK)**: Final acknowledgment.
*   **TIME_WAIT**: The active closer waits for $2 \times MSL$ (Maximum Segment Lifetime) to ensure the final ACK reached the peer and old segments clear the network.

---

## 3. Flow Control: The Sliding Window

TCP prevents a fast sender from overwhelming a slow receiver's buffer.

*   **Advertised Window ($W$r)**: The receiver specifies how much buffer space is available in every ACK.
*   **The Constraint**: `LastByteSent - LastByteAcked <= Wr`.
*   **Zero Window Probing**: If $W_r=0$, the sender periodically sends a 1-byte probe to see if the window has reopened.

### Silly Window Syndrome
Occurs when the receiver advertises tiny windows (e.g., 1 byte), causing high overhead.
*   **Nagle's Algorithm (Sender-side)**: Delay sending small segments until a full **MSS** is reached or an ACK for previous data arrives.
*   **Clark's Algorithm (Receiver-side)**: Do not increase the advertised window until it can be increased by a full MSS or $1/2$ the total buffer size.

---

## 4. End-to-End Issues

*   **RTT Variance**: Unlike the link layer, TCP RTTs vary from <1ms to >500ms. Retransmission timers must be **Adaptive**.
*   **Reordering**: IP packets may take different paths and arrive out of order. TCP uses the Receive Window to buffer out-of-order segments and reassembles them before delivery to the application.
*   **Segment Lifetime**: TCP assumes packets have a finite **MSL** (typically 120s). The 32-bit sequence number space is large enough to prevent "wrap-around" within one MSL on most links.

![[Screenshots/TCP Connection Release.png]]


![[Screenshots/Three-Way Handshake.png]]
