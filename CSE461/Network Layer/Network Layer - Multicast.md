# Network Layer: Multicast

## Low-Level Primer: One-to-Many Efficiency
**Multicast** is a delivery model where a sender transmits a single packet to a **Group Address**, and the network infrastructure (routers) is responsible for replicating that packet only when paths diverge. This is significantly more efficient than **Unicast** (sending $N$ copies to $N$ receivers) or **Broadcast** (sending to everyone).

---

## 1. Multicast Group Management

Hosts must signal their interest in a multicast stream to their local router.

*   **IGMP (Internet Group Management Protocol)**: Used by IPv4 hosts.
*   **MLD (Multicast Listener Discovery)**: Used by IPv6 hosts.
*   **Mechanics**: A host sends a "Join" message for a specific group. The router periodically "polls" the local segment to see if any members are still active. If no one responds, the router stops forwarding that group's traffic.

---

## 2. Multicast Addressing

### IPv4 Class D space
*   Range: `224.0.0.0` to `239.255.255.255`.
*   The first 4 bits are fixed (`1110`), leaving 28 bits for the group ID.

### Mapping IP to Ethernet MAC
Ethernet supports multicast at the hardware level using the prefix `01:00:5E`.
*   **The Conflict**: Ethernet only reserved **23 bits** for multicast mapping. Since an IPv4 group has **28 bits**, the high-order 5 bits are discarded.
*   **Consequence**: 32 different IP multicast groups map to the same MAC address. The IP layer at the host must perform final filtering to discard unwanted packets.

---

## 3. Multicast Routing

Routers must build a **Multicast Distribution Tree** to deliver packets to all members.

### Shared Tree vs. Source-Specific Tree
*   **Shared Tree**: One tree for the entire group, rooted at a **Rendezvous Point (RP)**. All senders send to the RP.
*   **Source-Specific Tree**: A separate tree rooted at every individual sender. Provides more optimal paths but requires more state in routers.

### Protocols
*   **DVMRP (Distance Vector Multicast Routing Protocol)**: Uses **Flood-and-Prune**. It floods the first packet to the entire network, then "prunes" branches that have no interested listeners.
*   **PIM-SM (Protocol Independent Multicast - Sparse Mode)**: The modern standard. It is "Sparse" because routers must **explicitly join** a group; there is no initial flooding. It works with any underlying unicast protocol (OSPF, BGP).

---

## 4. Service Models

*   **ASM (Any-Source Multicast)**: The original model where any host can send to a group.
*   **SSM (Source-Specific Multicast)**: The receiver specifies both the Group address and the **Source IP**. This simplifies routing and improves security by preventing unauthorized senders from injecting traffic into the group.

[Image: Diagram comparing Unicast, Broadcast, and Multicast replication points]
