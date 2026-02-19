A straightforward implementation of [[Distance-Vector Routing]].

Routers advertise the cost of reaching networks (not just other routers).

![[Pasted image 20260215201211.png]]

## Behavior

- Routers send distance vector advertisements every **30 seconds**
- A triggered update is also sent whenever a router's routing table changes
- Uses **hop count** as the cost metric
- Maximum of **15 hops** — a cost of 16 is treated as infinity (unreachable)

See also: [[Routing]], [[Distance-Vector Routing]]
