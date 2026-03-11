# Peer-to-Peer (P2P) Networks: Unstructured and Structured

## Overview
**P2P Networks** are self-organizing overlays where a community of users pools resources (content, storage, bandwidth).

---

### Gnutella (Unstructured P2P)
*   **Search via Flooding**: A node sends a **QUERY** to its neighbors, forwarded until a **TTL** expires.
*   **QID (Query Identifier)**: Used to cut off forwarding loops.
*   **Reverse-Path Forwarding**: **QUERY RESPONSE** messages follow the exact reverse path, preserving requester anonymity.

![[an example of virtual private networks.png]]
*Figure: Example topology of a Gnutella peer-to-peer network showing random mesh connectivity*

### Structured Overlays (Distributed Hash Tables - DHT)
**DHTs** use a deterministic mapping of objects to nodes using **Consistent Hashing**.
*   **ID Space**: Both **Nodes** and **Objects** are mapped onto a massive, sparse circular ID space.
*   **Mapping Rule**: An object is stored at the node whose ID is numerically **closest** to the object’s ID.
*   **Pastry (Prefix-Matching)**:
    *   **Routing Logic**: If not in the **Leaf Set**, forward to a peer sharing a longer prefix with the target ID.
    *   **Hop Complexity**: Bounded by $log_{2^b}(N)$.
*   **Proximity Neighbor Selection**: Choosing routing table entries that are physically close to minimize latency.

![[A tunnel through an internetwork.png]]
*Figure: Consistent hashing mapping nodes and objects onto a 128-bit unit circle*

![[General purpose processor used as a software switch.png]]
*Figure: Object location process showing a message being forwarded through prefix-matching nodes*

![[Bare-metal switch using a network processing unit.png]]
*Figure: Multi-row routing table for a Pastry node showing prefix matching by hex digit*

### BitTorrent
Specialized for high-bandwidth file distribution via massive replication.
*   **Pieces/Swarm**: Files are fragmented; the swarm is the group of participating peers.
*   **Tracker/DHT**: Methods for finding peers in the swarm.
*   **Fairness (Tit-for-Tat)**: Choking/Unchoking based on performance.
*   **Rare-First Selection**: Prioritizing the least available pieces.

![[Switch Buffer.png]]
*Figure: BitTorrent swarm showing peers downloading pieces from multiple sources simultaneously*
