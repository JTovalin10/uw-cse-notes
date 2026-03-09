# Internet Protocol Version 6 (IPv6)

**IPv6** is the modern successor to **[[IPv4]]**, designed to solve the problem of address exhaustion and to streamline router processing. It replaces the 32-bit address space with a **128-bit** space and simplifies the header to improve performance in high-speed backbone networks.

## Low-Level Primer: The 128-bit Model
*   **Address Space**: $2^{128} \approx 3.4 \times 10^{38}$ addresses. This is roughly 667 quadrillion addresses per square millimeter of the Earth's surface.
*   **Notation**: Expressed in 8 groups of 4 hex digits (e.g., `47CD:1234:4422:AC02:0022:1234:A456:0124`).
    *   **Compaction**: Leading zeros can be omitted. Consecutive groups of zeros can be replaced by `::` (only once per address). 
        *   Example: `FF02:0:0:0:0:0:0:1` becomes `FF02::1`.
*   **Hierarchical Allocation**: Addresses are allocated based on **Provider-Based Addressing**. A provider receives a prefix and assigns longer sub-prefixes to its customers, facilitating massive route aggregation.

---

## IPv6 Header format
The IPv6 header is a fixed **40-byte** structure. It is larger but simpler than IPv4, removing fields that required heavy router processing (like the Checksum).

| Field | Size | Purpose |
| :--- | :--- | :--- |
| **Version** | 4 Bits | Set to **6**. |
| **Traffic Class** | 8 Bits | Used for **[[Quality of Service (QoS)]]** (DiffServ). |
| **Flow Label** | 20 Bits | Identifies a stream of packets requiring special handling (e.g., real-time). |
| **Payload Len** | 16 Bits | Size of the data (and any extension headers) in bytes. |
| **Next Header** | 8 Bits | Identifies the type of header immediately following (e.g., TCP, UDP, or an Extension Header). |
| **Hop Limit** | 8 Bits | Equivalent to the IPv4 **TTL**; decremented at each hop. |
| **Source Addr** | 128 Bits | The 16-byte address of the originator. |
| **Dest Addr** | 128 Bits | The 16-byte address of the recipient. |

[Image: IPv6 header format showing the streamlined 40-byte structure]

### Extension Headers
Instead of variable-length "Options" in the main header (which slow down routers), IPv6 uses a chain of **Extension Headers**.
*   **Chaining**: The `Next Header` field points to the first extension (e.g., Routing, Fragmentation, or Security). That extension then has its own `Next Header` field pointing to the next one or the transport layer.
*   **Optimization**: Most extensions are only processed by the **Destination Host**, not intermediate routers.

---

## Core Features and Enhancements

### 1. Autoconfiguration (SLAAC)
**Stateless Address Autoconfiguration** allows a host to configure itself without a [[DHCP]] server.
*   **Mechanism**: The host generates a **Link-Local** address, sends a **Router Solicitation**, receives a **Router Advertisement** containing the network prefix, and appends its own Interface ID (often derived from the MAC address).

### 2. Transition Mechanisms
Since the entire Internet cannot switch overnight, three strategies are used:
*   **Dual Stack**: Nodes run both IPv4 and IPv6 protocols simultaneously.
*   **Tunneling**: Encapsulating IPv6 packets inside IPv4 packets to traverse legacy networks.
*   **Translation (NAT64)**: Actively converting headers between the two versions (used for IPv6-only hosts to reach IPv4-only services).

### 3. Anycast Addressing
A new address type where a packet is delivered to the **closest** member of a group (defined by routing distance). Useful for distributed services like DNS root servers and CDNs.

### 4. Removal of Checksum
Because modern link-layers (Ethernet) and transport-layers (TCP/UDP) have their own error detection, IPv6 removed the header checksum to save router CPU cycles.

---

## Addressing Categories

| Type | Prefix (Binary/Hex) | Purpose |
| :--- | :--- | :--- |
| **Global Unicast** | `001` (Hex `2xxx` or `3xxx`) | Standard Internet routable addresses. |
| **Link-Local** | `1111 1110 10` (Hex `FE80::/10`) | Used for communication on a single local link; not routed. |
| **Multicast** | `1111 1111` (Hex `FFxx::/8`) | Replaces IPv4 broadcast; used for one-to-many. |
| **Loopback** | `::1/128` | Equivalent to `127.0.0.1`. |

## Related Topics
*   **[[IPv4]]**: The legacy predecessor.
*   **[[NDP (Neighbor Discovery Protocol)]]**: The IPv6 replacement for ARP.
*   **[[IPsec]]**: Built-in security requirements for IPv6.
*   **[[Subnetting]]**: Still used, though typically on a fixed `/64` boundary for hosts.
