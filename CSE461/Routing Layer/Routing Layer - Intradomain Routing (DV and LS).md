# Routing Layer: Intradomain Routing (DV and LS)

## Low-Level Primer: Routing within a Domain
**Intradomain Routing** (or Interior Gateway Protocol, **IGP**) is the process by which routers within a single administrative domain—an **[[Autonomous System (AS)]]**—exchange reachability information. The goal is to compute the "best" path to every node in the local network based on a specific metric (e.g., hop count or bandwidth-related cost). 

The two fundamental classes of intradomain algorithms are **Distance-Vector** and **Link-State**.

---

## 1. Distance-Vector Routing (Distributed Bellman-Ford)

In Distance-Vector (DV), each router maintains a table containing the distance (cost) to all known destinations and the next-hop router to get there.

### The Algorithm
1.  **Local Knowledge**: Initially, a router only knows the cost to its directly connected neighbors.
2.  **Exchange**: Periodically, every router sends its entire routing table (its "vector") to its **immediate neighbors only**.
3.  **Update**: When a router $x$ receives a vector from neighbor $v$, it updates its cost to destination $y$ if the path through $v$ is shorter:
    $$D_x(y) = \min \{cost(x, v) + D_v(y)\}$$

### The "Count-to-Infinity" Problem
When a link fails, stale information can circulate as routers increment hop counts based on each other's outdated vectors.
*   **Solution: Split Horizon**: Do not advertise a route back to the neighbor from which it was learned.
*   **Solution: Poison Reverse**: Advertise a cost of $\infty$ for a route back to its source neighbor.

### Protocol Example: RIP (Routing Information Protocol)
*   **Metric**: Hop count (Max = 15; 16 is unreachable).
*   **Update Interval**: 30 seconds.
*   **Transport**: Runs over UDP port 520.

---

## 2. Link-State Routing (Distributed Dijkstra)

In Link-State (LS), every router floods information about its local links to **every other router** in the network, allowing each node to build a complete map of the topology.

### The Two-Phase Process
1.  **Reliable Flooding**:
    *   Each router creates a **Link-State Packet (LSP)** containing its ID, its neighbors, and the cost of those links.
    *   LSPs are flooded to all nodes. Each router uses **Sequence Numbers** and **[[Time to Live (TTL)]]** to ensure it only stores and forwards the most recent information.
2.  **Route Computation**:
    *   Once a router has the complete **Link-State Database (LSDB)**, it runs **Dijkstra's Algorithm** (Shortest Path First) to compute a tree of shortest paths rooted at itself.

### Protocol Example: OSPF (Open Shortest Path First)
*   **Metric**: Configurable "Cost" (usually inversely proportional to bandwidth).
*   **Transport**: Runs directly over IP (Protocol 89).
*   **Convergence**: Very fast; once the map is disseminated, routers can react to changes locally.

---

## Comparison Summary

| Feature | Distance-Vector (DV) | Link-State (LS) |
| :--- | :--- | :--- |
| **View** | Neighbors only (Vector) | Global (Topology Map) |
| **Convergence** | Slow (potential loops) | Fast |
| **Complexity** | Simple (low CPU/Memory) | High (Memory/CPU intensive) |
| **Robustness** | Error propagates network-wide | Error is localized to source node |
| **Standard** | RIP | OSPF |

## Related Topics
*   **[[Dijkstra's Algorithm]]**: The math behind LS.
*   **[[Autonomous System (AS)]]**: The boundary for these IGPs.
*   **[[Forwarding Table]]**: The final data structure used to switch packets.
