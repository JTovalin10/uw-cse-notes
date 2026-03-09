# User Datagram Protocol (UDP)

The **User Datagram Protocol (UDP)** is a minimalist, **Connectionless** transport protocol that provides a "best-effort" delivery model. It is effectively a thin wrapper around [[Internet Protocol (IP)]], extending host-to-host delivery into **Process-to-Process** communication using [[Ports]].

## Technical Characteristics

*   **Unreliable Delivery**: UDP provides no guarantees for message arrival, ordering, or duplicate protection. Segments may be lost, reordered, or duplicated without notification.
*   **Connectionless Nature**: No handshake is required before data transmission. Senders can transmit at any time without verifying receiver state.
*   **Message-Oriented (Datagrams)**: Preserves application-level message boundaries. Each `send()` call results in exactly one UDP segment.
*   **No Congestion/Flow Control**: UDP does not regulate transmission rates. Applications can transmit as fast as the network or hardware allows, often leading to packet loss at bottlenecks.
*   **Maximum Payload**: Calculated as $65535 \text{ bytes (Max IP Packet)} - 8 \text{ bytes (UDP Header)} - 20 \text{ bytes (Min IP Header)} = 65507 \text{ bytes}$.

## UDP Header Structure

The UDP header is a fixed **8-byte** overhead added to every segment:

| Field | Size | Function |
| :--- | :--- | :--- |
| **Source Port** | 16 Bits | Identifies the sending process (Optional; set to 0 if no reply is expected). |
| **Dest Port** | 16 Bits | The demultiplexing key used to deliver the segment to the correct destination process. |
| **Length** | 16 Bits | Total length of the UDP segment (Header + Payload) in bytes. |
| **Checksum** | 16 Bits | A 16-bit 1's complement sum of the segment and a **Pseudo-Header**. |

[Image: UDP header format showing the four 16-bit fields]

### Checksum & The Pseudo-Header
To detect misdelivery (packets reaching the wrong host due to IP-layer corruption), the UDP checksum includes a **Pseudo-Header** containing fields from the IP header:
*   **Source IP Address**
*   **Destination IP Address**
*   **Zero-Padding (8 bits)**
*   **Protocol Number (17 for UDP)**
*   **UDP Length**

**Calculation**: The checksum is the 16-bit 1's complement sum of all 16-bit words in the segment plus the pseudo-header.
*   **IPv4**: Checksum is optional (set to 0 if unused).
*   **IPv6**: Checksum is **Mandatory**.

## Use Cases & Applications

*   **Low Latency Requirement**: **VoIP**, **Streaming Media**, and **Online Gaming** prioritize immediate delivery over reliability. Late data is discarded by the application.
*   **Simple Request-Response**: [[DNS]] and [[SNMP]] use UDP to avoid the overhead of [[Transmission Control Protocol (TCP)]] handshakes for single-packet queries.
*   **Network Bootstrapping**: **DHCP** uses UDP because the client lacks an IP address and must rely on broadcast, which TCP does not support.
*   **One-to-Many Delivery**: UDP supports **IP Multicast** and **Broadcast**, which are fundamentally incompatible with TCP's point-to-point connection model.

## UDP vs. TCP Comparison

| Feature | UDP | [[Transmission Control Protocol (TCP)\|TCP]] |
| :--- | :--- | :--- |
| **Reliability** | Best-effort | Reliable (ACKs/Retransmits) |
| **Connection State** | Connectionless | Stateful (Handshake) |
| **Data Stream** | Discrete Datagrams | Continuous Byte Stream |
| **Overhead** | 8 Bytes | 20+ Bytes |
| **Control** | None | Flow & Congestion Control |
