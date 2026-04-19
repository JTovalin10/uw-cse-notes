# CSE461: Domain Name System (DNS)

The **Domain Name System (DNS)** is a distributed, hierarchical database that translates human-readable **domain names** into routable **IP addresses**. It is a fundamental infrastructure application of the Internet.

- **Names** — higher-level identifiers for resources (e.g., `www.uw.edu`)
- **Addresses** — lower-level locators for resources (e.g., `128.95.4.1`); can exist at multiple levels
- **Resolution (lookup)** — the process of mapping a name to an address

---

## Low-Level Mechanics
*   **Port**: Operates primarily over **UDP Port 53**.
*   **Bindings**: Mappings between a **Name** and a **Value** (e.g., an A record).
*   **Name Space**:
    *   **Flat**: Simple, unstructured list (e.g., `HOSTS.TXT`).
    *   **Hierarchical**: Tree-structured system (e.g., `.com`, `.org`).

---

## The DNS Hierarchy

### 1. Root Servers
*   13 logical authorities at the top of the tree.
*   Utilize **IP Anycast** ([[Routing Layer - Delivery Models#Anycast|anycast routing]]) to route requests to the nearest physical instance.

### 2. Top-Level Domains (TLDs)
*   **gTLDs**: Generic domains like `.com`, `.edu`.
*   **ccTLDs**: Country-specific domains like `.uk`, `.ca`.

### 3. Authoritative Name Servers
*   Hold the actual **Resource Records** for a specific zone.

*Figure: Example of a domain hierarchy visualized as a tree*

---

## Resource Records (RR)
Data is stored as 5-tuples: **(Name, TTL, Type, Class, Value)**.
*   **A**: IPv4 address.
*   **AAAA**: IPv6 address.
*   **NS**: Authoritative Name Server for the domain.
*   **CNAME**: Alias for another name.
*   **MX**: Mail Exchange server.
*   **[[Time to Live (TTL)]]**: Cache duration for the record.

---

## The Resolution Process

1.  **Stub Resolver**: Client OS sends a **Recursive Query** to a **Local DNS Server**.
2.  **Iterative Resolution**: The local server queries the Root, TLD, and Authoritative servers in sequence.
3.  **Caching**: The results are stored locally for the duration of the **TTL**.

*Figure: Sequence of 10 steps showing the iterative resolution process*

---

## Diagnostic Tools
*   **`dig`**: Domain Information Groper. Use `dig +trace` to see the full iterative process.

## Related
- [[Local Nameservers]] — the resolver a client queries first
- [[Root Nameservers]] — the top of the DNS hierarchy
- [[Iterative vs Recursive Queries]] — resolution strategies
- [[DNS protocol]] — wire format, UDP port 53, DNSSEC
- [[Caching]] — how TTL-based caching reduces DNS lookup latency
- [[Dynamic Host Configuration Protocol (DHCP)]] — also assigns addresses and configures the local nameserver
