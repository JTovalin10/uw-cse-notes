# Border Gateway Protocol (BGP)

**BGP** is the **Interdomain** routing protocol used to exchange reachability information between different [[Autonomous System (AS)|Autonomous Systems]] (AS). It is a **Path-Vector** protocol that focuses on **Policies** (business relationships) rather than just technical metrics like hop count.

## Low-Level Primer: Interdomain vs. Intradomain
*   **Intradomain (IGP)**: Optimized for efficiency and speed (e.g., [[OSPF]], [[RIP]]). All routers are owned by the same entity.
*   **Interdomain (EGP)**: Optimized for **Scale** and **Policy Control**. Routers are owned by different, potentially competing entities (ISPs).
*   **Path-Vector Mechanics**: To prevent routing loops, BGP advertisements include the **AS-PATH**—a list of all AS numbers the update has traversed. If a router sees its own AS number in the path, it rejects the update.

---

## BGP Sessions and Peering

BGP operates over **TCP Port 179** for reliability. 

### 1. eBGP (External BGP)
Used to exchange routes between routers in **different** Autonomous Systems.
*   **Next-Hop**: The IP address of the router in the neighboring AS.

### 2. iBGP (Internal BGP)
Used to distribute the routes learned from eBGP to all other routers **within the same** AS.
*   **The Full Mesh Requirement**: iBGP routers do not re-advertise routes learned from other iBGP peers (to prevent loops). This requires a logical full mesh or the use of **Route Reflectors**.

[Image: BGP topology showing eBGP peering between ASes and iBGP within an AS]

---

## Policy-Based Routing (The AS Relationship Model)
BGP routing decisions are driven by commercial agreements rather than the shortest physical path.

### Standard AS Relationships
1.  **Customer-Provider**: Customer pays the provider for Internet access. The provider advertises all of its routes to the customer.
2.  **Peer-to-Peer**: Two ASes (usually of similar size) exchange traffic for free to avoid paying a provider. Peers **only** exchange routes to their own customers, not their other peers or providers.

### The BGP Decision Process (The Priority List)
When a router learns multiple paths to the same prefix, it selects the "best" path using this hierarchical tie-breaking list:
1.  **Local Preference**: Highest value wins (used to favor specific exit points/providers).
2.  **AS-PATH Length**: Shortest path wins (the primary "metric").
3.  **Multi-Exit Discriminator (MED)**: Lowest value wins (used by a neighbor to suggest a preferred entry point).
4.  **eBGP over iBGP**: Routes learned via eBGP are preferred over those learned via iBGP.
5.  **IGP Cost**: Path with the lowest interior cost to the BGP Next-Hop wins.
6.  **Router ID**: Lowest ID wins (final tie-breaker).

---

## BGP Attributes
*   **AS-PATH**: The list of ASNs. Used for loop detection and path length measurement.
*   **NEXT-HOP**: The IP address to which packets should be sent.
*   **Local Pref**: A value that is local to an AS; it is not sent to other ASes.
*   **MED**: An attribute sent to a neighboring AS to influence their traffic entry.

## AS Numbering (ASN)
*   **Public ASNs**: Globally unique 16-bit (0–65535) or 32-bit integers assigned by RIRs (Regional Internet Registries).
*   **Private ASNs**: Used within internal networks; not routable on the global Internet.

## Related Topics
*   **[[Autonomous System (AS)]]**: The fundamental unit of BGP routing.
*   **[[Forwarding Table]]**: BGP routes are injected into the router's main forwarding table.
*   **[[OSPF]]**: Often used to provide connectivity to BGP next-hops within an AS.
*   **[[CIDR (Classless Interdomain Routing)]]**: BGP is used to advertise CIDR prefixes.
