# Network Layer: MPLS (Multiprotocol Label Switching)

## Low-Level Primer: Label Switching vs. IP Routing
**[[MPLS]]** is a "Layer 2.5" technology that combines the flexibility of IP routing with the performance and predictability of Virtual Circuits. Instead of performing a complex **Longest Prefix Match (LPM)** lookup at every hop, routers use short, fixed-length **Labels** to make forwarding decisions.

---

## 1. MPLS Components

*   **LER (Label Edge Router)**: The "Entry/Exit" point. It performs the initial IP lookup, classifies the packet into an FEC, and "Pushes" an MPLS label onto the stack.
*   **LSR (Label Switching Router)**: Core routers. They ignore the IP header and simply "Swap" the incoming label for an outgoing label based on a simple table index.
*   **FEC (Forwarding Equivalence Class)**: A set of packets that receive the same forwarding treatment (e.g., all packets for prefix `10.1.1.0/24`).

---

## 2. Technical Mechanics

### Label Stacking
MPLS headers (4 bytes) can be stacked. The "Top" label is used for immediate forwarding, while "Inner" labels can be used for VPN identification or traffic engineering.

### Label Distribution Protocol (LDP)
Routers use LDP to agree on the meaning of labels. For every IP prefix in the routing table, a router generates a local label and tells its neighbors: "If you want to reach prefix X, send it to me with Label L."

---

## 3. Advanced Applications

### Traffic Engineering (TE)
Standard IP routing always follows the shortest path, leading to congested links while others sit idle. MPLS allows operators to define **Explicit Paths** that bypass congested nodes, even if those paths are geographically longer.

### Fast Reroute (FRR)
MPLS can pre-calculate a "Backup Path" for every link. If a link fails, the LSR can switch to the backup path in under 50ms, long before the standard IP routing protocols (OSPF/BGP) have even noticed the failure.

### Layer 3 VPNs
MPLS allows a provider to carry multiple customers' traffic over a shared backbone while keeping them completely isolated. Each customer gets their own **Virtual Routing and Forwarding (VRF)** table, and overlapping IP addresses (e.g., two customers using `192.168.1.0/24`) are handled via unique MPLS labels.

---

## 4. MPLS vs. Pure IP

| Feature | Pure IP Routing | MPLS |
| :--- | :--- | :--- |
| **Lookup** | Longest Prefix Match (LPM) | Exact Match (Label Index) |
| **Path** | Shortest Path Only | Arbitrary (Explicit Paths) |
| **State** | Stateless (mostly) | State per Flow/FEC |
| **Overhead** | 20B Header | 4B Shim + 20B IP |
