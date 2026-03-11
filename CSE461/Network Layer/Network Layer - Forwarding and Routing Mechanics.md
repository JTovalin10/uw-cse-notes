# Network Layer: Forwarding and Routing Mechanics

## Low-Level Primer: Local Action vs. Global Decision
A router performs two distinct functions:
1.  **Forwarding (Data Plane)**: The local process of moving a packet from an input port to the correct output port. This must be done in nanoseconds.
2.  **Routing (Control Plane)**: The network-wide process of calculating the best paths between all sources and destinations. This is done in milliseconds or seconds.

---

## 1. The Forwarding Table and LPM

A router makes decisions using a **[[Forwarding Table]]**. Because prefixes can overlap (e.g., `128.96.0.0/16` and `128.96.33.0/24`), routers use **Longest Prefix Match (LPM)**.

*   **Rule**: The packet is forwarded using the table entry that has the longest mask matching the destination IP.
*   **Default Route**: An entry with prefix `0.0.0.0/0` that matches everything. It is only used if no more specific match exists.

---

## 2. Address Resolution Protocol (ARP)

ARP bridges the gap between Layer 3 (IP) and Layer 2 (MAC).

*   **The Problem**: A router knows the Next-Hop IP, but the Ethernet hardware needs a MAC address to send the frame.
*   **The Mechanics**:
    1.  **Request**: The sender broadcasts: "Who has IP 192.168.1.1? Tell 192.168.1.2."
    2.  **Reply**: The owner of the IP unicasts its MAC address back.
    3.  **Caching**: Nodes store the IP $\to$ MAC mapping in an **ARP Cache** to avoid repeated broadcasts.

---

## 3. IP Fragmentation and Reassembly

Every link has a **[[Maximum Transmission Unit (MTU)]]** (e.g., 1500 bytes for Ethernet). If a packet exceeds the MTU of the next hop, the router must fragment it.

*   **Identification**: All fragments of the same datagram share a unique ID.
*   **Offset**: Specifies where in the original packet this fragment belongs (in 8-byte units).
*   **MF (More Fragments) Flag**: Set to `1` for all fragments except the last one.
*   **The Rule**: **Reassembly only happens at the Destination Host**. Intermediate routers do not reassemble, as it is computationally expensive and fragments might take different paths.

---

## 4. ICMP (Internet Control Message Protocol)

ICMP is the "companion" protocol to IP, used for error reporting and diagnostics.

*   **Echo Request/Reply**: The basis for **`ping`**.
*   **Time Exceeded**: Sent by a router when a packet's **TTL** reaches zero. Used by **`traceroute`** to map the network path.
*   **Destination Unreachable**: Sent when no route exists or a port is blocked.
*   **Path MTU Discovery**: Used to find the smallest MTU along a path to avoid fragmentation.

---

## 5. IP Tunneling

Tunneling allows one protocol to be encapsulated inside another, creating a "Virtual Link."
*   **Mechanism**: A router takes a complete IP packet and places it inside the payload of a *new* IP packet.
*   **Use Cases**:
    *   **[[Virtual Private Networks (VPN)]]**: Encrypting corporate traffic over the public Internet.
    *   **IPv6 over IPv4**: Moving IPv6 traffic through legacy routers.
    *   **Mobile IP**: Forwarding traffic from a home network to a mobile device's current location.

![[Screenshots/IP tunneling.png]]
