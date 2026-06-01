# iBGP and eBGP

Two variants of [[Border Gateway Protocol (BGP)]] distinguished by where they run:

| Variant | Scope | Between |
|---------|-------|---------|
| **eBGP** (exterior BGP) | Between [[Autonomous System (AS)|AS]] | BGP speakers in different ASes |
| **iBGP** (interior BGP) | Within an AS | BGP speakers in the same AS |

## Why iBGP?

Backbone networks learn huge amounts of routing info from BGP. Injecting 10,000+ prefixes into the intradomain protocol (OSPF, RIP) would overwhelm it. **iBGP** redistributes BGP-learned routes to all routers in the AS without using the intradomain protocol for that data.

## Key points

- **eBGP** — runs between ASes; learns routes from other ASes
- **iBGP** — runs within an AS; spreads BGP routes to all routers so any router knows the best border router for each prefix

## See also

- [[Border Gateway Protocol (BGP)]] — overview
- [[Integrating iBGP and eBGP]] — [[Integrating iBGP and eBGP#Backbone networks and iBGP|how they work together]]
- [[Autonomous System (AS)]]
