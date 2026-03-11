# Network Layer: IPv6

## Low-Level Primer: Solving Address Exhaustion
**[[IPv6]]** is the modern successor to **[[IPv4]]**, designed to replace the 32-bit address space with a **128-bit** space. It simplifies the core header to improve routing performance and removes redundant features like the header checksum (delegating error detection to the Link and Transport layers).

---

## 1. The 128-bit Address Model

*   **Address Space**: $2^{128}$ addresses ($\approx 3.4 \times 10^{38}$).
*   **Notation**: Eight groups of four hex digits separated by colons (e.g., `2001:0db8:0000:0000:0000:ff00:0042:8329`).
    *   **Compaction**: Omit leading zeros. Replace consecutive groups of zeros with `::` (once per address).
    *   Example: `2001:db8::ff00:42:8329`.
*   **Provider-Based Addressing**: Addresses are allocated hierarchically. A provider receives a short prefix (e.g., `/32`) and delegates longer prefixes to customers (e.g., `/48` or `/56`). This enables massive **Route Aggregation**.

---

## 2. IPv6 Header Format (The "Clean" Header)

The IPv6 header is a fixed **40 bytes** long. It removes variable-length options from the base header to ensure intermediate routers can process packets at hardware line-rate.

| Field | Size | Description |
| :--- | :--- | :--- |
| **Version** | 4 Bits | Set to `6`. |
| **Traffic Class** | 8 Bits | Used for QoS (DiffServ). |
| **Flow Label** | 20 Bits | Identifies a stream of packets for special handling. |
| **Payload Len** | 16 Bits | Length of data + extension headers. |
| **Next Header** | 8 Bits | Points to the first **Extension Header** or the Transport protocol (TCP/UDP). |
| **Hop Limit** | 8 Bits | Equivalent to IPv4 TTL. |
| **Source/Dest Addr**| 128 Bits each | Full 16-byte IPv6 addresses. |

### Extension Headers
Unlike IPv4 options, Extension Headers are "chained" after the main header. Most (like Fragmentation or Routing) are only processed by the **Destination Host**, reducing the burden on routers.

---

## 3. Core Enhancements

### Autoconfiguration (SLAAC)
**Stateless Address Autoconfiguration** allows a host to join a network without a DHCP server.
1.  **Link-Local Address**: Host generates a temporary address starting with `fe80::`.
2.  **Solicitation**: Host sends a Router Solicitation message.
3.  **Advertisement**: Router replies with the network prefix (e.g., `/64`).
4.  **Finalization**: Host appends its own **Interface ID** (often derived from its MAC address) to the prefix.

### Anycast Addressing
A packet sent to an Anycast address is delivered to the **closest** member of a group (measured by routing metrics). Standard for DNS roots and CDNs.

---

## 4. Transition Strategies

*   **Dual Stack**: Nodes run both IPv4 and IPv6 protocols simultaneously.
*   **Tunneling**: Encapsulating IPv6 packets inside IPv4 packets to traverse legacy networks.
*   **NAT64**: A translation box that maps IPv6 addresses to IPv4 addresses, allowing IPv6-only hosts to communicate with the legacy Internet.

![[Screenshots/Ipv6 Fragmentaton extension header.png]]


![[Screenshots/IPv6 provider-based unicast address.png]]
