# Network Layer & The IP Model

The **Network Layer** (Layer 3) provides the "Narrow Waist" of the Internet architecture. Its primary objective is to facilitate **Internetworking**—connecting heterogeneous link-layer technologies (Ethernet, Wi-Fi, 4G/5G) into a single, logical, end-to-end communication system.

## Low-Level Primer: The Internetworking Principle
*   **Heterogeneity**: The network layer abstracts away the differences in frame formats, MTUs, and addressing schemes of underlying [[Link Layer]] technologies.
*   **Scalability**: Unlike the Link Layer, which relies on flat MAC addresses and broadcasting, the Network Layer uses **Hierarchical Addressing** to scale to billions of nodes.
*   **End-to-End Principle**: A foundational design philosophy stating that complex functionality (reliability, congestion control) should be implemented at the network endpoints, while the core network remains as simple and "dumb" as possible.
*   **The Hourglass Model**: IP is the universal "narrow waist" through which all application data must pass, regardless of the physical medium or the high-level application.

[Image: The hourglass model of the Internet architecture showing IP as the central layer]

---

## Network Service Models

There are two fundamental approaches to network-layer delivery:

### 1. Datagram Model (Connectionless)
The model used by the **Internet Protocol (IP)**.
*   **Mechanics**: Every packet is treated as an independent unit and contains the full **Destination IP Address**. 
*   **Forwarding**: Routers maintain a **Forwarding Table**. Upon receiving a packet, the router performs a lookup and sends it to the **Next Hop**.
*   **Properties**:
    *   No setup phase; first packet can be sent immediately.
    *   Robust to failures; if a link goes down, routers can route around it per-packet.
    *   No state is maintained in the network for individual flows.

[Image: Datagram forwarding showing independent packets traversing a mesh of routers]

### 2. Virtual Circuit (VC) Model (Connection-Oriented)
The model used by legacy technologies like **ATM** and modern **MPLS**.
*   **Mechanics**: A logical connection is established *before* data is sent.
*   **VCI (Virtual Circuit Identifier)**: Instead of a full address, packets carry a short, local VCI. Routers swap this ID at every hop (**Label Switching**).
*   **Properties**:
    *   Requires a **Setup Phase** (Signaling).
    *   Routers maintain **State** for every active connection.
    *   Enables **Quality of Service (QoS)** and bandwidth guarantees because the path is known and fixed.

---

## Layering and Encapsulation

The network follows the **OSI Model** (7 layers) or the **TCP/IP Model** (4-5 layers).

| Layer | PDU Name | Function |
| :--- | :--- | :--- |
| **Application** | Message | User-facing data (HTTP, SMTP). |
| **Transport** | Segment / Datagram | Process-to-process channels (TCP, UDP). |
| **Network** | **Packet** | **Host-to-host delivery and routing (IP).** |
| **Link** | Frame | Node-to-adjacent-node delivery (Ethernet). |
| **Physical** | Bits | Raw electromagnetic/optical signals. |

### The Encapsulation Process
1.  **Transport**: Wraps the Application Message in a header (containing [[Ports]]).
2.  **Network**: Wraps the Transport Segment in an **IP Header** (containing **IP Addresses**).
3.  **Link**: Wraps the IP Packet in a **Frame Header** and **Trailer** (containing **MAC Addresses** and **CRC**).
4.  **Physical**: Converts the frame into a bitstream for the wire.

[Image: Data encapsulation and decapsulation showing the addition/removal of headers at each layer]

---

## Key Terms

*   **Fragmentation**: The process of breaking a large IP packet into smaller pieces to fit the **MTU** (Maximum Transmission Unit) of a specific link.
*   **Forwarding**: The local action of moving a packet from an input interface to an output interface.
*   **Routing**: The network-wide process of determining the best path from source to destination (the "Control Plane").
*   **Store-and-Forward**: Routers must receive a packet in its entirety and verify its checksum before forwarding it to the next link.

## Related Topics
*   **[[Internet Protocol (IP)]]**: The primary implementation of the Network Layer.
*   **[[Forwarding Table]]**: The database used for local packet switching.
*   **[[OSI Layers]]**: The full 7-layer theoretical model.
