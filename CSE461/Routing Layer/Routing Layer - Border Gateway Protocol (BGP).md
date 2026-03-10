# Routing Layer: Border Gateway Protocol (BGP)

## Low-Level Primer: The Path-Vector Model
**[[Border Gateway Protocol (BGP)|BGP]]** is the interdomain routing protocol that binds the Internet's various **[[Autonomous System (AS)]]** into a single global network. Unlike intradomain protocols that use simple metrics like hop count, BGP is a **Path-Vector** protocol that uses **Policies** (business logic) to select routes and the **AS-PATH** attribute to prevent loops.

---

## 1. BGP Sessions and Peering

BGP operates over **TCP Port 179** for reliable transport. 

### External BGP (eBGP)
Used to exchange reachability information between border routers in **different** Autonomous Systems. 
*   **Default Behavior**: Prepends its own AS number to the AS-PATH before advertising a route to an eBGP peer.

### Internal BGP (iBGP)
Used to propagate the information learned from eBGP to all other routers **within the same** AS.
*   **The Problem**: iBGP routers do not re-advertise routes learned from other iBGP peers (to prevent loops inside the AS).
*   **The Fix**: Requires a logical "Full Mesh" of iBGP sessions or the use of **Route Reflectors**.

---

## 2. The BGP Decision Process

When a router receives multiple paths to the same prefix, it chooses the "best" path using a strictly ordered list of attributes:

1.  **Local Preference**: Highest value wins. Used to prefer one exit point (e.g., a cheaper provider) over others. (Local to the AS).
2.  **AS-PATH Length**: Shortest path (fewest AS hops) wins.
3.  **Multi-Exit Discriminator (MED)**: Lowest value wins. Used by a neighboring AS to suggest which entry point you should use.
4.  **eBGP over iBGP**: Routes learned from outside the AS are preferred over internal ones.
5.  **IGP Cost**: Path with the lowest interior cost to reach the BGP Next-Hop.
6.  **Router ID**: Final tie-breaker; lowest ID wins.

---

## 3. AS Relationships and Export Policies

BGP routing is driven by commercial agreements, not just technical optimality.

| Relationship | Export Policy |
| :--- | :--- |
| **Provider to Customer** | Provider advertises **all** known routes to the customer. |
| **Customer to Provider** | Customer advertises its own routes (and its customers' routes), but **never** routes learned from one provider to another. |
| **Peer to Peer** | Peers only exchange routes to their respective customers. They **never** act as transit for each other's other peers or providers. |

---

## 4. Key BGP Mechanics

*   **AS-PATH**: A list of ASNs (e.g., `[AS701, AS1239, AS3549]`). If a router sees its own ASN in the list, it knows a loop has occurred and rejects the update.
*   **Next-Hop**: The IP address of the border router in the neighboring AS.
*   **Withdrawals**: Negative advertisements used to cancel previously reachable routes.
*   **Aggregation**: Summarizing many specific prefixes (e.g., `/24`) into a single larger prefix (e.g., `/16`) to keep the global routing table manageable (~1 million entries).

[Image: BGP topology diagram showing eBGP between ASes and iBGP within ASes]
