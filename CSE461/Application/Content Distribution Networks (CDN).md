also # Content Distribution Networks (CDN)

## Overview
CDNs are overlays of Server Surrogates designed to bypass Internet bottlenecks: First Mile, Last Mile, Server Overload, and Peering Point congestion.

---

## Infrastructure Components
*   **Origin Server**: The master copy of the website's data.
*   **Edge Servers (Surrogates)**: Cached copies located close to end-users.
*   **Points of Presence (PoPs)**: Data centers housing clusters of edge servers.

## Redirection Mechanisms
*   **DNS-based**: Returning the IP of the closest or least-loaded surrogate.
*   **Anycast**: Multiple servers announce the same IP; network routes to the "closest" instance.
*   **URL Rewriting**: Modifying links to point to CDN hostnames.
*   **HTTP Redirect**: Using `302 Found` to point the client to a better surrogate.

## Distribution Policies
*   **Locality**: Directing same-URL requests to the same server to maximize cache hits.
*   **Consistent Hashing**: Ensuring minimal impact when adding/removing servers.
*   **CARP (Cache Array Routing Protocol)**: A score-based hashing scheme for deterministic mapping without coordination.

## Performance Optimization
*   **Network Proximity**: Minimizing the number of Autonomous System (AS) hops.
*   **System Throughput**: Balancing load across surrogates.

*Figure: CDN architecture showing edge servers and origin server interaction*
