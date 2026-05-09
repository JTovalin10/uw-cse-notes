# Infrastructure: Cloud Networking and Load Balancing

## 1. Load Balancing (L4 vs L7)
- **Layer 4 (Transport)**: Decisions based on `(IP, Port)`. Extremely fast. Does not terminate TLS. Uses **Maglev** or **Consistent Hashing** for backend selection.
- **Layer 7 (Application)**: Decisions based on HTTP path, cookies, or headers. Can perform "SSL Termination." Enables advanced features like A/B testing and WAF (Web Application Firewall) integration.

### Consistent Hashing
A technique to ensure that when a backend server is added/removed, only a small fraction of keys are remapped.
- **Ring Hash**: Servers and keys are mapped to a circular space.
- **Virtual Nodes**: Prevents load imbalance by mapping one physical server to multiple points on the ring.

---

## 2. Cloud Infrastructure (VPC)
A **Virtual Private Cloud (VPC)** is a private network logically isolated within a public cloud provider.
- **Subnets**: IP ranges within a VPC. Can be Public (has a route to an Internet Gateway) or Private.
- **Route Tables**: Define where traffic is sent (Local, IGW, VPN, or VPC Peering).
- **Security Groups**: Stateful firewalls at the Instance level.
- **NACLs (Network ACLs)**: Stateless firewalls at the Subnet level.
- **GCP Andromeda**: Google's SDN that uses a distributed control plane to program software switches (OVS) on host machines, providing massive scale and low latency.

---

## 3. Cloudflare-Specific Technologies
- **Anycast LB**: Cloudflare uses Anycast to route users to the nearest data center. All data centers announce the same IP.
- **Workers**: Serverless code (V8 Isolates) running at the edge.
- **GRE/IPIP Tunneling**: Used to encapsulate traffic from the edge to the customer's origin server.
- **BGP Flowspec**: An extension to BGP that allows disseminating traffic filtering rules (DDoS mitigation) across the internet.

### Related
- [[CSE461/Routing Layer/Anycast]]
- [[CSE461/Application/Content Distribution Networks (CDN)]]
