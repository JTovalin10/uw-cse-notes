## IP Global Addresses
We need global addresses in order to provide an addressing scheme for the [[IP Service Model]]. This means each host must have a unique address.

IP addresses must be **hierarchical**: they are made up of several parts that correspond to some sort of hierarchy in the internetwork.
1. **Network part**
	1. identifies the network to which the host is attached
	2. all hosts attached to the same network have the same network part in their IP address
2. **Host part**
	1. identifies each host uniquely on that particular network

### Old Classes of IP
All addresses are 32 bits long. This system has a lot of flexibility, allowing networks of vastly different sizes to be accommodated efficiently.

| Class | Leading Bits | Network Bits | Host Bits | # Networks | # Hosts per Network |
|-------|-------------|-------------|----------|------------|-------------------|
| A | 0 | 7 | 24 | 128 | 16,777,214 |
| B | 10 | 14 | 16 | 16,384 | 65,534 |
| C | 110 | 21 | 8 | 2,097,152 | 254 |

- **Class A** (0.0.0.0 – 127.255.255.255): very few networks, each with a huge number of hosts. Intended for large organizations.
- **Class B** (128.0.0.0 – 191.255.255.255): moderate number of networks, each supporting up to ~65K hosts. Intended for medium-to-large organizations.
- **Class C** (192.0.0.0 – 223.255.255.255): large number of networks, each with up to 254 hosts. Intended for small organizations.

Host counts subtract 2 from the theoretical max because the all-0s address identifies the network itself and the all-1s address is the broadcast address.

This classful scheme was eventually replaced by [[Classless Interdomain Routing  (CIDR)]] because it wasted address space (e.g., a Class B network with 256 hosts wastes ~65K addresses).

![[Pasted image 20260215022012.png]]

See also: [[Subnetting]], [[Classless Interdomain Routing  (CIDR)]], [[IP Datagram Forwarding]]
