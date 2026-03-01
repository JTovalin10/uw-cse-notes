NDP is the protocol responsible for resolving an **IPv6 L3 address to an L2 address** — it is the IPv6 equivalent of [[IP Address Resolution Protocol (ARP)|ARP]].

## Layer Address Terminology

| Layer | Name | Example |
|---|---|---|
| **L2** (Link Layer) | Hardware / MAC address | `00:1A:2B:3C:4D:5E` — 48-bit Ethernet address, identifies a NIC on a local network |
| **L3** (Network Layer) | IPv6 address | `2001:0db8::1` — 128-bit address, identifies a host across networks |

When delivering a packet on a local network, the device knows the destination **L3 (IPv6) address** but needs the **L2 (MAC) address** to transmit the frame. NDP resolves this mapping.

## How NDP Works

NDP is part of **ICMPv6** (unlike ARP which sits directly above the link layer). It uses **multicast** rather than broadcast (more efficient on large networks).

### Key Messages

| Message | Purpose |
|---|---|
| **Neighbor Solicitation (NS)** | "Who has this IPv6 address?" — sent to a solicited-node multicast address |
| **Neighbor Advertisement (NA)** | Reply with the sender's MAC address |

### Process

1. Node wants to send to an IPv6 address it doesn't have a MAC for
2. Sends a **Neighbor Solicitation** to the solicited-node multicast group for that address
3. The target replies with a **Neighbor Advertisement** containing its L2 (MAC) address
4. Originator caches the L3 → L2 mapping and uses it

## NDP vs ARP

| | ARP | NDP |
|---|---|---|
| **IP version** | IPv4 | IPv6 |
| **Layer** | Directly above L2 | Part of ICMPv6 (L3) |
| **Discovery method** | Broadcast | Multicast |
| **Address resolved** | 32-bit IPv4 → MAC | 128-bit IPv6 → MAC |

## Additional Functions

NDP also handles:
- **Router Discovery** — hosts find routers on the local link
- **Stateless Address Autoconfiguration (SLAAC)** — hosts configure their own IPv6 address without DHCP
- **Duplicate Address Detection (DAD)** — ensures no two hosts use the same IPv6 address

See also: [[IP Address Resolution Protocol (ARP)]], [[IPv6]]
