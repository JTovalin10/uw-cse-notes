# Internet Protocol Version 4 (IPv4)

**IPv4** is the foundational protocol of the Internet, providing a 32-bit **Best-Effort** datagram delivery service. It is designed to be "unreliable" in that it does not guarantee delivery, ordering, or duplicate protection, leaving those tasks to the [[Transport]] layer.

## Low-Level Primer: Addressing and CIDR
*   **Address Format**: A 32-bit integer typically expressed in **Dotted-Quad** notation (e.g., `128.96.33.81`), representing 4 octets ($0$–$255$).
*   **Hierarchy**: Addresses are split into a **Network Prefix** (identifies the network/subnet) and a **Host ID** (identifies the specific interface).
*   **CIDR (Classless Interdomain Routing)**: Replaced the rigid "Class A/B/C" system. It uses **Slash Notation** (e.g., `/24`) to specify the length of the prefix.
    *   **Subnet Mask**: A bitmask where '1's represent the network portion. A `/24` prefix corresponds to a mask of `255.255.255.0`.
*   **Address Space**: $2^{32} \approx 4.3$ billion addresses.

---

## The IPv4 Header format
A standard IPv4 header is **20 bytes** long.

| Field | Size | Purpose |
| :--- | :--- | :--- |
| **Version** | 4 Bits | Set to **4**. |
| **HLen** | 4 Bits | Header Length in 32-bit words (usually 5). |
| **TOS / DiffServ** | 8 Bits | Used for **[[Quality of Service (QoS)]]** markings. |
| **Length** | 16 Bits | Total length of the datagram (Header + Data) in bytes. |
| **Ident** | 16 Bits | Unique ID used for **Fragmentation and Reassembly**. |
| **Flags** | 3 Bits | `DF` (Don't Fragment) and `MF` (More Fragments). |
| **Offset** | 13 Bits | Position of this fragment relative to the start of the original datagram (in 8-byte units). |
| **TTL** | 8 Bits | **[[Time to Live (TTL)]]**; hop limit to prevent infinite routing loops. |
| **Protocol** | 8 Bits | Demultiplexing key for the next layer (e.g., 6 for **TCP**, 17 for **UDP**). |
| **Checksum** | 16 Bits | 1's complement sum of the **Header only**. Recalculated at every hop because TTL changes. |
| **Source IP** | 32 Bits | IP address of the originator. |
| **Dest IP** | 32 Bits | IP address of the intended recipient. |

[Image: IPv4 header format showing bit-level field alignment]

---

## Key Protocols and Mechanisms

### 1. Fragmentation and Reassembly
When a packet is too large for a link's **MTU** (Maximum Transmission Unit), the router splits it.
*   **Fragment Offset**: Each fragment carries its offset from the original start.
*   **Reassembly**: Occurs **only at the destination host**, never at intermediate routers, to minimize router processing load.

### 2. ARP (Address Resolution Protocol)
Maps a 32-bit **IP Address** to a 48-bit **MAC Address** for delivery over a local link.
*   **Mechanism**: The host broadcasts an **ARP Request** ("Who has IP X?"); the owner replies with its MAC. Results are stored in an **ARP Cache**.

### 3. DHCP (Dynamic Host Configuration Protocol)
Automates the assignment of IP addresses to hosts.
*   **The 4-Step Process (DORA)**:
    1.  **Discover**: Client broadcasts to find a server.
    2.  **Offer**: Server proposes an IP and lease time.
    3.  **Request**: Client accepts the offer.
    4.  **Acknowledge**: Server confirms the lease.

### 4. ICMP (Internet Control Message Protocol)
The "companion" protocol used for error reporting and diagnostics.
*   **Echo Request/Reply**: Used by **`ping`**.
*   **TTL Exceeded**: Used by **`traceroute`** to discover the path to a destination.
*   **Destination Unreachable**: Sent by routers when a route or port is unavailable.

### 5. NAT (Network Address Translation)
A workaround for IPv4 address exhaustion.
*   **Function**: Allows an entire private network (e.g., `192.168.x.x`) to share a single public IP address by mapping internal IP/Port tuples to external ones.

## Related Topics
*   **[[IPv6]]**: The 128-bit successor.
*   **[[Subnetting]]**: The process of dividing a network into smaller pieces.
*   **[[Forwarding Table]]**: How routers use the IP header to make decisions.
