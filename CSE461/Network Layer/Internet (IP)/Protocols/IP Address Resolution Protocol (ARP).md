**Problem**: when forwarding a packet, how does a node know the link-layer address of the destination?

A node knows the destination [[IP Address]], but to actually deliver a frame on a local network it needs the corresponding link-layer address (e.g., an Ethernet [[Media Access Control (MAC)|MAC]] address). ARP bridges this gap.

## Approaches

1. **Encode the physical address in the IP address** — limited by address class bit widths, not practical
2. **Maintain a dynamic mapping table** — each host learns IP-to-link-layer mappings from the network at runtime. This is ARP.

## How ARP Works
ARP is right on top of the link layer
- no servers, just asks node with target IP to id itself
- uses broadcase to reach all nodes

ARP maintains a local **cache** of IP → link-layer address mappings. On a lookup:

1. Check the cache — if found, use it directly
2. If not found, broadcast an **ARP query** containing the target IP address
3. Every host on the network receives the query; the one with a matching IP replies with its link-layer address
4. The originator caches the mapping and uses it

Since every ARP query also contains the sender's IP and link-layer address, all receiving hosts can cache the sender's mapping as a side effect — reducing future queries.

If an entry already exists in the cache, the host refreshes it by resetting its expiration timer.
### Messages
![[Pasted image 20260218210857.png]]
## ARP Packet Fields

| Field | Description |
|---|---|
| **HardwareType** | Type of physical network (e.g., Ethernet) |
| **ProtocolType** | Higher-layer protocol (e.g., IP) |
| **HLen / PLen** | Length of the link-layer and protocol addresses, respectively |
| **Operation** | Request or response |
| **Addresses** | Source and target hardware (Ethernet) and protocol (IP) addresses |
![[Pasted image 20260215024442.png]]
See also: [[IP Address]], [[IP Global Addresses]], [[Dynamic Host Configuration Protocol (DHCP)]]
