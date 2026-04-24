# Application: Domain Name System (DNS)

The **Domain Name System (DNS)** is a distributed, hierarchical database that translates human-readable **domain names** into routable **IP addresses**. It is a fundamental infrastructure application of the Internet.

- **Names**: Higher-level identifiers for resources (e.g., `www.uw.edu`)
- **Addresses**: Lower-level locators for resources (e.g., `128.95.4.1`); can exist at multiple levels
- **Resolution (lookup)**: The process of mapping a name to an address

## Low-Level Primer

DNS operates as a simple **query/response** protocol:
- **Port**: Operates primarily over **UDP Port 53**.
- **Reliability**: Uses **[[Automatic Repeat Request (ARQ)]]** for reliability—the client retransmits if no response arrives; the server is stateless.
- **Wire Format**: Messages are linked by a **16-bit ID field** so responses can be matched to the query that triggered them.
- **Bindings**: Mappings between a **Name** and a **Value** (e.g., an A record).
- **Name Space**:
    - **Flat**: Simple, unstructured list (e.g., `HOSTS.TXT`).
    - **Hierarchical**: Tree-structured system (e.g., `.com`, `.org`).

## 1. The DNS Hierarchy

### Root Servers
- 13 logical authorities at the top of the tree.
- Utilize **[[Routing Layer - Delivery Models#Anycast|IP Anycast]]** to route requests to the nearest physical instance.

### Top-Level Domains (TLDs)
- **gTLDs**: Generic domains like `.com`, `.edu`.
- **ccTLDs**: Country-specific domains like `.uk`, `.ca`.

### Authoritative Name Servers
- Hold the actual **Resource Records** for a specific zone.

*Figure: Example of a domain hierarchy visualized as a tree*

## 2. Resource Records (RR)

Data is stored as 5-tuples: **(Name, TTL, Type, Class, Value)**.
- **A**: IPv4 address.
- **AAAA**: IPv6 address.
- **NS**: Authoritative Name Server for the domain.
- **CNAME**: Alias for another name.
- **MX**: Mail Exchange server.
- **[[Time to Live (TTL)]]**: Cache duration for the record.

## 3. The Resolution Process

1. **Stub Resolver**: Client OS sends a **Recursive Query** to a **[[Local Nameservers|Local DNS Server]]**.
2. **Iterative Resolution**: The local server queries the **[[Root Nameservers|Root]]**, TLD, and Authoritative servers in sequence.
3. **Caching**: The results are stored locally for the duration of the **TTL**.

*Figure: Sequence of 10 steps showing the iterative resolution process*

## 4. Service Reliability via Replicas

- Multiple nameservers can be run for a single domain.
- The zone's NS records return a list of nameservers; the client picks one.
- Distributes load and improves availability.

## 5. Security

Security is a major issue in DNS:
- A compromised DNS server can redirect users to the wrong (malicious) site.
- Security was **not** part of the original protocol design.
- **DNSSEC (DNS Security Extensions)** adds cryptographic signatures to DNS records to prevent tampering; deployment has been slow.

## Diagnostic Tools
- **`dig`**: Domain Information Groper. Use `dig +trace` to see the full iterative process.

## Related
- [[CSE333/Networking/DNS|Implementation: DNS in C]]
- [[Local Nameservers]] — the resolver a client queries first
- [[Root Nameservers]] — the top of the DNS hierarchy
- [[Iterative vs Recursive Queries]] — resolution strategies
- [[Caching]] — how TTL-based caching reduces DNS lookup latency
- [[Dynamic Host Configuration Protocol (DHCP)]] — also assigns addresses and configures the local nameserver
