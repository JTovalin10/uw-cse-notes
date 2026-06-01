# CSE461: Routing

**Routing** is the background process of building and maintaining [[Forwarding Table]]s so that switches know where to send packets. Separate from **[[Forwarding|forwarding]]** (the actual act of sending a packet out the right port), routing is the control-plane process that figures out *which* port is right.

## Related
- [[Forwarding]] — the data-plane action that uses the tables routing builds
- [[Forwarding Table]] — the structure routing maintains
- [[Routing Layer - Intradomain Routing (DV and LS)]] — DV and LS routing algorithms
- [[Routing Layer - Border Gateway Protocol (BGP)]] — interdomain routing
- [[Convergence]] — when all routers agree on routes
