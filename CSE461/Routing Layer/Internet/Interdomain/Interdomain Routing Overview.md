# Interdomain Routing Overview

## Structure of the Internet

- Networks (ISPs, CDNs, etc.) group hosts as IP prefixes
- Networks are richly interconnected, often using IXPs (Internet Exchange Points)

## Autonomous systems

The Internet is organized as [[Autonomous System (AS)|autonomous systems (AS)]] to hierarchically aggregate routing information and improve scalability. Each AS can run whatever intradomain routing protocol it wants.

- **Intradomain routing**: Routing within a single [[Autonomous System (AS)|AS]]
- **Interdomain routing**: Routing between [[Autonomous System (AS)|ASes]]

AS is also known as a **routing domain**.

## Intradomain Routing

Routing within our own domain. We don't want to flood other networks (we would need to pay them) and we want to keep how we route a secret.

### Goals

- Optimize the scalar cost of the path (shortest path)

## Interdomain Routing

### Goals

1. Find some path to the intended destination that is loop-free
2. Paths must be compliant with policies of the various [[Autonomous System (AS)|AS]] along the path

Finding a non-looping, policy-compliant path.

### Challenges

1. **Reachability sharing**: Different [[Autonomous System (AS)|ASes]] must share reachability information — descriptions of the set of IP addresses that can be reached via a given [[Autonomous System (AS)|AS]] — with each other.

2. **Policy autonomy**: Each [[Autonomous System (AS)|AS]] needs to determine its own routing policies. The issue becomes economic arrangements — [[Internet Service Provider (ISP)]]s want to keep their policies private because they don't want to make their economic arrangements public due to competition.

3. **Backbone requirement**: A backbone must be able to forward any packet destined anywhere in the Internet — a routing table that provides a match for any valid IP address.

4. **Policy over shortest path**: We do not always pick the optimal path; an [[Autonomous System (AS)|AS]] might not want to take it due to cost.

## Internet-wide routing challenges

1. **Scaling to very large networks** — techniques of IP prefixes, hierarchy, prefix aggregation
2. **Incorporating policy decisions** — letting different parties choose their routes to suit their own needs

### Effects of independent parties

- Each party selects routes to suit its own interest (e.g., shortest path within their [[Internet Service Provider (ISP)]])
- Selected paths are often longer than the overall shortest path, and may be asymmetric
- This is a consequence of independent goals and decisions
- See [[Routing Policies]] for how to address this

![[effects of independent parties.png]]
![[Effects of independent parties(2).png]]

## Interdomain Protocols

### Exterior Gateway Protocol (EGP)

An old protocol designed when the Internet had a tree-like design. It constrained the topology of the Internet.

### Border Gateway Protocol (BGP)

See [[Border Gateway Protocol (BGP)]] and [[BGP Mechanics]]. BGP makes no assumptions about how [[Autonomous System (AS)|AS]] are interconnected and forms an arbitrary graph.

![[BGP-4 update packet format.png]]

## See also

- [[Autonomous System (AS)]] — AS types and terminology
- [[BGP Mechanics]] — how BGP works
- [[AS Relationships and Policies]] — [[AS Relationships and Policies#Provider–Customer|provider policy]], [[AS Relationships and Policies#Customer–Provider|customer policy]], [[AS Relationships and Policies#Peer|peer policy]]
