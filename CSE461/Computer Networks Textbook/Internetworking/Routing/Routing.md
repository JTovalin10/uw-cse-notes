Switches and routers have enough knowledge of the network topology to choose the right port onto which each packet should be output.

For [[Virtual Circuit (VC)|Virtual Circuit]]s, routing becomes an issue for the connection request packet.

In [[Datagram]] networks, routing is an issue for every packet.

While [[Forwarding Table]] and routing table are used interchangeably, the routing table is built up by the routing algorithm as a precursor to building the forwarding table. The forwarding table is used when a packet is being forwarded, so it must contain enough info to accomplish the [[Forwarding]] function.

Routing is essentially a graph theory problem, as such we want to represent networks as graphs.
## Network as a Graph
The basic problem of routing is to find the lowest-cost path between any two nodes, where the cost of a path equals the sum of the costs of all the edges that make up the path. It must use an algorithm that is scalable. For this there are two main classes of routing protocols:
### Distance-Vector ([[Routing Information Protocol (RIP)|RIP]])
Also known as Bellman-Ford. Each node constructs a 1-D array containing the costs to all other nodes and distributes that vector to its immediate neighbors. It starts by assuming that each node knows the cost of the link to each of its directly connected neighbors. (A downed link has a cost of infinity.)
![[Pasted image 20260215195240.png]]

The process of getting consistent routing info to all the nodes is called [[Convergence]].

#### Sending Routing Updates
1. **Periodic update**: automatic update message sent at regular intervals even if nothing has changed
2. **Triggered update**: whenever a node notices a link failure or receives an update from one of its neighbors that causes it to change one of the routes in its routing table
3. Whenever a node's routing table changes, it sends an update to its neighbors, which may lead to a change in their tables, causing them to send an update to their neighbors

### Infinity Problem
There is a cycle where nodes increase the number of hops infinitely and the network does not stabilize—hence the infinity problem.

#### Solutions
1. **Use a small number as an approximation of infinity**
	1. Does not fix the time it would take to converge
2. **Split horizon**
	1. Fixes convergence time
	2. When a node sends a routing update to its neighbors, it does not send those routes it learned from each neighbor back to that neighbor
3. **Split horizon with poison reverse**
	1. B actually sends the route back to A, but it puts negative info in the route to ensure that A will not eventually use B to get to E

#### Distance-Vector Algorithm Steps
1. Initialize the routing table with the cost to each directly connected neighbor (infinity for all others)
2. Send the distance vector (list of `(destination, cost)` pairs) to all directly connected neighbors
3. When receiving a distance vector from neighbor N:
	1. For each destination D in the received vector:
		1. Compute `new_cost = cost_to_N + N's_cost_to_D`
		2. If `new_cost < current_cost_to_D`, update routing table: set cost to D = `new_cost`, set next hop = N
4. If the routing table changed, send the updated distance vector to all neighbors
5. Repeat from step 3 on each received update

## [[Routing Information Protocol (RIP)]]
RIP is a straightforward implementation of distance-vector routing. Routers send their advertisements every 30 seconds; a router also sends an update message whenever an update from another router causes it to change its routing table.

We want the routers to advertise the cost of reaching networks.
![[Pasted image 20260215201211.png]]

## Link State ([[Open Shortest Path First (OSPF)|OSPF]])
Starting assumptions are similar to distance-vector routing:
- Each node can find out the state of the link to its neighbors (up or down) and the cost of each link
- Goal: provide each node with enough info to find the least-cost path to any destination

**Key insight**: every node knows how to reach its directly connected neighbors. If this knowledge is disseminated to every node, then every node can build a complete map of the network — sufficient for finding the shortest path to any point.

Link-state protocols rely on two mechanisms:
1. **Reliable dissemination** of link-state information
2. **Route calculation** from the sum of all accumulated link-state knowledge

### Reliable Flooding
The process of making sure that all the nodes in the routing protocol get a copy of the link-state information from all other nodes.

**Flooding**: a node sends its link-state information out on all of its directly connected links; each node that receives this info then forwards it out on all of its links.

Each node creates an update packet called a [[Link-State Packet (LSP)]]:
1. ID of the node that created the LSP
2. A list of directly connected neighbors of that node, with the cost of the link to each one
3. A sequence number
4. A [[Time to Live (TTL)]] for this packet

The first two are needed to enable route calculation and the last two are used to make the process of flooding the packet to all nodes reliable—you have the most recent copy of the info.

### Flooding Process
- Transmission of LSPs between adjacent routers is made reliable using [[Acknowledgment (ACK)|ACKs]] and retransmissions (just like reliable link-layer protocols)

When node X receives an LSP from some other node Y:
1. If X has **no stored copy** from Y → store the LSP
2. If X **already has a copy** → compare sequence numbers:
	- New LSP has a **larger** seq number → replace old with new (it's more recent)
	- New LSP has a **smaller or equal** seq number → discard it (it's stale)
3. If the received LSP was newer → X forwards a copy to **all neighbors except** the one it received it from
	- not sending it back helps terminate the flooding
	- since every node repeats this process, the most recent LSP eventually reaches all nodes

![[Pasted image 20260215203231.png]]

The newest info must be flooded to all nodes ASAP while old info must be removed from the network and not allowed to circulate. We also want to minimize the total amount of routing traffic that is sent around the network.
1. Avoid generating LSPs unless absolutely necessary
	1. Use timers

To make sure old info is replaced by newer info, LSPs carry sequence numbers. Each time a node generates an LSP, the sequence number is incremented by 1.

LSPs also carry a [[Time to Live (TTL)|TTL]]. When the TTL reaches 0, the node refloods the LSP, which is interpreted by all the nodes in the network as a signal to delete that LSP.

## Route Calculation
Once a given node has a copy of the LSP from every other node, we perform topological algorithms. We use a forward search algorithm which is a modification of Dijkstra's, where we maintain two lists: **Tentative** and **Confirmed**. Each list contains a set of entries of the form `(Destination, Cost, NextHop)`.

#### Algorithm:
- Initialize the `Confirmed` list with an entry for myself; this entry has a cost of 0.

- For the node just added to the `Confirmed` list in the previous step, call it node `Next` and select its LSP.

- For each neighbor (`Neighbor`) of `Next`, calculate the cost (`Cost`) to reach this `Neighbor` as the sum of the cost from myself to `Next` and from `Next` to `Neighbor`.

    1. If `Neighbor` is currently on neither the `Confirmed` nor the `Tentative` list, then add `(Neighbor, Cost, NextHop)` to the `Tentative` list, where `NextHop` is the direction I go to reach `Next`.

    2. If `Neighbor` is currently on the `Tentative` list, and the `Cost` is less than the currently listed cost for `Neighbor`, then replace the current entry with `(Neighbor, Cost, NextHop)`, where `NextHop` is the direction I go to reach `Next`.

- If the `Tentative` list is empty, stop. Otherwise, pick the entry from the `Tentative` list with the lowest cost, move it to the `Confirmed` list, and return to step 2.

![[Pasted image 20260215203845.png]]

## The [[Open Shortest Path First (OSPF)]] Protocol
One of the most widely used link-state routing protocols. OSPF adds the following features to the basic link-state algorithm:
1. **Authentication of routing messages** — Distributed routing algorithms disperse information from one node to many other nodes, and the entire network can be impacted by bad information from one node. Authenticating routing messages helps ensure all participating nodes can be trusted. Early versions of OSPF used a simple 8-byte password for authentication. Strong cryptographic authentication was later added.

2. **Additional hierarchy** — OSPF introduces another layer of hierarchy into routing by allowing a domain to be partitioned into *areas*. A router within a domain does not necessarily need to know how to reach every network within that domain—it may only need to know how to get to the right area. This reduces the amount of information that must be transmitted to and stored in each node.

3. **Load balancing** — OSPF allows multiple routes to the same place to be assigned the same cost and will cause traffic to be distributed evenly over those routes, making better use of available network capacity.

![[Pasted image 20260215204052.png]]

OSPF must advertise how to reach networks. A router generates two types of advertisements:
1. **Network advertisements** — the networks directly connected to the router
2. **Link cost advertisements** — the cost of reaching a neighboring router over a link

These enable all routers in a domain to determine the cost of reaching all networks and the appropriate next hop.

![[Pasted image 20260215204155.png]]

### Type 1 [[Link-State Advertisement (LSA)]] Fields
- `Link state ID` and `Advertising router` — identical; both carry a 32-bit router identifier
	- must be unique in the routing domain and consistent for a given router
	- common strategy: use the lowest IP address among all the router's interfaces
- `LS sequence number` — detects old or duplicate LSAs
- `LS checksum` — verifies data integrity ([[Checksum]])
	- covers all fields except `LS Age`, so no recomputation needed when `LS Age` increments
- `Length` — length in bytes

## Metrics
Delay = (depart_time - arrival_time) + transmission_time + latency
