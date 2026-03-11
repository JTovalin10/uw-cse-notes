# Routing Overlays: Resiliency and Multicast

## Overview
**Routing Overlays** are used to implement alternative routing strategies that bypass the standard **BGP** paths or to deploy experimental protocols without requiring global hardware upgrades.

---

### Experimental IP Deployment
*   **MBone (Multicast Backbone)**: An overlay used to implement **IP Multicast** on top of unicast infrastructure using **IP-in-IP** tunnels.
*   **6-BONE**: An overlay for the incremental deployment of **IPv6**, tunneling 128-bit packets through 32-bit IPv4 routers.

### End System Multicast
Moves the responsibility of multicast tree construction from routers to the **End Hosts**.
*   **Architecture**:
    1.  **Mesh Construction**: Build a virtual graph (mesh) between hosts using **UDP Tunnels**.
    2.  **Tree Selection**: Run a multicast routing algorithm (e.g., **DVMRP**) on top of the logical mesh.
*   **Membership Management**:
    *   **Join/Leave/Failure**: Handled via explicit messaging and heartbeats.
    *   **Partition Repair**: Restoring connectivity if the mesh splits.
*   **Optimization**: Nodes probe members to calculate utility (latency reduction) and prune high-cost links.

![[Header Fields used in IP fragmentation.png]]
*Figure: Alternative multicast trees (Unicast, IP Multicast, End System Multicast) mapped onto a physical topology*

![[IP addressess (classes).png]]
*Figure: Multicast tree embedded in a mesh overlay network*

### Resilient Overlay Networks (RON)
**RON** exploits the failure of the **Triangle Inequality** in the Internet—the observation that the direct path between node A and B is often slower or less reliable than an indirect path via node C (A → C → B).
*   **Path Quality Monitoring**: RON monitors **N × N** paths for latency, bandwidth, and loss.
*   **Performance**: RON can recover from outages in less than 20 seconds, significantly faster than **BGP**.

![[Route Aggregation with CIDR.png]]
*Figure: Triangle inequality failure showing indirect paths being faster than direct BGP paths*
