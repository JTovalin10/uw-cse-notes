Switches and routers have enough knowledge of the network topology to choose the right port onto which each packet should be output.

For [[Virtual Circuit (VC)|Virtual Circuit]]s, routing becomes an issue for the connection request packet.

In [[Datagram]] networks, routing is an issue for every packet.

While [[Forwarding Table]] and routing table are used interchangeably, the routing table is built up by the routing algorithm as a precursor to building the forwarding table. The forwarding table is used when a packet is being forwarded, so it must contain enough info to accomplish the [[Forwarding]] function.

Routing is essentially a graph theory problem — we represent the network as a graph and find the lowest-cost path between any two nodes, where the cost of a path equals the sum of the edge costs.

## Topics

### [[Distance-Vector Routing]]
- [[Distance-Vector Routing]] — Bellman-Ford, convergence, infinity problem
- [[Routing Information Protocol (RIP)]] — distance-vector in practice (30s updates, 15-hop limit)

### Link State
- [[Link State Routing]] — reliable flooding, LSPs
- [[Route Calculation]] — Dijkstra's forward search algorithm
- [[Open Shortest Path First (OSPF)]] — link-state in practice

### Other
- [[Routing Metrics]] — how link cost is measured
