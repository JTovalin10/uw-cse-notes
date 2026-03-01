Trades more computation than [[Distance-Vector Routing]] for better dynamics. This is the modern approach. (moderate scalability but fast convergence)

Each node already knows how to reach its directly connected neighbors. If this knowledge is disseminated to every node, then every node can build a complete map of the network — sufficient to find the shortest path to any destination.

## Starting Assumptions

- Each node can find out the state of its links to neighbors (up/down) and the cost of each link
- Goal: provide every node with enough info to find the least-cost path to any destination

## Link-State Packet (LSP)

Each node creates an update packet called a [[Link-State Packet (LSP)]] containing:
1. ID of the node that created the LSP
2. List of directly connected neighbors with the cost to each
3. A sequence number
4. A [[CSE461/Definitions/Time to Live (TTL)]]

Fields 1–2 enable route calculation. Fields 3–4 make flooding reliable and help ensure nodes hold the most recent copy.

## Phase 1: Topology Dissemination

Each node floods its [[Link-State Packet (LSP)|LSP]] to all directly connected links; each receiving node forwards it out on all of its own links. After all LSPs propagate, every node has a complete picture of the network.

Transmission between adjacent routers is made reliable using [[Acknowledgment (ACK)|ACKs]] and retransmissions.

### Receiving an LSP

When node X receives an LSP from node Y:
1. If X has **no stored copy** from Y → store and forward
2. If X **already has a copy** → compare sequence numbers:
	- **Larger** seq number → replace with the newer copy and forward
	- **Smaller or equal** seq number → discard (stale)
3. Forward newer LSPs to **all neighbors except** the one it arrived from

### Keeping Info Fresh

- Avoid generating LSPs unless necessary — use timers
- Sequence number increments by 1 each time, so newer info always wins
- LSPs carry a [[CSE461/Definitions/Time to Live (TTL)|TTL]]; when TTL reaches 0 the node refloods, signaling all nodes to delete that entry

### Worst-Case Convergence

In the worst case (a linear chain of N nodes), an LSP must traverse **N − 1 hops** to reach every node. More generally, convergence time is bounded by the **diameter** of the network.

**Example — Node E's LSP flooded to A, B, C, D, and F:**

| Neighbor | Seq. # |
| -------- | ------ |
| A        | 10     |
| B        | 4      |
| C        | 1      |
| D        | 2      |
| F        | 2      |

![[Pasted image 20260215203231.png]]
![[Address Prefix Assignments for IPv6.png]]

## Phase 2: Route Computation

After flooding, each node has the full topology by combining all received LSPs. Each node then independently runs Dijkstra:
- Some replicated computation across nodes, but each finds its required routes directly
- Compile the forwarding table from the resulting sink/source tree

![[BGP, IGP, and combined routing table.png]]

## Handling Changes

On any topology change, the affected nodes flood updated LSPs and all nodes re-compute their routes.

- **Link failure** — both endpoints notice and send updated LSPs; the link is removed from the topology
- **Node failure** — all neighbors notice a link has failed; the failed node can't update its own LSP, but that's fine because all links *to* it are removed by its neighbors

**Example — node G fails:**

B and F detect the failure and flood new LSPs with G marked as ∞:

| B's LSP  |        | F's LSP  |        |
| -------- | ------ | -------- | ------ |
| Neighbor | Seq. # | Neighbor | Seq. # |
| A        | 4      | B        | 3      |
| C        | 2      | E        | 2      |
| E        | 4      | G        | ∞      |
| F        | 3      |          |        |
| G        | ∞      |          |        |

![[Interdomain and Intradomain Routing.png]]

## Complications
1. seq number reaches max or corrupted
2. node crashes and loses seq number
3. network partitions then heals
### Strategy
include age on LSP and forget old information that is not refreshed

See also: [[Routing]], [[Route Calculation]], [[CSE461/Routing Layer/Routing/Link State/Open Shortest Path First (OSPF)]]
