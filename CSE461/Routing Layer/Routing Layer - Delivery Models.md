# Routing Layer: Delivery Models

## Low-Level Primer: Addressing Strategies
Modern routing supports multiple ways of delivering a packet to one or more recipients based on the **Destination IP Address**.

---

## 1. Unicast
*   **Definition**: One-to-One.
*   **Mechanism**: A packet is delivered to exactly one interface identified by a unique IP address. 
*   **Usage**: The vast majority of Internet traffic (Web browsing, SSH, standard API calls).

---

## 2. Broadcast
*   **Definition**: One-to-All.
*   **Mechanism**: A packet is delivered to **all** nodes on a local network segment.
*   **Constraint**: Broadcast packets are **not** forwarded by routers (limited to the local subnet).
*   **Usage**: ARP requests, DHCP discovery.

---

## 3. Multicast
*   **Definition**: One-to-Many (or Many-to-Many).
*   **Mechanism**: A packet is delivered to a subset of nodes that have explicitly "Joined" a group address.
*   **Network Role**: Routers are responsible for replicating packets at branch points in the distribution tree.
*   **Usage**: Video streaming (IPTV), financial data feeds, software updates for many machines.

---

## 4. Anycast
*   **Definition**: One-to-Nearest.
*   **Mechanism**: Multiple physically distinct nodes share the **same** IP address. Standard routing protocols (BGP/OSPF) route the packet to the node that is mathematically "closest" (lowest cost).
*   **Benefit**: Provides automatic load balancing and high availability. If the closest node fails, routing protocols automatically redirect traffic to the next nearest member.
*   **Usage**: DNS root servers, Content Delivery Networks (**[[CDN]]**).

[Image: Comparison diagram showing packet flow for Unicast, Multicast, and Anycast]
