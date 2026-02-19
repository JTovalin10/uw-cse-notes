Starting assumptions are similar to [[Distance-Vector Routing]]:
- Each node can find out the state of its links to neighbors (up/down) and the cost of each link
- Goal: provide every node with enough info to find the least-cost path to any destination

**Key insight**: every node already knows how to reach its directly connected neighbors. If this knowledge is disseminated to every node, then every node can build a complete map of the network — sufficient to find the shortest path to any destination.

Link-state protocols rely on two mechanisms:
1. **Reliable dissemination** of link-state information
2. **Route calculation** from the accumulated link-state knowledge

See also: [[Routing]], [[Route Calculation]], [[Open Shortest Path First (OSPF)]]

## Reliable Flooding

The process of making sure that all nodes receive a copy of link-state information from all other nodes.

**Flooding**: a node sends its link-state info out on all directly connected links; each receiving node then forwards it out on all of its own links.

## Link-State Packet (LSP)

Each node creates an update packet called a [[Link-State Packet (LSP)]] containing:
1. ID of the node that created the LSP
2. List of directly connected neighbors with the cost to each
3. A sequence number
4. A [[CSE461/Definitions/Time to Live (TTL)]]

Fields 1–2 enable route calculation. Fields 3–4 make flooding reliable and help ensure nodes hold the most recent copy.

## Flooding Process

Transmission of LSPs between adjacent routers is made reliable using [[Acknowledgment (ACK)|ACKs]] and retransmissions.

When node X receives an LSP from node Y:
1. If X has **no stored copy** from Y → store the LSP
2. If X **already has a copy** → compare sequence numbers:
	- New LSP has a **larger** seq number → replace old with new (more recent)
	- New LSP has a **smaller or equal** seq number → discard it (stale)
3. If the received LSP was newer → forward it to **all neighbors except** the one it arrived from
	- Not sending it back helps terminate flooding
	- Since every node repeats this process, the most recent LSP eventually reaches all nodes

![[Pasted image 20260215203231.png]]

### Keeping Info Fresh

- Avoid generating LSPs unless necessary — use timers
- Each time a node generates an LSP, its sequence number is incremented by 1, so newer info always wins
- LSPs carry a [[CSE461/Definitions/Time to Live (TTL)|TTL]]; when TTL reaches 0 the node refloods the LSP, signaling all nodes to delete that entry
