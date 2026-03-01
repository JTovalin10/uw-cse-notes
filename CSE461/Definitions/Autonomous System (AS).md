# Autonomous System (AS)

Collection of routers under one administrative authority. Internet organized as ASes for hierarchy and scalability.

## Key points

- **AS number** — 32-bit ID, assigned by **IANA** (Internet Assigned Numbers Authority); used by [[Border Gateway Protocol (BGP)]] to prevent loops
- Each AS runs its own intradomain protocol (e.g., [[Open Shortest Path First (OSPF)|OSPF]], [[Routing Information Protocol (RIP)|RIP]])
- Also called a **routing domain**

## AS types

| Type | Description |
|------|-------------|
| **Stub** | An AS that only carries local traffic (originates at or terminates on nodes within the AS) |
| **Multihomed stub** | Has connections to more than one other AS but refuses to carry transit traffic |
| **Transit** | Has connections to more than one other AS and is designed to carry both transit and local traffic |

## Traffic types

- **Local traffic**: Traffic that originates at or terminates on nodes within the AS
- **Transit traffic**: Traffic that passes through the AS

## Key roles

- **Border Router**: An IP router that forwards packets between ASes. Connects one AS to another.
- **BGP Speaker**: A router that speaks BGP to other BGP speakers in other ASes. Advertises reachability information (which IP prefixes are reachable via this AS).

## Routing terminology

- **Intradomain** — within one AS (e.g., OSPF, RIP)
- **Interdomain** — between ASes (e.g., BGP)

## See also

- [[Border Gateway Protocol (BGP)]] — the interdomain routing protocol used between ASes
- [[Internet Service Provider (ISP)]] — many ISPs operate as ASes
- [[AS Relationships and Policies]] — [[AS Relationships and Policies#Provider–Customer|provider policy]], [[AS Relationships and Policies#Customer–Provider|customer policy]], [[AS Relationships and Policies#Peer|peer policy]]
- [[Integrating iBGP and eBGP]] — integration with intradomain routing
