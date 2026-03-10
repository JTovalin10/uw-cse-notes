# Link Layer: Virtual LANs (VLANs)

## Low-Level Primer: Logical Resource Partitioning
A standard Layer 2 network is a single **Broadcast Domain**, meaning a broadcast frame sent by one host reaches every other host in the network. In large environments (e.g., a university campus), this leads to massive overhead and security risks. **Virtual LANs (VLANs)** solve this by allowing a single physical switch to be partitioned into multiple logical, isolated LANs.

---

## 1. The Scaling Problem
In a "flat" network:
*   **Broadcast Overhead**: Every machine must process every broadcast (ARP requests, DHCP).
*   **Security**: Any host can sniff traffic from any other host using ARP spoofing or promiscuous mode.
*   **Management**: Changing the network structure requires physically moving cables.

---

## 2. 802.1Q Tagging Mechanics

To maintain VLAN identity as frames move between switches, the IEEE 802.1Q standard inserts a 4-byte **VLAN Tag** into the Ethernet header.

### The 802.1Q Header Structure
1.  **TPID (Tag Protocol Identifier)**: 2 bytes set to `0x8100` to indicate a tagged frame.
2.  **TCI (Tag Control Information)**:
    *   **Priority (PCP)**: 3 bits for Layer 2 Quality of Service (QoS).
    *   **DEI**: 1 bit indicating the frame can be dropped during congestion.
    *   **VLAN ID (VID)**: 12 bits, allowing for **4,096** unique VLANs.

---

## 3. Switch Port Types

*   **Access Port**: Connected to an end-host (PC, Server). It accepts/sends untagged frames. The switch assigns these frames to a specific VLAN based on port configuration.
*   **Trunk Port**: Connected to another switch or router. It carries frames for **multiple VLANs** simultaneously, using the 802.1Q tags to keep them separate.

---

## 4. Operational Benefits

*   **Logical Topology**: Move a user from the "Finance" VLAN to the "Engineering" VLAN via a software command, without moving their desk or re-patching cables.
*   **Security Isolation**: Hosts in VLAN 10 cannot communicate with hosts in VLAN 20 at Layer 2. Communication between them **must** pass through a Layer 3 Router (or "Layer 3 Switch"), where access control lists (ACLs) can be applied.
*   **Performance**: Limits the scope of broadcast traffic to a smaller subset of nodes.

[Image: Diagram showing two physical switches connected by a trunk link, carrying traffic for Red, Green, and Blue VLANs]
