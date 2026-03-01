# BGP Mechanics

BGP details beyond the high-level policy in [[Border Gateway Protocol (BGP)]]. BGP makes no assumptions about how [[Autonomous System (AS)|AS]] are interconnected and forms an arbitrary graph.

## Traffic types

- **Local traffic**: Traffic that originates at or terminates on nodes within an [[Autonomous System (AS)|AS]]
- **Transit traffic**: Traffic that passes through an [[Autonomous System (AS)|AS]]

## AS types

| Type | Description |
|------|-------------|
| **Stub** | An [[Autonomous System (AS)|AS]] that only carries local traffic |
| **Multihomed stub** | Has connections to more than one other [[Autonomous System (AS)|AS]] but refuses to carry transit traffic |
| **Transit** | Has connections to more than one other [[Autonomous System (AS)|AS]] and is designed to carry both transit and local traffic |

## Key roles

- **Border Router**: An IP router that forwards packets between [[Autonomous System (AS)|AS]]
- **BGP Speaker**: A router that speaks BGP to other BGP speakers in other [[Autonomous System (AS)|AS]]

## [[Path Vector]]

BGP does not belong to [[Distance-Vector Routing]] nor [[Link State Routing]]. It advertises **complete paths** as an enumerated list of [[Autonomous System (AS)|AS]] to each particular network.

![[Pasted image 20260228233817.png]]

Assume that providers are transit networks while customer networks are stubs. A BGP speaker for the [[Autonomous System (AS)|AS]] of provider A (AS 2) would advertise reachability for each network assigned to customers P and Q. The backbone, on receiving this advertisement, can advertise: "Networks 128.96, 192.4.153, 192.4.32, and 192.4.3 can be reached along the path (AS 1, AS 2)."

A speaker, when given multiple choices, chooses the best one according to its own local policies and advertises that route. A BGP speaker does not need to advertise any route to a destination even if it has one.

## Withdrawn routes

Upon link failures or policy changes, speakers need to cancel previously advertised paths. This is done with a **withdrawn route** — a form of negative advertisement. Both positive and negative reachability information are carried in a BGP update message.

![[Pasted image 20260228234457.png]]

## Packet format

To prevent loops, BGP must carry an [[Autonomous System (AS)|AS]] number that is unique so it can recognize itself. The AS number is 32 bits long and assigned by a central authority (e.g., IANA) to assure uniqueness.

## BGP over TCP

BGP runs on top of [[Transmission Control Protocol (TCP)|TCP]] so speakers can rely on reliability. If nothing has changed, a speaker only needs to send an occasional keepalive message so they know when a router dies.

## See also

- [[Border Gateway Protocol (BGP)]] — [[Border Gateway Protocol (BGP)#Sending (path preference when forwarding)|path preference]] and [[Border Gateway Protocol (BGP)#Export policy (who do we advertise routes to?)|export policy]]
- [[AS Relationships and Policies]] — [[AS Relationships and Policies#Provider–Customer|provider policy]], [[AS Relationships and Policies#Customer–Provider|customer policy]], [[AS Relationships and Policies#Peer|peer policy]]
- [[Integrating iBGP and eBGP]] — how BGP integrates with intradomain routing
