# Switching, Bridging, and Access Networks

**Switching** is the process of interconnecting multiple physical links to form an **Extended LAN**. Unlike a hub (which broadcasts everything), a switch performs **Selective Forwarding** to increase total network capacity and isolate collision domains.

## Low-Level Primer: The Learning Bridge
A switch (or bridge) is a transparent device that connects multiple LAN segments. It builds its **Forwarding Table** dynamically through **Backwards Learning**.

### The Learning Algorithm
1.  **Inspection**: The switch examines the **Source MAC Address** of every incoming frame.
2.  **Recording**: It maps that MAC address to the **Incoming Port** in its local table.
3.  **Forwarding Logic**:
    *   If **Destination MAC** is in the table: Forward to the specific port (unless it's the same port it arrived on).
    *   If **Destination MAC** is NOT in the table: **Flood** the frame to all other ports.
4.  **Aging**: Entries are discarded after a timeout (e.g., 5 minutes) to handle host mobility.

[Image: Learning bridge forwarding table showing MAC-to-Port mappings]

---

## Loop Prevention: Spanning Tree Algorithm (STP)

Redundant links are necessary for reliability but create **Broadcast Storms** if loops exist. STP computes a loop-free subgraph.

### The 4-Step Election Process
1.  **Elect a Root Bridge**: The switch with the lowest **Bridge ID** (Priority + MAC).
2.  **Select Root Ports**: Each non-root switch identifies the port with the lowest **Path Cost** to the root.
3.  **Select Designated Ports**: For every LAN segment, the switch closest to the root is elected to forward frames for that segment.
4.  **Block Remaining Ports**: Any port not selected as a Root or Designated port is transitioned to the **Blocking** state.

### Configuration Messages (BPDUs)
Switches exchange Bridge Protocol Data Units containing:
*   `ID` of the sending switch.
*   `RootID` of the switch it believes is the root.
*   `Cost` to that root.

[Image: Network graph showing redundant links converted to a spanning tree]

---

## Virtual LANs (VLANs)

VLANs solve the scalability issues of flat Layer 2 networks by creating logical broadcast domains on a single physical switch.
*   **Mechanics**: Frames are "colored" with a 12-bit **VLAN ID** (defined in **802.1Q**).
*   **Isolation**: Broadcasts from VLAN 10 never reach VLAN 20, even if the hosts are on the same physical hardware.
*   **Trunking**: A special link that carries frames for multiple VLANs between switches, using tags to preserve the identity.

[Image: VLAN-tagged frame format showing the 802.1Q header]

---

## Access Networks: The First/Last Mile

Access networks connect homes and businesses to the ISP's core network.

### 1. Passive Optical Network (PON)
The most common fiber-to-the-home (FTTH) architecture.
*   **Structure**: A tree-based, point-to-multipoint design using passive splitters.
*   **OLT (Optical Line Terminal)**: Located at the ISP; manages framing and timing.
*   **ONU (Optical Network Unit)**: The subscriber endpoint.
*   **Downstream**: Continuous broadcast; ONUs filter frames by ID and use **Encryption** for privacy.
*   **Upstream**: Time-Division Multiplexed. The OLT issues **Grants** specifying the exact time slot each ONU can transmit.

### 2. Cellular RAN (LTE/5G)
*   **UE (User Equipment)**: The mobile device.
*   **BBU (Broadband Base Unit)**: The base station / cell tower.
*   **EPC (Evolved Packet Core)**: The central office logic that anchors the BBUs.
*   **Handoff**: The process of moving a UE from one BBU to another as it roams between cells.

[Image: Cellular network architecture showing UE, BBU, and EPC]
