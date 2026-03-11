# Overlay Networks: Fundamental Mechanics

## Low-Level Primer: Defining Overlays
**Overlay Networks** represent a form of **Network Virtualization** where a logical network topology is constructed on top of an underlying physical network (typically the **Internet**). In this model, overlay nodes function as application-specific "routers" that make forwarding decisions based on high-level identifiers (e.g., URLs, file hashes, or XML queries) rather than standard **IP** addresses.

---

## Fundamental Mechanics of Overlays

*   **Virtualization**: The process of building a virtual network using logical resources (abstract nodes and links) on top of physical hardware resources.
*   **Tunneling (Encapsulation)**: The core mechanism for connecting overlay nodes.
    *   **Outer Header (OHdr)**: Used by physical routers to forward the packet across the underlying network. These routers are unaware of the overlay's existence.
    *   **Inner Header (IHdr)**: Used by overlay nodes to make application-specific forwarding decisions.
    *   **Edge Processing**: Overlay nodes understand both headers, while intermediate physical nodes only interpret the **OHdr**.
*   **Logical Links**: A "link" in an overlay is actually a multi-hop path in the underlying network, treated as a single hop by the overlay protocol.
*   **Address Spaces**: Overlay nodes possess two distinct identifiers:
    1.  An **Underlying Address** (e.g., a 32-bit [[IPv4]] address).
    2.  An **Overlay Address** (e.g., a URL or a content-based hash).

![[Source routing in a switched network.png]]
*Figure: Overlay network layered on top of a physical network*

![[three ways to handle headers for source routing.png]]
*Figure: Overlay nodes tunneling through physical nodes, showing Inner (IHdr) and Outer (OHdr) header encapsulation*
