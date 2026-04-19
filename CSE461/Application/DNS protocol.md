# CSE461: DNS Protocol Mechanics

## Wire Format

DNS uses a simple **query/response** message format:
- Built on **UDP**, port **53**
- **ARQ** (Automatic Repeat Request) for reliability — the client retransmits if no response arrives; the server is stateless
- Messages are linked by a **16-bit ID field** so responses can be matched to the query that triggered them

## Service Reliability via Replicas

- Multiple nameservers can be run for a single domain
- The zone's NS records return a list of nameservers; the client picks one
- Distributes load and improves availability

## Security

Security is a major issue in DNS:
- A compromised DNS server can redirect users to the wrong (malicious) site
- Security was **not** part of the original protocol design
- **DNSSEC (DNS Security Extensions)** adds cryptographic signatures to DNS records to prevent tampering; deployment has been slow

## Related
- [[Domain Name System (DNS)]] — full DNS overview
- [[Iterative vs Recursive Queries]] — how resolution works
- [[Local Nameservers]] — the resolver a client queries first
- [[Root Nameservers]] — top of the DNS hierarchy
- [[Caching]] — how responses are cached to reduce latency
