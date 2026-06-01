# CSE461: Root Nameservers

**Root nameservers** sit at the top of the DNS hierarchy. They are the starting point for all iterative DNS resolution.

## Key Facts

- The root (written as `.`) is served by **13 server names** (labeled `a.root-servers.net` through `m.root-servers.net`)
- All nameservers need the root IP addresses, handled via a configuration file (`named.ca` / `root.hints`)
- There are over **250 distributed server instances** worldwide — one "name" maps to many physical servers
- **IP anycast** routes queries to the nearest instance, making the service highly available and low-latency
- Servers are reachable via both **IPv4 and IPv6**

## Role in Resolution

When a local nameserver receives a query it cannot answer from its cache, it contacts a root nameserver. The root returns a referral to the appropriate **Top-Level Domain (TLD)** nameserver (e.g., `.com`, `.edu`).

## Related
- [[Domain Name System (DNS)]] — full DNS overview including the hierarchy
- [[Iterative vs Recursive Queries]] — root servers are the first stop in iterative resolution
- [[Local Nameservers]] — the resolver that contacts root servers on behalf of clients
- [[Routing Layer - Delivery Models]] — anycast routing used by root servers
