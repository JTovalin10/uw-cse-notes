# Network Layer: Mobility

## Low-Level Primer: Identifier vs. Locator
In standard IP networking, an IP address serves two conflicting roles:
1.  **Identifier**: Who is the host? (Used by the Transport layer).
2.  **Locator**: Where is the host? (Used by the Network layer for routing).

When a host moves between networks, its Locator must change to remain routable, but changing its Identifier would break existing TCP connections. **Mobile IP** solves this by decoupling these two roles.

---

## 1. Mobile IP Components

*   **Home Address**: A permanent, stable IP address assigned to the host from its "Home" network.
*   **Care-of Address (CoA)**: A temporary IP address assigned by the "Foreign" network the host is currently visiting.
*   **Home Agent (HA)**: A router in the home network that intercepts packets for the mobile host and tunnels them to its current location.
*   **Foreign Agent (FA)**: A router in the visited network that assists the mobile host in obtaining a CoA and receiving tunneled packets.

---

## 2. Packet Delivery Mechanics

### Indirect Routing (Triangle Routing)
1.  **Sender** sends a packet to the host's **Home Address**.
2.  **Home Agent** intercepts the packet.
3.  **Tunneling**: The HA encapsulates the packet inside a new IP packet addressed to the **Care-of Address**.
4.  **Delivery**: The packet arrives at the FA (or the host), is de-encapsulated, and delivered.
5.  **Reverse Path**: The mobile host sends replies directly to the original sender using its Home Address as the source.

[Image: Triangle routing diagram showing paths through the Home Agent]

### Direct Routing (Route Optimization)
To avoid the inefficient "Triangle" path, the sender can learn the host's current CoA.
*   **Binding Cache**: The sender stores the mapping `[Home Address] -> [Care-of Address]`.
*   **Update**: When the host moves, it sends a **Binding Update** to all active correspondents.

---

## 3. Mobility in IPv6

IPv6 simplifies mobility by making many of these features native to the protocol.
*   **No Foreign Agents**: Hosts can obtain a CoA directly via autoconfiguration (SLAAC).
*   **Direct Delivery**: The Home Address is carried in a new **Destination Option** header, allowing the Transport layer to maintain the identifier while the Network layer uses the CoA locator in the main header.
