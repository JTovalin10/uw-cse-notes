Also known as **Bellman-Ford**. Each node constructs a 1-D array (distance vector) containing the costs to all other nodes and distributes that vector to its immediate neighbors.

Each node starts by knowing the cost of the link to each directly connected neighbor. A downed link has a cost of infinity.

![[Pasted image 20260215199240.png]]

The process of getting consistent routing info to all nodes is called [[Convergence]].

See also: [[Routing]], [[Routing Information Protocol (RIP)]]

## Sending Routing Updates

1. **Periodic update** — automatic update sent at regular intervals even if nothing has changed
2. **Triggered update** — sent whenever a node notices a link failure or receives an update that causes it to change its routing table
3. Whenever a node's routing table changes, it sends an update to its neighbors, which may cascade further

## Infinity Problem

A cycle where nodes increment hop counts indefinitely and the network never stabilizes.

### Solutions

1. **Use a small number as infinity** (e.g., 16 in RIP)
	- Does not fix convergence time
2. **Split horizon**
	- When sending a routing update to a neighbor, do not advertise routes learned *from* that neighbor back to it
	- Fixes convergence time
3. **Split horizon with poison reverse**
	- Send routes back to the neighbor they were learned from, but mark them with infinite cost — prevents the neighbor from ever routing back through this node to reach that destination

## Algorithm Steps

1. Initialize the routing table with the cost to each directly connected neighbor (infinity for all others)
2. Send the distance vector (list of `(destination, cost)` pairs) to all directly connected neighbors
3. When receiving a distance vector from neighbor N:
	1. For each destination D in the received vector:
		1. Compute `new_cost = cost_to_N + N's_cost_to_D`
		2. If `new_cost < current_cost_to_D`, update routing table: set cost to D = `new_cost`, set next hop = N
4. If the routing table changed, send the updated distance vector to all neighbors
5. Repeat from step 3 on each received update
