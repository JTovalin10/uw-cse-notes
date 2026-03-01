# Multicast Overview

## What is IP multicast?

- One-to-many or many-to-many communication at IP scale
- Sender sends **one** packet to a group address; [[Router|routers]] duplicate as needed
- Contrast with **unicast** (one-to-one) — traditional [[Internet Protocol (IP)|IP]]

## Why multicast?

- **Unicast problem**: Sending to N receivers = N separate packets, all near the sender → wastes bandwidth, can overwhelm sender
- **Multicast**: Single packet; routers copy only at branch points → scalable

## Applications

| Type | Examples |
|------|----------|
| One-to-many | Radio over Internet, IPTV, software updates, stock prices |
| Many-to-many | Videoconferencing, multiplayer gaming, distributed simulation |

## Basic model

- **Multicast group** = set of receivers
- **Multicast address** = IP address for the group (not a host)
- Host can join/leave groups freely
- **Any host** can send to a group (doesn't have to be a member)
- Membership changes dynamically

## Service models

- **Any Source Multicast (ASM)** — original; any host can send
- **Source-Specific Multicast (SSM)** — receiver specifies both group and source; one-to-many

## See also

- [[Multicast Addresses]] — IPv4/IPv6 mapping, Ethernet
- [[IGMP and MLD]] — how hosts join/leave
- [[Multicast Routing]] — DVMRP, PIM, MSDP
