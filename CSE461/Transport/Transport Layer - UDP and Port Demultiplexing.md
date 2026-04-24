# Transport Layer: UDP and Port Demultiplexing

## Low-Level Primer: Process-to-Process Delivery
While the Network Layer (IP) delivers packets to a specific host, the Transport Layer is responsible for delivering that data to the correct **Process** running on that host. This is achieved through **Demultiplexing** using **Ports**.

---

## 1. User Datagram Protocol (UDP)

UDP is a minimalist, connectionless transport protocol that provides a thin wrapper around IP.

### Characteristics
*   **Unreliable**: No handshakes, no ACKs, no retransmissions. Packets can be lost, duplicated, or reordered.
*   **Message-Oriented**: Preserves application-level message boundaries. One `send()` call equals exactly one UDP datagram.
*   **No Control**: No flow control or congestion control. UDP sends at the rate the application demands.

### UDP Header Format
A fixed **8-byte** overhead.
1.  **Source Port** (16 bits): Optional; used for replies.
2.  **Dest Port** (16 bits): The demultiplexing key.
3.  **Length** (16 bits): Total length of header + payload.
4.  **Checksum** (16 bits): 1's complement sum of the segment and an **IP Pseudo-Header** (detects misdelivery). Mandatory in IPv6.

---

## 2. Port Mechanics and Classification

A **Port** is a 16-bit identifier ($0$ to $65535$) that acts as a logical communication endpoint (a "mailbox").

### The Demultiplexing 5-Tuple
To uniquely identify a flow, the OS uses five fields:
`[Source IP, Source Port, Dest IP, Dest Port, Protocol]`

### IANA Port Ranges
*   **Well-Known Ports (0–1023)**: Reserved for core system services (e.g., HTTP: 80, DNS: 53, SSH: 22). Binding often requires root privileges.
*   **Registered Ports (1024–49151)**: Used by user applications (e.g., Databases, Game servers).
*   **Dynamic/Ephemeral Ports (49152–65535)**: Temporary ports assigned by the OS to clients when initiating a connection.

---

## 3. Why Use UDP?

*   **Low Latency**: No handshake overhead. Ideal for VoIP, Gaming, and Live Streaming where old data is useless.
*   **Simplicity**: Low per-packet overhead (8B vs 20B+ for TCP). Good for single-packet queries like **DNS**.
*   **Multicast/Broadcast**: UDP is compatible with one-to-many delivery, which TCP's connection model cannot support.
*   **Control**: Applications that want to implement their own custom reliability (e.g., **[[QUIC]]**, **[[RTP]]**) use UDP as a substrate.

![[Screenshots/UDP header.png]]
