# Link Layer: Switching and Bridges

## Low-Level Primer: Interconnecting Physical Segments
As networks grow, a single shared medium (like Classic Ethernet) becomes a bottleneck due to collisions and administrative overhead. **Switching** (or **Bridging**) is the process of interconnecting multiple physical links to form an **Extended LAN**. A switch acts as a high-speed, multi-port bridge that performs **Selective Forwarding**, effectively isolating collision domains and increasing total network capacity.

---

## 1. Hubs vs. Repeaters vs. Switches

| Device | Layer | Action | Collision Domain |
| :--- | :--- | :--- | :--- |
| **Repeater** | Physical (L1) | Amplifies signal. | Single domain. |
| **Hub** | Physical (L1) | Broadcasts all inputs to all outputs. | Single domain. |
| **Switch** | Link (L2) | Inspects MACs and forwards selectively. | Separate domain per port. |

---

## 2. Learning Bridges: Backwards Learning

A switch is "Plug-and-Play"—it requires no initial configuration because it builds its **Forwarding Table** (or Filtering Database) dynamically.

### The Algorithm
1.  **Inspection**: For every incoming frame, the switch records the **Source MAC Address** and the **Incoming Port**.
2.  **Table Entry**: It creates a mapping: `[MAC Address] -> [Port ID]`.
3.  **Forwarding Decision**:
    *   If **Destination MAC** is in the table: Forward to the mapped port (unless it's the same port it arrived on).
    *   If **Destination MAC** is NOT in the table: **Flood** the frame to all other active ports.
4.  **Aging**: Entries are assigned a **Time to Live (TTL)** (typically 300s). If not refreshed by a new frame, the entry is deleted to handle host mobility (e.g., a laptop moving to a different port).

---

## 3. Spanning Tree Algorithm (STP)

Redundant links are essential for reliability but create **Forwarding Loops**. In a loop, a broadcast frame (or a frame with an unknown destination) will circulate forever, causing a **Broadcast Storm** that crashes the network. STP computes a loop-free subgraph.

### The 4-Step Election Process (IEEE 802.1D)
1.  **Elect a Root Bridge**: The switch with the **lowest Bridge ID** (Priority + MAC Address).
2.  **Select Root Ports**: Each non-root switch identifies the port with the lowest **Path Cost** to the root bridge.
3.  **Select Designated Ports**: For every LAN segment, the switch with the lowest path cost to the root is elected to forward frames for that segment.
4.  **Block Remaining Ports**: Any port not selected as a Root or Designated port is put into the **Blocking** state.

### BPDU (Bridge Protocol Data Unit)
Switches exchange BPDUs every 2 seconds to maintain the tree. A BPDU contains:
*   `RootID`: Who this switch thinks the root is.
*   `Cost`: Distance to that root.
*   `BridgeID`: The sender's ID.

[Image: Diagram showing a physical mesh topology converted to a logical tree by blocking redundant links]

---

## 4. Technical Performance
*   **Parallelism**: A switch can handle multiple simultaneous transmissions (e.g., Port 1 to 2 and Port 3 to 4) without interference.
*   **Buffering**: Switches must buffer frames when multiple inputs target the same output port. Sustained over-subscription leads to **Buffer Overflow** and frame loss.
