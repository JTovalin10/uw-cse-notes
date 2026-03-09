# Overlay Networks

**Overlay Networks** represent a form of **Network Virtualization** where a logical network topology is constructed on top of an underlying physical network (typically the **Internet**). In this model, overlay nodes function as application-specific "routers" that make forwarding decisions based on high-level identifiers (e.g., URLs, file hashes, or XML queries) rather than standard **IP** addresses.

## Fundamental Mechanics of Overlays

*   **Virtualization**: The process of building a virtual network using logical resources (abstract nodes and links) on top of physical hardware resources.
*   **Tunneling (Encapsulation)**: The core mechanism for connecting overlay nodes.
    *   **Outer Header (OHdr)**: Used by physical routers to forward the packet across the underlying network. These routers are unaware of the overlay's existence.
    *   **Inner Header (IHdr)**: Used by overlay nodes to make application-specific forwarding decisions.
    *   **Edge Processing**: Overlay nodes understand both headers, while intermediate physical nodes only interpret the **OHdr**.
*   **Logical Links**: A "link" in an overlay is actually a multi-hop path in the underlying network, treated as a single hop by the overlay protocol.
*   **Address Spaces**: Overlay nodes possess two distinct identifiers:
    1.  An **Underlying Address** (e.g., a 32-bit [[IPv4]] address).
    2.  An **Overlay Address** (e.g., a 128-bit experimental ID, a URL, or a content-based hash).

[Image: Overlay network layered on top of a physical network]
[Image: Overlay nodes tunneling through physical nodes, showing Inner (IHdr) and Outer (OHdr) header encapsulation]

---

## Routing Overlays

**Routing Overlays** are used to implement alternative routing strategies that bypass the standard **BGP** paths or to deploy experimental protocols without requiring global hardware upgrades.

### Experimental IP Deployment
*   **MBone (Multicast Backbone)**: An overlay used to implement **IP Multicast** on top of unicast infrastructure. It used **IP-in-IP** tunnels to connect multicast-aware routers, effectively bypassing legacy routers that did not support multicast.
*   **6-BONE**: An overlay for the incremental deployment of **IPv6**. It tunneled 128-bit IPv6 packets through 32-bit IPv4 routers.

### End System Multicast
This approach moves the responsibility of multicast tree construction from routers to the **End Hosts** participating in the application.
*   **Architecture**: Operates as a two-stage process:
    1.  **Mesh Construction**: Build a virtual graph (mesh) between participating hosts using **UDP Tunnels**.
    2.  **Tree Selection**: Run a standard multicast routing algorithm (e.g., **DVMRP**) on top of the logical mesh to extract an efficient multicast tree.
*   **Membership Management**:
    *   **Join**: A new host sends a "join mesh" message to a known member.
    *   **Keepalive**: Nodes periodically send heartbeat messages to maintain links.
    *   **Leave/Failure**: Nodes send explicit "leave" messages or are timed out by neighbors.
    *   **Partition Repair**: If a node detects the mesh has split, it adds new cross-partition edges to restore connectivity.
*   **Optimization Metrics**:
    *   **EvaluateUtility(j)**: A node probes random members to calculate the percentage reduction in latency if a new link is added.
        *   `utility += (Current_Latency - New_Latency) / Current_Latency`
    *   **EvaluateCost(j)**: Nodes calculate how many other members use a specific link for their shortest path; low-cost links are pruned.

[Image: Alternative multicast trees (Unicast, IP Multicast, End System Multicast) mapped onto a physical topology]
[Image: Multicast tree embedded in a mesh overlay network]

### Resilient Overlay Networks (RON)
**RON** exploits the failure of the **Triangle Inequality** in the Internet—the observation that the direct path between node A and B is often slower or less reliable than an indirect path via node C (A → C → B).
*   **Path Quality Monitoring**: Scaled to small groups (dozens of nodes), RON monitors **N × N** paths for:
    *   **Latency**
    *   **Available Bandwidth**
    *   **Loss Probability**
*   **Performance**: RON can recover from outages in less than 20 seconds, whereas **BGP** may take minutes to converge.
*   **Commercial Equivalent**: Modern **SD-WAN** (Software-Defined WAN) technology implements this concept for corporate connectivity.

[Image: Triangle inequality failure showing indirect paths being faster than direct BGP paths]

---

## Peer-to-Peer (P2P) Networks

**P2P Networks** are self-organizing overlays where a community of users pools resources (content, storage, bandwidth).

### Gnutella (Unstructured P2P)
*   **Search via Flooding**: A node sends a **QUERY** to its neighbors, who forward it until a **TTL** (Time-to-Live) expires.
*   **QID (Query Identifier)**: A unique ID used to cut off forwarding loops.
*   **Reverse-Path Forwarding**: **QUERY RESPONSE** messages follow the exact reverse path of the original query, ensuring the requester's identity remains anonymous to intermediate nodes.
*   **Probing**: Uses **PING** and **PONG** messages to maintain neighbor lists.

[Image: Example topology of a Gnutella peer-to-peer network showing random mesh connectivity]

### Structured Overlays (Distributed Hash Tables - DHT)
**DHTs** use a deterministic mapping of objects to nodes using **Consistent Hashing**.
*   **ID Space**: Both **Nodes** (using IP hashes) and **Objects** (using name hashes) are mapped onto a massive, sparse 128-bit circular ID space.
*   **Mapping Rule**: An object is stored at the node whose ID is numerically **closest** to the object’s ID.
*   **Pastry (The Prefix-Matching Overlay)**:
    *   **Routing Logic**: If the target ID is not within the node's **Leaf Set**, the node forwards the message to a peer that shares a longer prefix with the target ID.
    *   **Leaf Set**: A small set of nodes with numerically adjacent IDs (used for final local delivery).
    *   **Routing Table**: A grid where each row represents a prefix match and each column represents the next hex digit in the ID.
    *   **Hop Complexity**: Bounded by $log_{2^b}(N)$, where $b$ is the base (e.g., hex) and $N$ is the number of nodes.
*   **Proximity Neighbor Selection**: Choosing routing table entries that share a prefix but are also physically close in the underlying network to minimize total latency.

[Image: Consistent hashing mapping nodes and objects onto a 128-bit unit circle]
[Image: Object location process showing a message being forwarded through prefix-matching nodes]
[Image: Multi-row routing table for a Pastry node showing prefix matching by hex digit]
[Image: The process of adding a new node to a structured overlay]

### BitTorrent
A specialized P2P protocol for high-bandwidth file distribution via massive replication.
*   **Pieces**: Files are fragmented into segments (typically 256KB to 1MB).
*   **Swarm**: The group of all peers participating in the transfer of a specific file.
*   **Tracker**: A central server tracking swarm membership.
*   **Trackerless (DHT)**: Modern clients use a **Kademlia-style DHT** (Peer Finders) to find peers without a central server.
*   **Fairness (Tit-for-Tat)**:
    *   **Choking**: A node stops uploading to a peer if that peer does not provide sufficient data in return.
    *   **Unchoking**: Re-enabling uploads based on performance.
*   **Rare-First Selection**: Peers prioritize downloading the pieces that are least available in the swarm to prevent piece extinction.

[Image: BitTorrent swarm showing peers downloading pieces from multiple sources simultaneously]

---

## Content Distribution Networks (CDN)

**CDNs** are overlays of **Server Surrogates** designed to bypass Internet bottlenecks: **First Mile**, **Last Mile**, **Server Overload**, and **Peering Point** congestion.

### Redirection Mechanisms
*   **DNS-based**: The DNS server returns the IP address of the surrogate server that is physically closest or has the lightest load.
*   **Anycast** (Expert Detail): Multiple servers announce the same IP via BGP; the network naturally routes to the "closest" instance.
*   **URL Rewriting**: Modifying links in the HTML to point directly to CDN-specific hostnames.
*   **HTTP Redirect**: The server sends a **302 Found** response, pointing the client to a better surrogate.

[Image: Components in a Content Distribution Network showing Redirectors and Surrogate Servers]

### Distribution Policies
*   **Locality**: Directing requests for the same URL to the same server to maximize cache hits.
*   **Consistent Hashing**: Used to ensure that adding or removing a server only affects a minimal portion of the cached content.
*   **CARP (Cache Array Routing Protocol)**:
    *   A score-based hashing scheme: `score[s] = hash(URL, server_address[s])`.
    *   The redirector selects the server with the highest score that is currently under its load threshold.
    *   **Benefit**: Deterministic mapping without requiring inter-server coordination.

### Performance Optimization
*   **Network Proximity**: Minimizing the number of [[Autonomous System (AS)]] hops.
*   **System Throughput**: Balancing load to prevent any single surrogate from reaching its resource limit.
