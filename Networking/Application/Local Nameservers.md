# CSE461: Local Nameservers

A **local nameserver** (also called a **recursive resolver**) is the first DNS server a client contacts when resolving a domain name.

## Who Runs Them

- Typically run by IT departments (enterprise networks, ISPs)
- May be the host itself or an access point (AP) in smaller networks
- Alternatively, a public resolver such as **Google Public DNS** (8.8.8.8) or **Cloudflare** (1.1.1.1)

## How Clients Find Them

- Clients need to be able to contact their local nameserver
- Typically configured automatically via **[[Dynamic Host Configuration Protocol (DHCP)|DHCP]]** when joining a network

## Role in Resolution

The local nameserver receives **recursive queries** from clients and performs **iterative queries** on their behalf:
1. Queries the Root nameservers
2. Follows referrals to TLD nameservers
3. Queries the authoritative nameserver
4. Returns the final answer (and caches it for the TTL duration)

## Related
- [[Domain Name System (DNS)]] — full DNS overview
- [[Iterative vs Recursive Queries]] — how the local nameserver resolves names
- [[Root Nameservers]] — the starting point for iterative resolution
- [[Dynamic Host Configuration Protocol (DHCP)]] — assigns the local nameserver address to clients
- [[Caching]] — the local nameserver caches responses for the pool of clients it serves
