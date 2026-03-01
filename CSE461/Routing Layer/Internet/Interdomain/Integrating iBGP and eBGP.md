# Integrating iBGP and eBGP

How interdomain routing (BGP) integrates with intradomain routing inside an [[Autonomous System (AS)|AS]]. [[iBGP and eBGP|eBGP]] runs between AS; [[iBGP and eBGP|iBGP]] runs within an AS.

## Stub AS (simplest)

A stub [[Autonomous System (AS)|AS]] that only connects to other autonomous systems at a single point: the border router is the only choice for all routes outside the [[Autonomous System (AS)|AS]].
- The border router injects a **default route** into the intradomain routing protocol.
- Effect: "Any network not explicitly advertised in the intradomain protocol is reachable through the border router."

## Injecting specific routes

The next step: border routers inject specific routes they have learned from outside the [[Autonomous System (AS)|AS]].

Example: The border router of a provider [[Autonomous System (AS)|AS]] that connects to a customer [[Autonomous System (AS)|AS]] learns that prefix 192.4.54/24 is inside the customer AS (via BGP or configuration). It injects a route to that prefix into the intradomain protocol: "I have a link to 192.4.54/24 of cost X." Other routers in the provider AS learn that this border router is the place to send packets destined for that prefix.

## Backbone networks and iBGP

Backbone networks learn so much routing information from BGP (the full table has ~1M prefixes; even 10,000+ is common) that injecting it all into the intradomain protocol is too costly. If a border router injects 10,000 prefixes, it would send very large link-state packets and shortest-path calculations would become complex.

**Solution**: Routers in a backbone use **[[iBGP and eBGP|interior BGP (iBGP)]]** to redistribute information learned by BGP speakers at the edges of the [[Autonomous System (AS)|AS]] to all other routers in the [[Autonomous System (AS)|AS]]. (The variant that runs between AS is **[[iBGP and eBGP|exterior BGP (eBGP)]]**.)

- iBGP enables any router in the [[Autonomous System (AS)|AS]] to learn the best border router to use when sending a packet to any address.
- Each router keeps track of how to get to each border router using a conventional intradomain protocol (no injected BGP info).
- By combining these two sets of information, each router determines the appropriate next hop for all prefixes.

![[Pasted image 20260228235108.png]]![[Pasted image 20260228235137.png]]

## See also

- [[Border Gateway Protocol (BGP)]] — BGP overview
- [[BGP Mechanics]] — path vector, AS types
- [[Routing Areas (OSPF)]] — intradomain scaling within an AS
