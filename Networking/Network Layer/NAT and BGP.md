# Network Layer: NAT, Routing, and BGP

## 1. Network Address Translation (NAT)
NAT allows multiple devices on a private network to share a single public IP address.

### Types of NAT
- **Source NAT (SNAT)**: Replaces the private source IP with a public IP. Used for outbound internet access.
- **Destination NAT (DNAT)**: Replaces the public destination IP with a private IP. Used for Load Balancing and Port Forwarding.
- **NAPT (Port Translation)**: Maps internal `(IP, Port)` pairs to external `(Public IP, Unique Port)`. This is the most common form in homes.

### The NAT Table
| Internal IP:Port | External IP:Port | Peer IP:Port |
| :--- | :--- | :--- |
| 192.168.1.10:4433 | 203.0.113.5:1024 | 8.8.8.8:53 |

**TRIP WIRE**: NAT breaks the end-to-end principle. Protocols that embed IP addresses in the payload (like FTP or SIP) require **Application Layer Gateways (ALGs)** to function.

---

## 2. Longest Prefix Match (LPM)
Routers use LPM to select the best entry in their Forwarding Information Base (FIB).
- **Rule**: If a destination IP matches multiple entries, the one with the longest subnet mask (prefix) is chosen.
- **Implementation**: Done in hardware using **TCAM** (Ternary Content Addressable Memory) for constant-time lookups.

---

## 3. Border Gateway Protocol (BGP)
BGP is the protocol that manages routing between Autonomous Systems (AS) on the global internet.

### Core Mechanics
- **Path Vector**: BGP advertisements include the full list of AS numbers (the `AS_PATH`) the update has traversed.
- **Loop Prevention**: If an AS sees its own number in the `AS_PATH`, it rejects the update.
- **Policies (Gao-Rexford)**: BGP is not about the "shortest" path; it is about the "cheapest" or "contractually preferred" path.
  - **Customer > Peer > Provider**: You prefer routes learned from customers (who pay you) over peers (who don't) or providers (whom you pay).

### Advanced BGP Features
- **Anycast**: Advertising the same IP prefix from multiple geographic locations. BGP will route users to the "closest" instance based on network topology.
- **Blackholing**: A DDoS mitigation technique where an AS advertises a specific community string to tell neighbors to drop all traffic to a victim IP.

### Related
- [[Autonomous System (AS)]]
- [[Routing Layer - Border Gateway Protocol (BGP)]]
- [[Cloud Networking and Infrastructure#Anycast LB]]
