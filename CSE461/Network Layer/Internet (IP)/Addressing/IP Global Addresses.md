Every host in an internetwork must have a globally unique [[IP Address]]. Addresses are **hierarchical** — split into a network part and a host part — so routers only need to track networks, not individual hosts.

### Old Classful Addressing

All addresses are 32 bits. The leading bits determine the class, which fixes the network/host split. This gave flexibility for networks of different sizes.

| Class | Leading Bits | Network Bits | Host Bits | # Networks | # Hosts per Network |
|---|---|---|---|---|---|
| A | 0 | 7 | 24 | 128 | 16,777,214 |
| B | 10 | 14 | 16 | 16,384 | 65,534 |
| C | 110 | 21 | 8 | 2,097,152 | 254 |

- **Class A** (`0.0.0.0 – 127.255.255.255`): few networks, each with a huge number of hosts. For large organizations.
- **Class B** (`128.0.0.0 – 191.255.255.255`): moderate number of networks, up to ~65K hosts each. For mid-size organizations.
- **Class C** (`192.0.0.0 – 223.255.255.255`): many networks, up to 254 hosts each. For small organizations.

Host counts subtract 2 from the theoretical max: the all-0s address identifies the network itself, and the all-1s address is the broadcast address.

This classful scheme was replaced by [[Classless Interdomain Routing (CIDR)]] because it wasted address space — a Class B network with only 256 hosts leaves ~65K addresses unused.

![[Pasted image 20260215022012.png]]

See also: [[IP Address]], [[Subnetting]], [[Classless Interdomain Routing (CIDR)]], [[IP Datagram Forwarding]]
