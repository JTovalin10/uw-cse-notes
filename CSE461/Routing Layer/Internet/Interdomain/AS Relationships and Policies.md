# AS Relationships and Policies

Common relationship types between [[Autonomous System (AS)|AS]] and their typical export policies.

![[Pasted image 20260228234704.png]]
![[Common AS relationships.png]]

## Provider–Customer

**Providers** are in the business of connecting their customers to the rest of the Internet. A customer might be a corporation or a smaller ISP (which may have customers of its own).

- **Provider policy**: Advertise all routes I know about to my customer, and advertise routes I learn from my customer to everyone.

## Customer–Provider

- **Customer policy**: Advertise my own prefixes and routes learned from my customers to my provider, advertise routes learned from my provider to my customers, but **don't advertise routes learned from one provider to another provider.**
- That last part ensures the customer doesn't carry traffic from one provider to another — which isn't in their interests if they're paying the providers to carry traffic for them.

## Peer

A symmetrical peering between [[Autonomous System (AS)|AS]]. Two providers who view themselves as equals usually peer to get access to each other's customers without paying another provider.

- **Peer policy**: Advertise routes learned from my customers to my peer, advertise routes learned from my peer to my customers, but **don't advertise routes from my peer to any provider or vice versa.**

## See also

- [[Border Gateway Protocol (BGP)]] — [[Border Gateway Protocol (BGP)#Sending (path preference when forwarding)|path preference]] and [[Border Gateway Protocol (BGP)#Export policy (who do we advertise routes to?)|export policy]]
- [[Autonomous System (AS)]] — AS types and terminology
- [[BGP Mechanics]] — how BGP advertises path vectors
