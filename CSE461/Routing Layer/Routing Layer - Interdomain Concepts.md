# Routing Layer: Interdomain Concepts

## Low-Level Primer: The Global Topology
Interdomain routing manages the movement of traffic across the boundaries of different network owners. The Internet is structured as a collection of **[[Autonomous System (AS)]]**, each representing a routing domain under a single administrative entity (e.g., AT&T, Comcast, UW).

---

## 1. Autonomous System (AS) Types

| Type | Description |
| :--- | :--- |
| **Stub AS** | A network that only carries its own traffic (e.g., a small company or campus). It has only one connection to a provider. |
| **Multihomed Stub**| Connected to multiple providers but refuses to carry transit traffic (traffic not originating or terminating within the AS). |
| **Transit AS** | A network designed to carry traffic for others (e.g., a tier-1 or tier-2 ISP). |

---

## 2. Policy-Based Routing

The primary goal of interdomain routing is not the shortest path, but **Policy Compliance**.

*   **Reachability Sharing**: ASes must advertise which IP prefixes they can reach.
*   **Privacy**: ASes want to keep their internal topology and their economic arrangements secret.
*   **Cost**: Routing decisions are often biased toward the cheapest path, even if it is technically slower (higher latency).

---

## 3. Traffic Categories

*   **Local Traffic**: Traffic that originates within the AS or is destined for a host within the AS.
*   **Transit Traffic**: Traffic that enters the AS from one peer and leaves toward another peer. 
    *   ASes only agree to carry transit traffic if they are paid (Customer-to-Provider) or if it is a mutually beneficial Peering arrangement.

---

## 4. AS Numbering (ASN)

Each AS is assigned a unique identifier by a central authority (**IANA**).
*   **16-bit ASNs**: Legacy (0 to 65,535).
*   **32-bit ASNs**: Modern expansion to accommodate the growing number of networks.
*   **Private ASNs**: Used for internal routing; must be stripped before advertisements reach the public Internet.

---

## 5. Internet-Wide Challenges

*   **Prefix Aggregation**: To prevent the global routing table from growing too large, ASes aggregate many small prefixes into a single advertisement.
*   **Convergence and Stability**: BGP is slow to converge. A phenomenon called **Route Flapping** (a route repeatedly going up and down) can trigger thousands of updates worldwide, leading to instability (mitigated by **Route Dampening**).
*   **Security**: BGP was designed without built-in authentication. **BGP Hijacking** occurs when an AS maliciously (or accidentally) advertises a prefix it doesn't own.

[Image: Diagram of AS interconnections showing Stub, Multihomed, and Transit AS roles]
