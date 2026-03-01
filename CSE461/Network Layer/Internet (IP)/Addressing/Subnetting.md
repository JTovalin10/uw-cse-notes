Subnetting reduces the total number of network numbers that need to be assigned. A single IP network number is divided among several physical networks (subnets), giving the illusion of one network to outside routers — they only need one route to reach any of the subnets.

## Subnet Mask

The [[Subnet Mask]] is the mechanism that enables this. Every node on a subnet is configured with a subnet mask, which extracts the **subnet number** from an [[IP Address]] via bitwise AND. All hosts on the same physical network share the same subnet number.

![[Pasted image 20260215023104.png]]
![[Pasted image 20260215023143.png]]

## Sending

When a host wants to send to an IP address, it ANDs the destination address with its own subnet mask to get the destination's subnet number:
- **Same subnet number** → destination is local, deliver directly
- **Different subnet number** → forward to a [[Router]]

The [[Forwarding Table]] is extended with a **SubnetMask** field so routers can correctly match destinations to table entries.

## How to Assign Subnets (VLSM)

Use **Variable Length Subnet Masking (VLSM)** — assign the largest subnet first so address space is packed efficiently.

### Steps

1. **Sort departments by host count** — largest to smallest
2. **Find the subnet size** — pick the smallest power of 2 that fits `hosts + 2` (1 network address + 1 broadcast)
3. **Determine the prefix length** — `subnet size = 2^(32 - prefix)`, so `prefix = 32 - log₂(subnet size)`
4. **Write the subnet mask** — the prefix length tells you how many leading 1-bits: `/25` → `255.255.255.128`
5. **Assign subnet numbers in order** — start from the base address, advance by the subnet size each time

### Subnet Size → Prefix Quick Reference

| Hosts Needed | Min Size (incl. net+broadcast) | Subnet Size | Prefix | Subnet Mask |
|---|---|---|---|---|
| 1–2 | 4 | 4 | /30 | 255.255.255.252 |
| 3–6 | 8 | 8 | /29 | 255.255.255.248 |
| 7–14 | 16 | 16 | /28 | 255.255.255.240 |
| 15–30 | 32 | 32 | /27 | 255.255.255.224 |
| 31–62 | 64 | 64 | /26 | 255.255.255.192 |
| 63–126 | 128 | 128 | /25 | 255.255.255.128 |
| 127–254 | 256 | 256 | /24 | 255.255.255.0 |

> **Usable hosts** = subnet size − 2 (subtract network address and broadcast address)

### Worked Example

**Given:** prefix `212.1.1.0/24` (256 addresses total)

**Departments:** A: 75 hosts, B: 35 hosts, C: 20 hosts, D: 18 hosts

| Department | Hosts Needed | Subnet Size | Usable | Subnet Mask | Subnet Number |
|---|---|---|---|---|---|
| A | 75 | 128 | 126 | 255.255.255.128 (/25) | 212.1.1.0/25 |
| B | 35 | 64 | 62 | 255.255.255.192 (/26) | 212.1.1.128/26 |
| C | 20 | 32 | 30 | 255.255.255.224 (/27) | 212.1.1.192/27 |
| D | 18 | 32 | 30 | 255.255.255.224 (/27) | 212.1.1.224/27 |

**How the subnet numbers are derived:**
- A starts at `.0`, size 128 → occupies `.0`–`.127`
- B starts at `.128`, size 64 → occupies `.128`–`.191`
- C starts at `.192`, size 32 → occupies `.192`–`.223`
- D starts at `.224`, size 32 → occupies `.224`–`.255`
- Total used: 128 + 64 + 32 + 32 = **256** — exactly fills the /24

See also: [[IP Address]], [[IP Global Addresses]], [[Classless Interdomain Routing (CIDR)]], [[IP Datagram Forwarding]]
