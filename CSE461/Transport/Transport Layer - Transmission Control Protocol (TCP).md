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
1.  **Client (CLOSED $\to$ SYN_SENT)**: Sends SYN, seq=$X$.
2.  **Server (LISTEN $\to$ SYN_RCVD)**: Receives SYN, sends SYN-ACK, seq=$Y$, ack=$X+1$.
3.  **Client (SYN_SENT $\to$ ESTABLISHED)**: Receives SYN-ACK, sends ACK, ack=$Y+1$.
4.  **Server (SYN_RCVD $\to$ ESTABLISHED)**: Receives ACK.

### Four-Way Teardown (Termination)
TCP supports **Half-Close**; one side can stop sending while still receiving.
1.  **Active Closer (ESTABLISHED $\to$ FIN_WAIT_1)**: Sends FIN.
2.  **Passive Closer (ESTABLISHED $\to$ CLOSE_WAIT)**: Receives FIN, sends ACK.
3.  **Active Closer (FIN_WAIT_1 $\to$ FIN_WAIT_2)**: Receives ACK.
4.  **Passive Closer (CLOSE_WAIT $\to$ LAST_ACK)**: Sends FIN.
5.  **Active Closer (FIN_WAIT_2 $\to$ TIME_WAIT)**: Receives FIN, sends ACK.
6.  **Passive Closer (LAST_ACK $\to$ CLOSED)**: Receives ACK.
7.  **Active Closer (TIME_WAIT $\to$ CLOSED)**: Wait $2 \times MSL$ (Maximum Segment Lifetime) to ensure the final ACK reached the peer and old segments clear the network.

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

## Related
- [[CSE333/Networking/TCP Sockets|Implementation: TCP Sockets in C]]
