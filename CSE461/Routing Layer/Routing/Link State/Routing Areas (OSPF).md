# Routing Areas (OSPF)

Partitioning a routing domain into subdomains called **areas** adds hierarchy so single domains can grow larger without overburdening routing protocols or resorting to interdomain routing.

**Area**: A set of routers that are administratively configured to exchange link-state information with each other.

## [[OSPF Area 0 (Backbone)|Area 0 (Backbone)]]

[[OSPF Area 0 (Backbone)|Area 0]] is the backbone area — the area to which all other areas connect. This does not mean areas only connect to the backbone.

![[Pasted image 20260228225922.png]]

As shown in the image, R1 is a member of both area 1 and 2. A router that is a member of both the [[OSPF Area 0 (Backbone)|backbone]] area and a non-backbone area is called an **[[Area Border Router (ABR)]]**.

## How flooding works within areas

Within a single area, we use routing protocols found in [[CSE461/Routing Layer/Routing|Routing]]. All routers in the area send link-state advertisements to each other and develop a complete, consistent map of the area. However, if they are not area border routers, the link-state advertisements do not leave the area they originated from. This makes flooding and route calculation more scalable.

R4 in area 3 will never see a link-state advertisement from area 1. The question: **how does a router in one area determine the right next hop for a packet destined to a network in another area?**

## Packet path across areas

The path of a packet traveling from one non-backbone area to another can be split into three parts:

1. It travels from its source network to the [[OSPF Area 0 (Backbone)|backbone]] area
2. It crosses the [[OSPF Area 0 (Backbone)|backbone]]
3. It travels from the [[OSPF Area 0 (Backbone)|backbone]] to the destination network

[[Area Border Router (ABR)|Area border routers]] **summarize** routing information — they advertise aggregated prefixes (e.g., a /16) to other areas, not every individual subnet, reducing flooding and table size.

## Virtual Links

To more flexibly decide which routers go in area 1, we use **[[OSPF Virtual Link|virtual links]]**. A [[OSPF Virtual Link|virtual link]] is obtained by configuring a router that is not directly connected to [[OSPF Area 0 (Backbone)|area 0]] to exchange backbone routing information.

## See also

- [[CSE461/Routing Layer/Routing/Link State/Open Shortest Path First (OSPF)]] — the link-state protocol used within areas
- [[CSE461/Routing Layer/Routing/Link State/Link State Routing]] — link-state fundamentals
